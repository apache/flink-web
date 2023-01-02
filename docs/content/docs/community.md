---
title: Community & Project Info
icon: <i class="fa fa-cogs title maindish" aria-hidden="true"></i>
bold: true
bookCollapseSection: false
weight: 14

tables:
    mailing-lists:
        name: "Mailing Lists"

        cols: 
          - id: "Name"
            name: "Name"
          - id: "Subscribe"
            name: "Subscribe"
          - id: "Digest"
            name: "Digest"
          - id: "Unsubscribe"
            name: "Unsubscribe"
          - id: "Post"
            name: "Post"
          - id: "Archive"
            name: "Archive"

        rows:
          - Name: 
             val: "<strong>news</strong>@flink.apache.org<br />
                   <small>News and announcements from the Flink community</small>"
             html: true
            Subscribe: "[Subscribe](mailto:news-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:news-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:news-unsubscribe@flink.apache.org)"
            Post: "*Read only list*"
            Archive: "[Archives](https://lists.apache.org/list.html?news@flink.apache.org)"
          - Name: 
             val: "<strong>community</strong>@flink.apache.org<br />
                   <small>Broader community discussions related to meetups, conferences, blog posts and job offers</small>"
             html: true
            Subscribe: "[Subscribe](mailto:community-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:community-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:community-unsubscribe@flink.apache.org)"
            Post: "[Post](mailto:community@flink.apache.org)"
            Archive: "[Archives](https://lists.apache.org/list.html?community@flink.apache.org)"
          - Name: 
             val: "<strong>user</strong>@flink.apache.org<br />
                   <small>User support and questions mailing list</small>"
             html: true
            Subscribe: "[Subscribe](mailto:user-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:user-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:user-unsubscribe@flink.apache.org)"
            Post: "[Post](mailto:user@flink.apache.org)"
            Archive: "[Archives](https://lists.apache.org/list.html?user@flink.apache.org)"
          - Name: 
             val: "<strong>user-zh</strong>@flink.apache.org<br />
                   <small>User support and questions mailing list</small>"
             html: true
            Subscribe: "[Subscribe](mailto:user-zh-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:user-zh-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:user-zh-unsubscribe@flink.apache.org)"
            Post: "[Post](mailto:user-zh@flink.apache.org)"
            Archive: "[Archives](https://lists.apache.org/list.html?user-zh@flink.apache.org)"
          - Name: 
             val: "<strong>dev</strong>@flink.apache.org<br />
                   <small>Development related discussions</small>"
             html: true
            Subscribe: "[Subscribe](mailto:dev-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:dev-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:dev-unsubscribe@flink.apache.org)"
            Post: "[Post](mailto:dev@flink.apache.org)"
            Archive: "[Archives](https://lists.apache.org/list.html?dev@flink.apache.org)"
          - Name: 
             val: "<strong>builds</strong>@flink.apache.org<br />
                   <small>Build notifications of Flink main repository</small>"
             html: true
            Subscribe: "[Subscribe](mailto:builds-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:builds-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:builds-unsubscribe@flink.apache.org)"
            Post: "*Read only list*"
            Archive: "[Archives](https://lists.apache.org/list.html?builds@flink.apache.org)"
          - Name: 
             val: "<strong>issues</strong>@flink.apache.org<br />
                   <small>Mirror of all Jira activity</small>"
             html: true
            Subscribe: "[Subscribe](mailto:issues-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:issues-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:issues-unsubscribe@flink.apache.org)"
            Post: "*Read only list*"
            Archive: "[Archives](https://lists.apache.org/list.html?issues@flink.apache.org)"
          - Name: 
             val: "<strong>commits</strong>@flink.apache.org<br />
                   <small>All commits to our repositories</small>"
             html: true
            Subscribe: "[Subscribe](mailto:commits-subscribe@flink.apache.org)"
            Digest: "[Subscribe](mailto:commits-digest-subscribe@flink.apache.org)"
            Unsubscribe: "[Unsubscribe](mailto:commits-unsubscribe@flink.apache.org)"
            Post: "*Read only list*"
            Archive: "[Archives](https://lists.apache.org/list.html?commits@flink.apache.org)"

---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Community & Project Info

## How do I get help from Apache Flink?

There are many ways to get help from the Apache Flink community. The [mailing lists](#mailing-lists) are the primary place where all Flink committers are present. For user support and questions use the *user mailing list*. You can also join the community on [Slack](#slack). Some committers are also monitoring [Stack Overflow](#stack-overflow). Please remember to tag your questions with the *[apache-flink](http://stackoverflow.com/questions/tagged/apache-flink)* tag. Bugs and feature requests can either be discussed on the *dev mailing list* or on [Jira](https://issues.apache.org/jira/browse/FLINK). Those interested in contributing to Flink should check out the [contribution guide]({{< ref "how-to-contribute" >}}).

## Mailing Lists

{{< table "mailing-lists" >}}

<b style="color:red">Please make sure you are subscribed to the mailing list you are posting to!</b> If you are not subscribed to the mailing list, your message will either be rejected (dev@ list) or you won't receive the response (user@ list).

### How to subscribe to a mailing list

Before you can post a message to a mailing list, you need to subscribe to the list first.

1. Send an email without any contents or subject to *listname*-subscribe@flink.apache.org. (replace *listname* with dev, user, user-zh, ..)
2. Wait till you receive an email with the subject "confirm subscribe to *listname*@flink.apache.org". Reply to that email, without editing the subject or including any contents
3. Wait till you receive an email with the subject "WELCOME to *listname*@flink.apache.org".


If you send us an email with a code snippet, make sure that:

1. you do not link to files in external services as such files can change, get deleted or the link might break and thus make an archived email thread useless
2. you paste text instead of screenshots of text
3. you keep formatting when pasting code in order to keep the code readable
4. there are enough import statements to avoid ambiguities

## Slack

You can join the [Apache Flink community on Slack.](https://join.slack.com/t/apache-flink/shared_invite/zt-1llkzbgyt-K2nNGGg88rfsDGLkT09Qzg)
After creating an account in Slack, don't forget to introduce yourself in #introductions.
Due to Slack limitations the invite link expires after 100 invites. If it is expired, please reach out to the [Dev mailing list](#mailing-lists).
Any existing Slack member can also invite anyone else to join.

There are a couple of community rules:

* **Be respectful** - This is the most important rule!
* All important decisions and conclusions **must be reflected back to the mailing lists.**
  "If it didn’t happen on a mailing list, it didn’t happen." - [The Apache Mottos](http://theapacheway.com/on-list/)
* Use **Slack threads** to keep parallel conversations from overwhelming a channel.
* Please **do not direct message** people for troubleshooting, Jira assigning and PR review. These should be picked-up voluntarily.

**Note**: All messages from public channels in our Slack are **permanently stored and published** in the [Apache Flink Slack archive on linen.dev](https://www.linen.dev/s/apache-flink). The purpose of this archive is to allow search engines to find past discussions in the Flink Slack.

## Stack Overflow

Committers are watching [Stack Overflow](http://stackoverflow.com/questions/tagged/apache-flink) for the [apache-flink](http://stackoverflow.com/questions/tagged/apache-flink) tag.

Make sure to tag your questions there accordingly to get answers from the Flink community.

## Issue Tracker

We use Jira to track all code related issues: [https://issues.apache.org/jira/browse/FLINK](https://issues.apache.org/jira/browse/FLINK).
You must have a JIRA account in order to log cases and issues.

### I already have an ASF JIRA account and want to be added as a contributor

If you already have an ASF JIRA account, you do not need to sign up for a new account.
Please email [jira-requests@flink.apache.org](mailto:jira-requests@flink.apache.org) using the following template, so that we can add your account to the
contributors list in JIRA:

[Open the template in your email client](mailto:jira-requests@flink.apache.org?subject=Add%20me%20as%20a%20contributor%20to%20JIRA&body=Hello%2C%0A%0APlease%20add%20me%20as%20a%20contributor%20to%20JIRA.%0AMy%20JIRA%20username%20is%3A%20%5BINSERT%20YOUR%20JIRA%20USERNAME%20HERE%5D%0A%0AThanks%2C%0A%5BINSERT%20YOUR%20NAME%20HERE%5D)

```text
Subject: Add me as a contributor to JIRA

Hello,

Please add me as a contributor to JIRA.
My JIRA username is: [INSERT YOUR JIRA USERNAME HERE]

Thanks,
[INSERT YOUR NAME HERE]
```

### I do not have an ASF JIRA account, want to request an account and be added as a contributor

In order to request an ASF JIRA account, you will need to email [jira-requests@flink.apache.org](mailto:jira-requests@flink.apache.org) using the following template:

[Open the template in your email client](mailto:jira-requests@flink.apache.org?subject=Request%20for%20JIRA%20Account&body=Hello%2C%0A%0AI%20would%20like%20to%20request%20a%20JIRA%20account.%0AMy%20proposed%20JIRA%20username%3A%20%5BINSERT%20YOUR%20DESIRED%20JIRA%20USERNAME%20HERE%20(LOWERCASE%20LETTERS%20AND%20NUMBERS%20ONLY)%5D%0AMy%20full%20name%3A%20%5BINSERT%20YOUR%20FULL%20NAME%20HERE%5D%0AMy%20email%20address%3A%20%5BINSERT%20YOUR%20EMAIL%20ADDRESS%20HERE%5D%0A%0AThanks%2C%0A%5BINSERT%20YOUR%20NAME%20HERE%5D)

```text
Subject: Request for JIRA Account

Hello,

I would like to request a JIRA account.
My proposed JIRA username: [INSERT YOUR DESIRED JIRA USERNAME HERE (LOWERCASE LETTERS AND NUMBERS ONLY)]
My full name: [INSERT YOUR FULL NAME HERE]
My email address: [INSERT YOUR EMAIL ADDRESS HERE]

Thanks,
[INSERT YOUR NAME HERE]
```

All issue activity is also mirrored to the issues mailing list.

## Reporting Security Issues

If you wish to report a security vulnerability, please contact [security@apache.org](mailto:security@apache.org). Apache Flink follows the typical [Apache vulnerability handling process](https://www.apache.org/security/) for reporting vulnerabilities. Note that vulnerabilities should not be publicly disclosed until the project has responded.

## Meetups

There are plenty of meetups on [meetup.com](http://www.meetup.com/topics/apache-flink/) featuring Flink.

## Source Code

### Main Repositories

* **Flink Core Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink.git](https://gitbox.apache.org/repos/asf/flink.git)
    * GitHub mirror: [https://github.com/apache/flink.git](https://github.com/apache/flink.git)

* **Flink Docker Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-docker.git](https://gitbox.apache.org/repos/asf/flink-docker.git)
    * GitHub mirror: [https://github.com/apache/flink-docker.git](https://github.com/apache/flink-docker.git)

* **Flink Stateful Functions Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-statefun.git](https://gitbox.apache.org/repos/asf/flink-statefun.git)
    * GitHub mirror: [https://github.com/apache/flink-statefun](https://github.com/apache/flink-statefun)

* **Flink Stateful Functions Docker Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-statefun-docker.git](https://gitbox.apache.org/repos/asf/flink-statefun-docker.git)
    * GitHub mirror: [https://github.com/apache/flink-statefun-docker](https://github.com/apache/flink-statefun-docker)

* **Flink ML Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-ml.git](https://gitbox.apache.org/repos/asf/flink-ml.git)
    * GitHub mirror: [https://github.com/apache/flink-ml](https://github.com/apache/flink-ml)

* **Flink Kubernetes Operator Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-kubernetes-operator.git](https://gitbox.apache.org/repos/asf/flink-kubernetes-operator.git)
    * GitHub mirror: [https://github.com/apache/flink-kubernetes-operator](https://github.com/apache/flink-kubernetes-operator)

* **Flink Table Store Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-table-store.git](https://gitbox.apache.org/repos/asf/flink-table-store.git)
    * GitHub mirror: [https://github.com/apache/flink-table-store](https://github.com/apache/flink-table-store)

* **Flink Website Repository**
    * ASF repository: [https://gitbox.apache.org/repos/asf/flink-web.git](https://gitbox.apache.org/repos/asf/flink-web.git)
    * GitHub mirror:  [https://github.com/apache/flink-web.git](https://github.com/apache/flink-web.git)

### Complete List of Repositories

The complete list of repositories of Apache Flink can be found under https://gitbox.apache.org/repos/asf#flink.

## Training

[Ververica](http://ververica.com) currently maintains free Apache Flink training. Their [training website](http://training.ververica.com/) has slides and exercises with solutions. The slides are also available on [SlideShare](http://www.slideshare.net/dataArtisans/presentations).

## Project Wiki

The Apache Flink <a href="https://cwiki.apache.org/confluence/display/FLINK/Apache+Flink+Home" target="_blank">project wiki</a> contains a range of relevant resources for Flink users. However, some content on the wiki might be out-of-date. When in doubt, please refer to the <a href="{{ site.docs-stable }}" target="_blank">Flink documentation</a>.

## Flink Forward

Flink Forward is a conference happening yearly in different locations around the world. Up to date information about the conference is available on <a href="https://www.flink-forward.org/">Flink-Forward.org</a>.

## People

Please find the most up-to-date list <a href="https://projects.apache.org/committee.html?flink">here</a>.

## Materials / Apache Flink Logos

The [materials page]({{< ref "material" >}}) offers assets such as the Apache Flink logo in different image formats, or the Flink color scheme.
