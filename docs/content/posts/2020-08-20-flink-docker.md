---
authors:
- name: Robert Metzger
  rmetzger: null
  twitter: rmetzger_
date: "2020-08-20T00:00:00Z"
excerpt: This blog post gives an update on the recent developments of Flink's support
  for Docker.
title: The State of Flink on Docker
---

With over 50 million downloads from Docker Hub, the Flink docker images are a very popular deployment option.

The Flink community recently put some effort into improving the Docker experience for our users with the goal to reduce confusion and improve usability.


Let's quickly break down the recent improvements:

- Reduce confusion: Flink used to have 2 Dockerfiles and a 3rd file maintained outside of the official repository — all with different features and varying stability. Now, we have one central place for all images: [apache/flink-docker](https://github.com/apache/flink-docker).

  Here, we keep all the Dockerfiles for the different releases. Check out the [detailed readme](https://github.com/apache/flink-docker/blob/master/README.md) of that repository for further explanation on the different branches, as well as the [Flink Improvement Proposal (FLIP-111)](https://cwiki.apache.org/confluence/display/FLINK/FLIP-111%3A+Docker+image+unification) that contains the detailed planning.

  The `apache/flink-docker` repository also seeds the [official Flink image on Docker Hub](https://hub.docker.com/_/flink).

- Improve Usability: The Dockerfiles are used for various purposes: [Native Docker deployments]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/docker.html), [Flink on Kubernetes]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/native_kubernetes.html), the (unofficial) [Flink helm example](https://github.com/docker-flink/examples) and the project's [internal end to end tests](https://github.com/apache/flink/tree/master/flink-end-to-end-tests). With one unified image, all these consumers of the images benefit from the same set of features, documentation and testing. 

  The new images support [passing configuration variables]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/docker.html#configure-options) via a `FLINK_PROPERTIES` environment variable. Users can [enable default plugins]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/docker.html#using-plugins) with the `ENABLE_BUILT_IN_PLUGINS` environment variable. The images also allow loading custom jar paths and configuration files.

Looking into the future, there are already some interesting potential improvements lined up: 

- [Java 11 Docker images](https://issues.apache.org/jira/browse/FLINK-16260) (already completed)
- [Use vanilla docker-entrypoint with flink-kubernetes](https://issues.apache.org/jira/browse/FLINK-15793) (in progress)
- [History server support](https://issues.apache.org/jira/browse/FLINK-17167)
- [Support for OpenShift](https://issues.apache.org/jira/browse/FLINK-15587)

## How do I get started?

This is a short tutorial on [how to start a Flink Session Cluster]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/docker.html#start-a-session-cluster) with Docker.

A *Flink Session cluster* can be used to run multiple jobs. Each job needs to be submitted to the cluster after it has been deployed. To deploy a *Flink Session cluster* with Docker, you need to start a *JobManager* container. To enable communication between the containers, we first set a required Flink configuration property and create a network:

```
FLINK_PROPERTIES="jobmanager.rpc.address: jobmanager"
docker network create flink-network
```

Then we launch the JobManager:

```
docker run \
       --rm \
       --name=jobmanager \
       --network flink-network \
       -p 8081:8081 \
       --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
       flink:1.11.1 jobmanager
```
and one or more *TaskManager* containers:

```
docker run \
      --rm \
      --name=taskmanager \
      --network flink-network \
      --env FLINK_PROPERTIES="${FLINK_PROPERTIES}" \
      flink:1.11.1 taskmanager
```

You now have a fully functional Flink cluster running! You can access the the web front end here: [localhost:8081](http://localhost:8081/).

Let's now submit one of Flink's example jobs:

```bash
# 1: (optional) Download the Flink distribution, and unpack it
wget https://archive.apache.org/dist/flink/flink-1.11.1/flink-1.11.1-bin-scala_2.12.tgz
tar xf flink-1.11.1-bin-scala_2.12.tgz
cd flink-1.11.1

# 2: Start the Flink job
./bin/flink run ./examples/streaming/TopSpeedWindowing.jar
```

The main steps of the tutorial are also recorded in this short screencast:

<center>
<img src="/img/blog/flink-docker/flink-docker.gif" width="882px" height="730px" alt="Demo video"/>
</center>


**Next steps**: Now that you've successfully completed this tutorial, we recommend you checking out the full [Flink on Docker documentation]({{< param DocsBaseUrl >}}flink-docs-master/ops/deployment/docker.html) for implementing more advanced deployment scenarios, such as Job Clusters, Docker Compose or our native Kubernetes integration. 


## Conclusion

We encourage all readers to try out Flink on Docker to provide the community with feedback to further improve the experience.
Please refer to the user@flink.apache.org ([remember to subscribe first](https://flink.apache.org/community.html#how-to-subscribe-to-a-mailing-list)) for general questions and our [issue tracker](https://issues.apache.org/jira/issues/?jql=project+%3D+FLINK+AND+component+%3D+flink-docker) for specific bugs or improvements, or [ideas for contributions](https://flink.apache.org/contributing/how-to-contribute.html)!
