---
authors:
- JingsongLi: null
  name: Jingsong Lee
categories: news
date: "2022-10-13T08:00:00Z"
excerpt: The Apache Flink Community is pleased to announce a bug fix release for Flink
  Table Store 0.2.
title: Apache Flink Table Store 0.2.1 Release Announcement
---

The Apache Flink Community is pleased to announce the first bug fix release of the Flink Table Store 0.2 series.

This release includes 13 bug fixes, vulnerability fixes, and minor improvements for Flink Table Store 0.2.
Below you will find a list of all bugfixes and improvements. For a complete list of all changes see:
[JIRA](https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12352257).

We highly recommend all users upgrade to Flink Table Store 0.2.1.

# Release Artifacts

## Binaries

You can find the binaries on the updated [Downloads page]({{ site.baseurl }}/downloads.html).

# Release Notes

<h2>        Bug
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29098'>FLINK-29098</a>] -         StoreWriteOperator#prepareCommit should let logSinkFunction flush first before fetching offset
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29241'>FLINK-29241</a>] -         Can not overwrite from empty input
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29273'>FLINK-29273</a>] -         Page not enough Exception in SortBufferMemTable
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29278'>FLINK-29278</a>] -         BINARY type is not supported in table store
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29295'>FLINK-29295</a>] -         Clear RecordWriter slower to avoid causing frequent compaction conflicts
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29367'>FLINK-29367</a>] -         Avoid manifest corruption for incorrect checkpoint recovery
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29369'>FLINK-29369</a>] -         Commit delete file failure due to Checkpoint aborted
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29385'>FLINK-29385</a>] -         AddColumn in flink table store should check the duplicate field names
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29412'>FLINK-29412</a>] -         Connection leak in orc reader
</li>
</ul>

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29154'>FLINK-29154</a>] -         Support LookupTableSource for table store
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29181'>FLINK-29181</a>] -         log.system can be congiured by dynamic options
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29226'>FLINK-29226</a>] -         Throw exception for streaming insert overwrite
</li>
<li>[<a href='https://issues.apache.org/jira/browse/FLINK-29276'>FLINK-29276</a>] -         Flush all memory in SortBufferMemTable.clear
</li>
</ul>
                                                                                                                                                                