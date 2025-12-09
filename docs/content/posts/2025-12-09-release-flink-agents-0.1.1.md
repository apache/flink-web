---
title:  "Apache Flink Agents 0.1.1 Release Announcement"
date: "2025-12-09T09:00:00.000Z"
authors:
- wenjin:
  name: "Wenjin Xie"
aliases:
- /news/2025/12/09/release-flink-agents-0.1.1.html
---

The Apache Flink Community is pleased to announce the first bug fix release of the Flink-Agents 0.1 series.

This release includes 11 bug fixes, vulnerability fixes, and minor improvements for Flink-Agents 0.1.
Below you will find a list of all bug fixes and improvements (excluding improvements to the build infrastructure and build stability). For a complete list of all changes, please see:
[ISSUE](https://github.com/apache/flink-agents/issues?q=is%3Aissue%20state%3Aclosed%20label%3AfixVersion%2F0.1.1).

We highly recommend all users upgrade to Flink-Agents 0.1.1.

# Release Artifacts

## Maven Dependencies

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-agents-api</artifactId>
  <version>0.1.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-ollama</artifactId>
    <version>0.1.1</version>
</dependency>
```

## Binaries

You can find the binaries on the updated [downloads page](https://flink.apache.org/downloads/#apache-flink-agents).


## PyPi

* [flink-agents==0.1.1](https://pypi.org/project/flink-agents/0.1.1/)

# Release Notes

        Release Notes - Flink-Agents - Version 0.1.1

<h2>        Bug
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/276'>276</a>] -         Python code under e2e_test cannot import the mcp module
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/284'>284</a>] -         Tongyi model failed to handle tool calls 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/293'>293</a>] -         The test case fails to run on Windows 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/296'>296</a>] -         Failed to load Flink legacy yaml config 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/297'>297</a>] -         PythonActionTask failed to serialize for Flink state 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/323'>323</a>] -         Ollama4j can't work with ollama v0.12.10 and above 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/325'>325</a>] -         Invalid JSON in product_review.txt line 2488 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/336'>336</a>] -         Tool call doesn't work in OpenAI chat model integration 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/340'>340</a>] -         Python async execution can not work with flink checkpoint 
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/366'>366</a>] -         PythonEvent does not show properly in event log 
</li>
</ul>

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/264'>264</a>] -         Use event-time in workflow quickstart example
</li>