---
authors:
- joemoe: null
  name: Johannes Moser
date: "2021-11-03T00:00:00Z"
excerpt: A look back at the development cycle for Flink 1.14
title: Flink Backward - The Apache Flink Retrospective
---

It has now been a month since the community released [Apache Flink 1.14](https://flink.apache.org/downloads.html#apache-flink-1140) into the wild. We had a comprehensive look at the enhancements, additions, and fixups in the release announcement blog post, and now we will look at the development cycle from a different angle. Based on feedback collected from contributors involved in this release, we will explore the experiences and processes behind it all.

{% toc %}

# A retrospective on the release cycle

From the team, we collected emotions that have been attributed to points in time of the 1.14 release cycle:

<center>
<img src="/img/blog/2021-11-03-flink-backward/1.14-weather.png" width="70%"/>
</center>

The overall sentiment seems to be quite good. A ship crushed a robot two times, someone felt sick towards the end, an octopus causing negative emotions appeared in June...

We looked at the origin of these emotions and analyzed what went well and what could be improved. We also incorporated some feedback gathered from the community.

## Problems faced

No release is perfect, and the community is constantly looking to improve.  

Apache Flink has active contributors from around the globe, many of whom do not speak English as a first language. The community is still ironing out processes for delivering high-quality documentation and blog posts from a content perspective. It is a work in progress but we have contributors focusing on this component. 

Each Flink release is built with the help of hundreds of contributors, each working on different parts of the project. Changes to one module may affect others in ways that are not always obvious. To maintain quality, the community supports an expansive test suite. Invariably, some tests are found to be flaky. Whenever we discover a test issue, the community opens a blocker issue that we must resolve before the next release. In practice, this leads to contributors triaging most test instabilities towards the end of each release cycle. From now on, we want to be more mindful of these failures and prioritize them when discovered. 

Finally, the community pushed the planned feature freeze for 1.14 by two weeks. Two weeks is an improvement from previous release cycles, but we hope to continue improving this metric for 1.15. 

## Things enjoyed

The implementation of some features, such as [buffer debloating](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/memory/network_mem_tuning/#the-buffer-debloating-mechanism) and [fine-grained resource management](https://nightlies.apache.org/flink/flink-docs-release-1.14/docs/deployment/finegrained_resource/), went smoothly. Though a few issues are now popping up as people begin using them in production, it is satisfying to see an engineering effort go according to plan. 

We also said goodbye to some components, the old table planner and integrated Mesos support. As any developer will tell you, there's nothing better than deleting old code and reducing complexity. 


# What we want to achieve through process changes

## Transparency - let the community participate

When approaching a release, usually a couple of weeks after the previous release has been done, we set up bi-weekly meetings for the community to discuss any issues regarding the release. The usefulness of those meetings varied a lot, and so we started to [track the efforts](https://cwiki.apache.org/confluence/display/FLINK/1.14+Release) in the Apache Flink Confluence wiki.

We came up with a system to label the current states of each feature: “independent”, “won’t make it”, “very unlikely”, “will make it”, “done”, and “done done”. We introduced the “done done” state since we lacked a shared understanding of the definition of done. To qualify for “done done”, the feature is manually tested by someone not involved in the implementation. Additionally, there must exist comprehensive documentation that enables users to use the feature.

After each meeting, we provided updates on the mailing list and created a corresponding burn-down chart. Those efforts have well been received by our contributors, although they might still require some improvements.

The meeting used to only be for those driving the primary efforts, but we opened it up to the whole community for this release. While nobody ended up joining, we will continue to make the meetings open to everyone. 


## Stability - reduce building and testing pain

At one point, as we were coming close to the feature freeze, the stability of the master branch became quite unstable. Although we have encountered this issue in the past, building and testing Flink under such conditions was not ideal.

As a result, we focused on reducing stability issues, and the release managers have tried to organize and manage this effort. In future development cycles, the whole community needs to focus on the stability of the master branch. There are already improvements in the making, and they will hopefully enhance the experience of contributing significantly.

## Documentation - make it user-friendly

Coming back to Apache traditions, most of the documentation (if any) was still being pushed after the feature freeze. As mentioned before, documentation is required to achieve the level of "done done". Going forward, we will keep more of an eye on pushing documentation earlier in the development process. Apache Flink is an amazing piece of software that can solve so many problems, but we can do so much more in improving the user experience and introducing it to a wider audience.  

## API consistency - a timeless, joyful experience

The issue of API consistency was not caused by the 1.14 release, but popped up during the development cycle nevertheless, including a bigger discussion on the mailing list. While we tried to be transparent about the [stability guarantees of an API](https://cwiki.apache.org/confluence/display/FLINK/Stability+Annotations) (there are no guarantees across major versions), this was not made very clear or easy to find. Since many users rely on PublicEvolving APIs (due to a lack of Public API additions), this resulted in problems for downstream projects.

Moving forward, we will document more clearly what the guarantees are and introduce a process for promoting PublicEvolving APIs. This might involve generating a report on any removed/modified PublicEvolving APIs during the release cycle so that downstream projects can prepare for the changes. 

# Some noteworthy items

The first iteration for the buffer debloat feature was done in a Hackathon.

Our [Apache Flink 1.14 Release wiki page](https://cwiki.apache.org/confluence/display/FLINK/1.14+Release) has 167 historic versions. For comparison, [FLIP 147](https://cwiki.apache.org/confluence/display/FLINK/FLIP-147%3A+Support+Checkpoints+After+Tasks+Finished) (one of the most active FLIPs) has just 76.

With [FLINK-2491](https://issues.apache.org/jira/browse/FLINK-2491), we closed the third most watched issue in the Apache Flink Jira. This makes sense since FLINK-2491 was created 6 years ago (August 6, 2015). The second oldest issue was created in 2017.

:heart: 

An open source community is more than just working on software. Apache Flink is the perfect example of software that is collaborated on in all parts of the world. The active mailing list, the discussions on FLIPs, and the interactions on Jira tickets all document how people work together to build something great. We should never forget that.

In the meantime, the community is already working towards Apache Flink 1.15. If you would like to become a contributor, please reach out via the [dev mailing list](https://flink.apache.org/community.html#mailing-lists).  We are happy to help you find a ticket to get started on.
