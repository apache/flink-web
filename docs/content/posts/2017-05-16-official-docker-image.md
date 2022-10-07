---
author: Patrick Lucas (Data Artisans) and Ismaël Mejía (Talend)
author-twitter: iemejia
categories: news
date: "2017-05-16T09:00:00Z"
title: Introducing Docker Images for Apache Flink
---

For some time, the Apache Flink community has provided scripts to build a Docker image to run Flink. Now, starting with version 1.2.1, Flink will have a [Docker image](https://hub.docker.com/r/_/flink/) on the Docker Hub. This image is maintained by the Flink community and curated by the [Docker](https://github.com/docker-library/official-images) team to ensure it meets the quality standards for container images of the Docker community.

A community-maintained way to run Apache Flink on Docker and other container runtimes and orchestrators is part of the ongoing effort by the Flink community to make Flink a first-class citizen of the container world.

If you want to use the Docker image today you can get the latest version by running:

	docker pull flink

And to run a local Flink cluster with one TaskManager and the Web UI exposed on port 8081, run:

	docker run -t -p 8081:8081 flink local

With this image there are various ways to start a Flink cluster, both locally and in a distributed environment. Take a look at the [documentation](https://hub.docker.com/r/_/flink/) that shows how to run a Flink cluster with multiple TaskManagers locally using Docker Compose or across multiple machines using Docker Swarm. You can also use the examples as a reference to create configurations for other platforms like Mesos and Kubernetes.

While this announcement is an important milestone, it’s just the first step to help users run containerized Flink in production. There are [improvements](https://issues.apache.org/jira/issues/?jql=project%20%3D%20FLINK%20AND%20component%20%3D%20Docker%20AND%20resolution%20%3D%20Unresolved%20ORDER%20BY%20due%20ASC%2C%20priority%20DESC%2C%20created%20ASC) to be made in Flink itself and we will continue to improve these Docker images and for the documentation and examples surrounding them.

This is of course a team effort, so any contribution is welcome. The [docker-flink](https://github.com/docker-flink) GitHub organization hosts the source files to [generate the images](https://github.com/docker-flink/docker-flink) and the [documentation](https://github.com/docker-flink/docs/tree/master/flink) that is presented alongside the images on Docker Hub.

*Disclaimer: The docker images are provided as a community project by individuals on a best-effort basis. They are not official releases by the Apache Flink PMC.*