---
title:  "Apache Flink Agents 0.2.1 Release Announcement"
date: "2026-03-26T00:00:00.000Z"
authors:
- wenjin:
  name: "Wenjin Xie"
aliases:
- /news/2026/03/26/release-flink-agents-0.2.1.html
---

The Apache Flink Community is pleased to announce the first bug fix release of the Flink-Agents 0.2 series.

This release includes 3 bug fixes, vulnerability fixes, and minor improvements for Flink-Agents 0.2.
Below you will find a list of all bug fixes and improvements (excluding improvements to the build infrastructure and build stability). For a complete list of all changes, please see:
[ISSUE](https://github.com/apache/flink-agents/issues?q=is%3Aissue%20state%3Aclosed%20label%3AfixVersion%2F0.2.1).

We highly recommend all users upgrade to Flink-Agents 0.2.1.

# Release Artifacts

## Maven Dependencies

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-agents-api</artifactId>
  <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-ollama</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-openai</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-anthropic</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-azureai</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-embedding-models-ollama</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-vector-stores-elasticsearch</artifactId>
    <version>0.2.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-mcp</artifactId>
    <version>0.2.1</version>
</dependency>
```

## Binaries

You can find the binaries on the updated [downloads page](https://flink.apache.org/downloads/#apache-flink-agents).


## PyPi

* [flink-agents==0.2.1](https://pypi.org/project/flink-agents/0.2.1/)

# Release Notes

        Release Notes - Flink-Agents - Version 0.2.1

<h2>        Bug
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/412'>412</a>] -         Failed to connect to remote mcp server that does not support prompts
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/538'>538</a>] -         Java agents fail to connect to MCP servers that do not support prompts 
</li>
<li>[<a href='https://github.com/apache/flink-agents/pull/532'>532</a>] -           Fix MCPTool Jackson deserialization by ignoring unknown properties
</li>
</ul>

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/568'>568</a>] -         Support pretty-printed JSON format for FileEvent logs
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/519'>519</a>] -         Reduce size of flink-agents wheel
</li>
</ul>

<h2>        Technical Debt
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/96'>96</a>] -         Improve observability of ci
</li>
</ul>