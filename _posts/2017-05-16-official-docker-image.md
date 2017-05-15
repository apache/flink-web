---
layout: post
title:  "Introducing official Docker images for Apache Flink"
date:   2017-05-16 09:00:00
author: "Patrick Lucas (Data Artisans) and Ismaël Mejía (Talend)"
author-twitter: "iemejia"
categories: news
---

For some time, the Apache Flink community has provided scripts to build a Docker image to run Flink. Now, starting with version 1.2.1, Flink will have an [official Docker image](https://hub.docker.com/r/_/flink/). This image is maintained by the Flink community and curated by the [Docker](https://github.com/docker-library/official-images) team to ensure it meets the quality standards for container images of the Docker community.

A community-maintained way to run Apache Flink on Docker and other container runtimes and orchestrators is part of the ongoing effort by the Flink community to make Flink a first-class citizen of the container world.

{:refdef: style="text-align: center;"}
![Flink in a container](https://activerain-store.s3.amazonaws.com/image_store/uploads/8/7/6/3/9/ar12988558393678.JPG){:width="300px"}
{: refdef}

If you want to use the official Docker image today you can get the latest version by running:

	docker pull flink

If you want to run a local Flink cluster with one TaskManager and the Web UI exposed on  the local port 8081 you can run:

	docker run -t -p 8081:8081 flink local

With this image there are various ways to start a Flink cluster, both locally and in a distributed environment. Take a look at the [documentation](https://hub.docker.com/r/_/flink/) that shows how to run a Flink cluster with multiple TaskManagers locally using Docker Compose or across multiple machines using Docker Swarm. You can also use the examples as a reference to create configurations for 	other platforms like Mesos and Kubernetes.

While this announcement is an important milestone, it’s just the first step to help users run containerized Flink in production. There are [improvements](https://issues.apache.org/jira/browse/FLINK-3026) to be made in Flink itself and we will continue to improve these Docker images and the documentation and examples surrounding them.

This is of course a team effort, so any contribution is welcome. The [docker-flink](https://github.com/docker-flink) GitHub organization hosts the source files to [generate the images](https://github.com/docker-flink/docker-flink) and the [documentation](https://github.com/docker-flink/docs/tree/master/flink) that is presented alongside the images on Docker Hub.
