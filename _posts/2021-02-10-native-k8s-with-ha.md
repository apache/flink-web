---
layout: post
title:  "How to natively deploy Flink on Kubernetes with HA"
date:   2021-02-10 00:00:00
authors:
- Yang Wang:
  name: "Yang Wang"
excerpt: Kubernetes provides built-in functionalities that Flink can leverage for JobManager failover. In Flink 1.12 (FLIP-144), the community implemented a Kubernetes HA service as an alternative to ZooKeeper for highly available production setups. In this blogpost, we will have a close look at how to deploy Flink applications natively on Kubernetes cluster with HA.
---

Flink has supported resource management systems like YARN and Mesos since the early days; however, these were not designed for the fast-moving cloud-native architectures that are increasingly gaining popularity these days, or the growing need to support complex, mixed workloads (e.g. batch, streaming, deep learning, web services).
For these reasons, more and more users are turning to Kubernetes to automate the deployment, scaling and management of their Flink applications.

From release to release, the Flink community has made significant progress in integrating natively with Kubernetes, from active resource management to “Zookeeperless” High Availability (HA).
In this blogpost, we will go through the technical details of deploying Flink applications natively on Kubernetes.
Then, we’ll deep dive into Flink’s Kubernetes High Availability (HA) architecture and walk through a hands-on example of running a Flink [application cluster](https://ci.apache.org/projects/flink/flink-docs-stable/concepts/glossary.html#flink-application-cluster) on Kubernetes with HA enabled.
We’ll end with a conclusion covering the advantages of running Flink on Kubernetes, and an outlook into future work.

# Native Flink on Kubernetes Architecture

Before we dive into the technical details of how the native Kubernetes integration works, let us figure out what “native” means here:
 
 1. Flink is self-contained. There will be an embedded Kubernetes client in the Flink client, and so you will not need other external tools (e.g. kubectl, Kubernetes dashboard) to create a Flink cluster on Kubernetes.
 2. The Flink client will contact the Kubernetes API server directly to create the JobManager deployment. The configuration located on the client side will be shipped to the JobManager pod, as well as the log4j and hadoop configuration.
 3. Flink’s ResourceManager will talk to the Kubernetes API server to allocate and release the TaskManager pods dynamically on-demand.

All in all, this is similar to how Flink integrates with other resource management systems (e.g. YARN, Mesos), so it should be somewhat straightforward to integrate with Kubernetes if you’ve managed such deployments  — especially so if you already have some internal deployer for the lifecycle management of multiple Flink jobs.

<center>
<img vspace="8" style="width:75%" src="{{site.baseurl}}/img/blog/2021-02-10-native-k8s-with-ha/native-k8s-architecture.png" />
</center>

# Kubernetes High Availability Service

High Availability (HA) is a common requirement when bringing Flink to production: it helps prevent a single point of failure for Flink clusters.
Previous to the 1.12 release, Flink has provided a Zookeeper HA service that has been widely used in production environments and could be integrated in standalone cluster, YARN, or Kubernetes deployments.
However, managing a Zookeeper cluster on Kubernetes for HA would require an additional operational cost that could be avoided because, in the end, Kubernetes also provides some public API for leader election and configuration storage (i.e. ConfigMap).
From Flink 1.12, we leverage these features to make running a HA-configured Flink cluster on Kubernetes more convenient to users.

<center>
<img vspace="8" style="width:75%" src="{{site.baseurl}}/img/blog/2021-02-10-native-k8s-with-ha/native-k8s-ha-architecture.png" />
</center>

The above diagram shows the architecture of Flink’s Kubernetes HA service, which works as follows:

 1. For the leader election, a set of eligible JobManagers is identified. They all race to declare themselves as the leader, with one winning and becoming the active leader. The active JobManager then continually "heartbeats" to renew its position as the leader. In the meantime, all other standby JobManagers periodically make new attempts to become the leader — this ensures that the JobManager could failover quickly. Different components (e.g. ResourceManager, JobManager, Dispatcher, RestEndpoint) have separate leader election services and ConfigMaps.
 2. The active leader publishes its address to the ConfigMap. It’s important to  note that Flink uses the same ConfigMap for contending lock and storing the leader address. This ensures that there is no unexpected change snuck in during a periodic update.
 3. The leader retrieval service is used to find the active leader’s address and allow the components to then register themselves. For example, TaskManagers retrieve the address of ResourceManager and JobManager for the registration and offering slots. Flink uses a Kubernetes watch in the leader retrieval service — once the content of ConfigMap changes, it usually means that the leader has changed, and so the listener can get the latest leader address immediately.
 4. All other meta information (e.g. running jobs, job graphs, completed checkpoints and checkpointer counter) will be directly stored in the corresponding ConfigMaps. Only the leader can update the ConfigMap. The HA data will only be cleaned up once the Flink cluster reaches the global terminal state. Please note that only the pointers are stored in the ConfigMap; the concrete data has been stored in DistributedStorage. This level of indirection is necessary to keep the amount of data in ConfigMap small (ConfigMap is built for data less than 1MB whereas state can grow to multiple GBs).

# Example: Application cluster with HA

Please note that you need a running Kubernetes cluster and to get kube config properly set to follow along.
You can use `kubectl get nodes` for verifying that you’re all set.
In this blog post, we’re using [minikube](https://minikube.sigs.k8s.io/docs/start/) for local testing.

1. Build a Docker image with the Flink job (my-flink-job.jar) baked in

        FROM flink:1.12.1
        RUN mkdir -p $FLINK_HOME/usrlib
        COPY /path/of/my-flink-job.jar $FLINK_HOME/usrlib/my-flink-job.jar

    Use the above Dockerfile to build a user image and then push it to your remote image repository.

2. Start a Flink application cluster

        $ ./bin/flink run-application -d -p 4 -t kubernetes-application \
            -Dkubernetes.cluster-id=k8s-ha-app-1 \
            -Dkubernetes.container.image=<user-image> \
            -Dkubernetes.jobmanager.cpu=0.5 -Dkubernetes.taskmanager.cpu=0.5 \
            -Dtaskmanager.numberOfTaskSlots=4 \
            -Dkubernetes.rest-service.exposed.type=NodePort \
            -Dhigh-availability=org.apache.flink.kubernetes.highavailability.KubernetesHaServicesFactory \
            -Dhigh-availability.storageDir=s3://flink-bucket/flink-ha \
            -Drestart-strategy=fixed-delay -Drestart-strategy.fixed-delay.attempts=10 \
            -Dcontainerized.master.env.ENABLE_BUILT_IN_PLUGINS=flink-s3-fs-hadoop-1.12.1.jar \
            -Dcontainerized.taskmanager.env.ENABLE_BUILT_IN_PLUGINS=flink-s3-fs-hadoop-1.12.1.jar \
            local:///opt/flink/usrlib/my-flink-job.jar

3. Access the Flink Web UI (http://minikube-ip-address:node-port) and check that the job is running

        2021-02-05 17:26:13,403 INFO  org.apache.flink.kubernetes.KubernetesClusterDescriptor      [] - Create flink application cluster k8s-ha-app-1 successfully, JobManager Web Interface: http://192.168.64.21:32388

    You could find a similar log in the Flink client and get the JobManager web interface URL.

4. Kill the JobManager to simulate failure

        kubectl exec {jobmanager_pod_name} -- /bin/sh -c "kill 1"

5. Verify that the job recovers from the latest successful checkpoint
    
    Refresh the web dashboard until the new JobManager is launched, and then search for the following JobManager logs to verify that the job recovers from the latest successful checkpoint:

        2021-02-05 09:44:01,636 INFO  org.apache.flink.runtime.checkpoint.CheckpointCoordinator    [] - Restoring job 00000000000000000000000000000000 from Checkpoint 101 @ 1612518074802 for 00000000000000000000000000000000 located at <checkpoint-not-externally-addressable>.

6. Cancel the job

    The job can be cancelled in the Flink the WebUI, or using the following command:

        ./bin/flink cancel -t kubernetes-application -Dkubernetes.cluster-id=<ClusterID> <JobID>

    When the job is cancelled, all the Kubernetes resources created by Flink (e.g. JobManager deployment, TaskManager pods, service, Flink configuration ConfigMap, leader-related ConfigMaps) will be deleted automatically.

# Conclusion

The native Kubernetes integration was first introduced in Flink 1.10, abstracting a lot of the complexities of hosting, configuring, managing and operating Flink clusters in cloud-native environments.
After three major releases, the community has made great progress in supporting multiple deployment modes (i.e. session and application) and an alternative HA setup that doesn’t depend on Zookeeper.

Compared with [standalone](https://ci.apache.org/projects/flink/flink-docs-master/deployment/resource-providers/standalone/kubernetes.html) Kubernetes deployments, the native integration is more user-friendly and requires less upfront knowledge about Kubernetes.
Given that Flink is now aware of the underlying Kubernetes cluster, it also can benefit from dynamic resource allocation and make more efficient use of Kubernetes cluster resources.
The next building block to deepen Flink’s native integration with Kubernetes is the pod template ([FLINK-15656](https://issues.apache.org/jira/browse/FLINK-15656)), which will greatly enhance the flexibility of using advanced Kubernetes features (e.g. volumes, init container, sidecar container).
This work is already in progress and will be added in the upcoming 1.13 release!
