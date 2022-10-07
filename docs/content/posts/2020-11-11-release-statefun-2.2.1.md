---
authors:
- name: Tzu-Li (Gordon) Tai
  twitter: tzulitai
  tzulitai: null
categories: news
date: "2020-11-11T00:00:00Z"
title: Stateful Functions 2.2.1 Release Announcement
---

The Apache Flink community released the first bugfix release of the Stateful Functions (StateFun) 2.2 series, version 2.2.1.

This release fixes a critical bug that causes restoring the Stateful Functions cluster from snapshots (checkpoints or
savepoints) to fail under certain conditions. Starting from this release, StateFun now creates snapshots with a more
robust format that allows it to be restored safely going forward.

<b><i>We strongly recommend all users to upgrade to 2.2.1</i></b>. Please see the following sections on instructions and things to
keep in mind for this upgrade.

## For new users just starting out with Stateful Functions

We strongly recommend to skip all previous versions and start using StateFun from version 2.2.1.
This guarantees that failure recovery from checkpoints, or application upgrades using savepoints will work as expected for you.

## For existing users on versions <= 2.2.0

Users that are currently using older versions of StateFun may or may not be able to directly upgrade to 2.2.1 using
savepoints taken with the older versions. <b>The Flink community is working hard on a follow-up hotfix release, 2.2.2,
that would guarantee that you can perform the upgrade smoothly</b>. For the meantime, you may still try to upgrade to 2.2.1
first, but may encounter [FLINK-19741](https://issues.apache.org/jira/browse/FLINK-19741) or
[FLINK-19748](https://issues.apache.org/jira/browse/FLINK-19748). If you do encounter this, do not worry about data
loss; this simply means that the restore failed, and you’d have to wait until 2.2.2 is out in order to upgrade.

The follow-up hotfix release 2.2.2 is expected to be ready within another 2~3 weeks, as it [requires a new hotfix release
from Flink core](http://apache-flink-mailing-list-archive.1008284.n3.nabble.com/DISCUSS-Releasing-Apache-Flink-1-11-3-td45989.html),
and ultimately an upgrade of the Flink dependency in StateFun. We’ll update the community via the Flink
mailing lists as soon as this is ready, so please subscribe to the mailing lists for important updates for this!

---

You can find the binaries on the updated [Downloads page]({{ site.baseurl }}/downloads.html).

This release includes 6 fixes and minor improvements since StateFun 2.2.0. Below is a detailed list of all fixes and improvements:

<h2>        Bug
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19515'>FLINK-19515</a>] -         Async RequestReply handler concurrency bug
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19692'>FLINK-19692</a>] -         Can&#39;t restore feedback channel from savepoint
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19866'>FLINK-19866</a>] -         FunctionsStateBootstrapOperator.createStateAccessor fails due to uninitialized runtimeContext
</li>
</ul>

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19826'>FLINK-19826</a>] -         StateFun Dockerfile copies plugins with a specific version instead of a wildcard
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19827'>FLINK-19827</a>] -         Allow the harness to start with a user provided Flink configuration
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-19840'>FLINK-19840</a>] -         Add a rocksdb and heap timers configuration validation
</li>
</ul>
