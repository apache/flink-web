---
title:  "Apache Flink Agents 0.3.1 Release Announcement"
date: "2026-07-25T00:00:00.000Z"
authors:
- wenjin:
  name: "Wenjin Xie"
aliases:
- /news/2026/07/25/release-flink-agents-0.3.1.html
---

The Apache Flink Community is pleased to announce the first bug fix release of the Flink Agents 0.3 series.

This release includes 5 bug fixes, Flink 2.3 distribution support, and installer improvements for Flink Agents 0.3.
Below you will find a list of the main bug fixes and improvements (excluding improvements to the build infrastructure and build stability). For a complete list of all changes, please see:
[GitHub Issues](https://github.com/apache/flink-agents/issues?q=is%3Aissue%20state%3Aclosed%20label%3AfixVersion%2F0.3.1).

We highly recommend all users upgrade to Flink Agents 0.3.1.

# Release Artifacts

## Maven Dependencies

```xml
<dependency>
  <groupId>org.apache.flink</groupId>
  <artifactId>flink-agents-api</artifactId>
  <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-ollama</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-openai</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-anthropic</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-azureai</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-bedrock</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-chat-models-gemini</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-embedding-models-ollama</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-embedding-models-bedrock</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-vector-stores-elasticsearch</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-vector-stores-milvus</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-vector-stores-opensearch</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-vector-stores-s3vectors</artifactId>
    <version>0.3.1</version>
</dependency>
<dependency>
    <groupId>org.apache.flink</groupId>
    <artifactId>flink-agents-integrations-mcp</artifactId>
    <version>0.3.1</version>
</dependency>
```

## Binaries

You can find the binaries on the updated [downloads page](https://flink.apache.org/downloads/#apache-flink-agents).


## PyPI

* [flink-agents==0.3.1](https://pypi.org/project/flink-agents/0.3.1/)

# Release Notes

        Release Notes - Flink Agents - Version 0.3.1

<h2>        Bug
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/issues/866'>866</a>] -         Python AgentConfigOptions starts PyFlink gateway during Pemja worker initialization
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/868'>868</a>] -         ActionStateSerde cannot deserialize built-in event subclasses during durable recovery
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/907'>907</a>] -         Prompt placeholder substitution re-expands substituted values and is order-dependent
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/913'>913</a>] -         create_model_from_java_tool_schema_str crashes on a Java tool param without a description
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/914'>914</a>] -         Anthropic chat model crashes on a tool_use response with no text block
</li>
</ul>

<h2>        Improvement
</h2>
<ul>
<li>[<a href='https://github.com/apache/flink-agents/pull/856'>856</a>] -         Add Flink 2.3 distribution and make it the default
</li>
<li>[<a href='https://github.com/apache/flink-agents/issues/863'>863</a>] -         Update install.sh after releasing 0.3.0
</li>
</ul>
