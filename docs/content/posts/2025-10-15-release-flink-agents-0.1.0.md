---
title:  "Apache Flink Agents 0.1.0 Release Announcement"
date: "2025-10-15T08:00:00.000Z"
authors:
- xtsong:
  name: "Xintong Song"
aliases:
- /news/2025/10/15/release-flink-agents-0.1.0.html
---

The Apache Flink Community is excited to announce the first preview release of Apache Flink Agents (0.1.0).

## What is Apache Flink Agents

Apache Flink Agents is a new sub-project of Apache Flink for building event-driven AI agents directly on Flink’s streaming runtime. It unifies stream processing and autonomous agents in one framework, combining Flink's proven strengths -- scale, low latency, fault tolerance, and state management -- with agent capabilities -- LLMs, tools, memory, and dynamic orchestration.

### Why Apache Flink Agents Matters

While AI agents have made rapid progress in interactive applications like chatbots and copilots, these systems typically operate in synchronous, one-off interactions. Many business use cases cannot wait for a user to prompt them into action. In industrial settings such as e-commerce, finance, IoT, and logistics, critical decisions must be made instantly in response to live events like a payment failure, a sensor anomaly, or a user click.

To succeed in production, enterprise agents must be capable of:
- Operating on live, high-volume event streams such as transactions, sensor anomalies, or user clicks.
- Running continuously and autonomously, not only when prompted.
- Guaranteeing safety, auditability, and recovery when something goes wrong.

These workloads require more than intelligence alone. They demand massive scale, millisecond latency, fault tolerance, and stateful coordination. These are exactly the strengths of Apache Flink.

Until now, there has been no unified framework to bring agentic AI patterns into Flink’s proven streaming ecosystem. Apache Flink Agents bridges this gap by treating agents as event-driven microservices that are always-on, reliable, and scalable.

### Key Features

Building on Flink's battle-tested streaming engine, Apache Flink Agents inherits distributed, at-scale, fault-tolerant structured data processing and mature state management, and adds first-class abstractions for Agentic AI building blocks and functionalities -- large language models (LLMs), prompts, tools, memory, dynamic orchestration, observability, and more.

The key features of Apache Flink Agents include:
- **Massive Scale and Millisecond Latency:** Processes massive-scale event streams in real time, leveraging Flink's distributed processing engine.
- **Seamless Data and AI Integration:** Agents interact directly with Flink's DataStream and Table APIs for input and output, enabling a smooth integration of structured data processing and semantic AI capabilities within Flink.
- **Exactly-Once Action Consistency:** Ensures exactly-once consistency for agent actions and their side effects by integrating Flink's checkpointing with an external write-ahead log.
- **Familiar Agent Abstractions:** Leverages well-known AI agent concepts, making it easy for developers experienced with agent-based systems to quickly adopt and build on Apache Flink Agents without a steep learning curve.
- **Multi-Language Supports:** Provides native APIs in both Python and Java, enabling seamless integration into diverse development environments and allowing teams to use their preferred programming language.
- **Rich Ecosystem:** Natively integrates mainstream LLMs, vector stores from diverse providers, and tools or prompts hosted on MCP servers into your agents, while enabling customizable extensions.
- **Observability:** Adopts an event-centric orchestration approach, where all agent actions are connected and controlled by events, enabling observation and understanding of agent behavior through the event log.

## Release 0.1.0

Flink Agents 0.1.0 is available for downloading [here](https://flink.apache.org/downloads/#apache-flink-agents).

Documentations and quickstart examples can be found [here](https://nightlies.apache.org/flink/flink-agents-docs-release-0.1/).

**Note:** Flink Agents 0.1.0 is a preview version, which means:
- Some functionalities may contain known or unknown issues. You can check the list of known issues and their resolution status via the [Github Issues](https://github.com/apache/flink-agents/issues).
- The current APIs and configuration options are experimental and may undergo non-backward compatible changes in future versions.
Therefore, we do not recommend using this version in production environments with high stability requirements.

We greatly appreciate any feedback you can provide, whether it's sharing how you're using our product, suggesting new features, helping us identify and fix bugs, or anything else that comes to mind. Your insights are invaluable to us.

You may reach out to us via:
- [Join the Apache Flink Slack](https://flink.apache.org/what-is-flink/community/#slack) and ask for help in [#flink-agents-user](https://apache-flink.slack.com/archives/C09KP5YUWE8).
- Post feature requirements and bug reports at [Github Issues](https://github.com/apache/flink-agents/issues).
- Share your use case and ideas at [Github Discussions](https://github.com/apache/flink-agents/discussions).

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Adem Amen Thabti, Alan Z., Eugene, Hao Li, HuangXingBo, Kavishankarks, KeGu-069, Letao Jiang, Qingsheng Ren, Richard, Wenjin Xie, Xintong Song, Xu Huang, Xuannan, twosom, yanand0909, zhaomin1423
