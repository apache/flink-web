---
authors:
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
categories: news
date: "2021-01-02T00:00:00Z"
title: Stateful Functions 2.2.2 Release Announcement
---

The Apache Flink community released the second bugfix release of the Stateful Functions (StateFun) 2.2 series, version 2.2.2.

The most important change of this bugfix release is upgrading Apache Flink to version 1.11.3. In addition to many stability
fixes to the Flink runtime itself, this also allows StateFun applications to safely use savepoints to upgrade from
older versions earlier than StateFun 2.2.1. Previously, restoring from savepoints could have failed under
[certain conditions](https://issues.apache.org/jira/browse/FLINK-19741).

<b><i>We strongly recommend all users to upgrade to 2.2.2</i></b>.

---

You can find the binaries on the updated [Downloads page]({{< siteurl >}}/downloads.html).

This release includes 5 fixes and minor improvements since StateFun 2.2.1. Below is a detailed list of all fixes and improvements:

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-20699'>FLINK-20699</a>] -         Feedback invocation_id must not be constant.
</li>
</ul>

<h2>        Task
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-20161'>FLINK-20161</a>] -         Consider switching from Travis CI to Github Actions for flink-statefun&#39;s CI workflows
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-20189'>FLINK-20189</a>] -         Restored feedback events may be silently dropped if per key-group header bytes were not fully read
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-20636'>FLINK-20636</a>] -         Require unaligned checkpoints to be disabled in StateFun applications
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-20689'>FLINK-20689</a>] -         Upgrade StateFun to Flink 1.11.3
</li>
</ul>
