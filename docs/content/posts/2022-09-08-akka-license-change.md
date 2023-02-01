---
authors:
- Chesnay: null
  name: Chesnay Schepler
date: "2022-09-08T08:00:00Z"
title: Regarding Akka's licensing change
---

On September 7th Lightbend announced a [license change](https://www.lightbend.com/blog/why-we-are-changing-the-license-for-akka) for the Akka project, the TL;DR being that you will need a commercial license to use future versions of Akka (2.7+) in production if you exceed a certain revenue threshold.

Within a few hours of the announcement several people reached out to the Flink project, worrying about the impact this has on Flink, as we use Akka internally.

The purpose of this blogpost is to clarify our position on the matter.

Please be aware that this topic is still quite fresh, and things are subject to change.  
Should anything significant change we will amend this blogpost and inform you via the usual channels.

# Give me the short version

Flink is not in any immediate danger and we will ensure that users are not affected by this change.

The licensing of Flink will not change; it will stay Apache-licensed and will only contain dependencies that are compatible with it.

We will not use Akka versions with the new license.

# What's the plan going forward?

_For now_, we'll stay on Akka 2.6, the current latest version that is still available under the original license.
Historically Akka has been incredibly stable, and combined with our limited use of features, we do not expect this to be a problem.

Meanwhile, we will 

* observe how the situation unfolds (in particular w.r.t. community forks)
* look into a replacement for Akka.

Should a community fork be created (which at this time seems possible) we will switch to that fork in all likely-hood for 1.15+.

## What if a new security vulnerabilities is found in Akka 2.6?

~~That is the big unknown.~~

~~Even though we will be able to upgrade to 2.6.20 (the (apparently) last planned release for Akka 2.6) in Flink 1.17, the unfortunate reality is that [2.6 will no longer be supported](https://github.com/akka/akka/pull/31561#issuecomment-1239217602) from that point onwards.  
Should a CVE be discovered after that it is unlikely to be fixed in Akka 2.6.~~

~~We cannot provide a definitive answer as to how that case would be handled, as it depends on what the CVE is and/or whether a community fork already exists at the time.~~  

**Update - September 9th**: Akka 2.6 will continue to receive critical security updates and critical bug fixes under the current Apache 2 license until [September of 2023](https://www.lightbend.com/akka/license-faq).

> **Will critical vulnerabilities and bugs be patched in 2.6.x?**  
> Yes, critical security updates and critical bugs will be patched in Akka v2.6.x under the current Apache 2 license until September of 2023.

# How does Flink use Akka?

Akka is used in the coordination layer of Flink to

* exchange status messages between processes/components (e.g., JobManager and TaskManager),
* enforce certain guarantees w.r.t. multi-threading (i.e., only one thread can make changes to the internal state of a component)
* observe components for unexpected crashes (i.e., notice and handle TaskManager thread crashes).

What this means is that we are using very few functionalities of Akka.  
Additionally, that we use Akka is an implementation detail that the vast majority of Flink code isn't aware of, meaning that we can replace it with something else without having to change Flink significantly.