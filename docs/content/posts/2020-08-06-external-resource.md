---
authors:
- name: Yangze Guo
  yangze: null
categories: news
date: "2020-08-06T08:00:00Z"
excerpt: This post introduces the new External Resource Framework in Flink 1.11 and
  take GPU as an example to show how to accelerate your workload with external resources.
title: Accelerating your workload with GPU and other external resources
---

Apache Flink 1.11 introduces a new [External Resource Framework]({{< param DocsBaseUrl >}}flink-docs-master/ops/external_resources.html),
which allows you to request external resources from the underlying resource management systems (e.g., Kubernetes) and accelerate your workload with
those resources. As Flink provides a first-party GPU plugin at the moment, we will take GPU as an example and show how it affects Flink applications
in the AI field. Other external resources (e.g. RDMA and SSD) can also be supported [in a pluggable manner]({{< param DocsBaseUrl >}}flink-docs-master/ops/external_resources.html#implement-a-plugin-for-your-custom-resource-type).

# End-to-end real-time AI with GPU

Recently, AI and Machine Learning have gained additional popularity and have been widely used in various scenarios, such
as personalized recommendation and image recognition. [Flink](https://flink.apache.org/), with the ability to support GPU
allocation, can be used to build an end-to-end real-time AI workflow.

## Why Flink

Typical AI workloads fall into two categories: training and inference.

<center>
<img src="{{ site.baseurl }}/img/blog/2020-08-06-accelerate-with-external-resources/ai-workflow.png" width="800px" alt="Typical AI Workflow"/>
<br/>
<i><small>Typical AI Workflow</small></i>
</center>
<br/>

The training workload is usually a batch task, in which we train a model from a bounded dataset. On the other hand, the inference
workload tends to be a streaming job. It consumes an unbounded data stream, which contains image data, for example, and uses a model
to produce the output of predictions. Both workloads need to do data preprocessing first. Flink, as a
[unified batch and stream processing engine](https://flink.apache.org/news/2019/02/13/unified-batch-streaming-blink.html), can be used to build an end-to-end AI workflow naturally.

In many cases, the training and inference workload can benefit a lot by leveraging GPUs. [Research](https://azure.microsoft.com/en-us/blog/gpus-vs-cpus-for-deployment-of-deep-learning-models/)
shows that CPU cluster is outperformed by GPU cluster, which is of similar cost, by about 400 percent. As training datasets
are getting bigger and models more complex, supporting GPUs has become mandatory for running AI workloads.

With the [External Resource Framework]({{< param DocsBaseUrl >}}flink-docs-master/ops/external_resources.html)
and its [GPU plugin]({{< param DocsBaseUrl >}}flink-docs-master/ops/external_resources.html#plugin-for-gpu-resources), Flink
can now request GPU resources from the external resource management system and expose GPU information to operators. With this
feature, users can now easily build end-to-end training and real-time inference pipelines with GPU support on Flink.

## Example: MNIST Inference with Flink

We take the MNIST inference task as an example to show how to use the [External Resource Framework]({{< param DocsBaseUrl >}}flink-docs-master/ops/external_resources.html)
and how to leverage GPUs in Flink. MNIST is a database of handwritten digits, which is usually viewed as the HelloWorld of AI.
The goal is to recognize a 28px*28px picture of a number from 0 to 9.

First, you need to set configurations for the external resource framework to enable GPU support:

```bash
external-resources: gpu
# Define the driver factory class of gpu resource.
external-resource.gpu.driver-factory.class: org.apache.flink.externalresource.gpu.GPUDriverFactory
# Define the amount of gpu resource per TaskManager.
external-resource.gpu.amount: 1
# Enable the coordination mode if you run it in standalone mode
external-resource.gpu.param.discovery-script.args: --enable-coordination


# If you run it on Yarn
external-resource.gpu.yarn.config-key: yarn.io/gpu
# If you run it on Kubernetes
external-resource.gpu.kubernetes.config-key: nvidia.com/gpu
```

For more details of the configuration, please refer to the [official documentation]({{< param DocsBaseUrl >}}flink-docs-release-1.11/ops/external_resources.html#configurations-1).

In the MNIST inference task, we first need to read the images and do data preprocessing. You can download [training](http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz)
or [testing](http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz) data from [this site](http://yann.lecun.com/exdb/mnist/).
We provide a simple [MNISTReader](https://github.com/KarmaGYZ/flink-mnist/blob/master/src/main/java/org/apache/flink/MNISTReader.java).
It will read the image data located in the provided file path and transform each image into a list of floating point numbers.

Then, we need a classifier to recognize those images. A one-layer pre-trained neural network, whose prediction accuracy is 92.14%,
is used in our classify operator. To leverage GPUs in order to accelerate the matrix-matrix multiplication, we use [JCuda](https://github.com/jcuda/jcuda)
to call the native Cuda API. The prediction logic of the [MNISTClassifier](https://github.com/KarmaGYZ/flink-mnist/blob/master/src/main/java/org/apache/flink/MNISTClassifier.java) is shown below.

```java
class MNISTClassifier extends RichMapFunction<List<Float>, Integer> {
    @Override
    public void open(Configuration parameters) {
        // Get the GPU information and select the first GPU.
        final Set<ExternalResourceInfo> externalResourceInfos = getRuntimeContext().getExternalResourceInfos(resourceName);
        final Optional<String> firstIndexOptional = externalResourceInfos.iterator().next().getProperty("index");

        // Initialize JCublas with the selected GPU
        JCuda.cudaSetDevice(Integer.parseInt(firstIndexOptional.get()));
        JCublas.cublasInit();
    }

   @Override
   public Integer map(List<Float> value) {
       // Performs multiplication using JCublas. The matrixPointer points to our pre-trained model.
       JCublas.cublasSgemv('n', DIMENSIONS.f1, DIMENSIONS.f0, 1.0f,
               matrixPointer, DIMENSIONS.f1, inputPointer, 1, 0.0f, outputPointer, 1);

       // Read the result back from GPU.
       JCublas.cublasGetVector(DIMENSIONS.f1, Sizeof.FLOAT, outputPointer, 1, Pointer.to(output), 1);
       int result = 0;
       for (int i = 0; i < DIMENSIONS.f1; ++i) {
           result = output[i] > output[result] ? i : result;
       }
       return result;
   }
}
```

The complete MNIST inference project can be found [here](https://github.com/KarmaGYZ/flink-mnist). In this project, we simply
print the inference result to **STDOUT**. In the actual production environment, you could also write the result to Elasticsearch or Kafka, for example.

The MNIST inference task is just a simple case that shows you how the external resource framework works and what Flink can
do with GPU support. With Flink’s open source extension [Alink](https://github.com/alibaba/Alink), which contains a lot of
pre-built algorithms based on Flink, and [Tensorflow on Flink](https://github.com/alibaba/flink-ai-extended), some complex
AI workloads, e.g. online learning, real-time inference service, could be easily implemented as well.

# Other external resources

In addition to GPU support, there are many other external resources that can be used to accelerate jobs in some specific scenarios.
E.g. FPGA, for AI workloads, is supported by both Yarn and Kubernetes. Some low-latency network devices, like RDMA and Solarflare, also
provide their device plugin for Kubernetes. Currently, Yarn supports GPUs and FPGAs, while the list of Kubernetes’ device plugins can be found [here](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/device-plugins/#examples).

With the external resource framework, you only need to implement a plugin that enables the operator to get the information
for these external resources; see [Custom Plugin]({{< param DocsBaseUrl >}}flink-docs-release-1.11/ops/external_resources.html#implement-a-plugin-for-your-custom-resource-type)
for more details. If you just want to ensure that an external resource exists in the TaskManager, then you only need to find the
configuration key of that resource in the underlying resource management system and configure the external resource framework accordingly.

# Conclusion

In the latest Flink release (Flink 1.11), an external resource framework has been introduced to support requesting various types of
resources from the underlying resource management systems, and supply all the necessary information for using these resources to the
operators. The first-party GPU plugin expands the application prospects of Flink in the AI domain. Different resource types can be supported
in a pluggable way. You can also implement your own plugins for custom resource types.

Future developments in this area include implementing operator level resource isolation and fine-grained external resource scheduling.
The community may kick this work off once [FLIP-56](https://cwiki.apache.org/confluence/display/FLINK/FLIP-56%3A+Dynamic+Slot+Allocation)
is finished. If you have any suggestions or questions for the community, we encourage you to sign up to the Apache Flink
[mailing lists](https://flink.apache.org/community.html#mailing-lists) and join the discussion there.
