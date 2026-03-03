---
title:  "Apache Flink Agents 0.2.0 Release Announcement"
date: "2026-02-06T00:00:00.000Z"
authors:
- xtsong:
  name: "Xintong Song"
aliases:
- /news/2026/02/06/release-flink-agents-0.2.0.html
---

The Apache Flink Community is excited to announce the release of Apache Flink Agents 0.2.0.

Get access to Flink Agents 0.2.0 now:
- Download the release [here](https://flink.apache.org/downloads/#apache-flink-agents-020).
- Find documentation and quickstart examples [here](https://nightlies.apache.org/flink/flink-agents-docs-release-0.2/).

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Agents 0.2.0 is a preview version, which means:

- Some functionalities may contain known or unknown issues. You can check the list of known issues and their resolution status via the [Github Issues](https://github.com/apache/flink-agents/issues).
- The current APIs and configuration options are experimental and may undergo non-backward compatible changes in future versions.
</div>

We greatly appreciate any feedback you can provide, whether it's sharing how you're using our product, suggesting new features, helping us identify and fix bugs, or anything else that comes to mind. Your insights are invaluable to us.

You may reach out to us via:
- [Join the Apache Flink Slack](https://flink.apache.org/what-is-flink/community/#slack) and ask for help in [#flink-agents-user](https://apache-flink.slack.com/archives/C09KP5YUWE8).
- Post feature requirements and bug reports at [Github Issues](https://github.com/apache/flink-agents/issues).
- Share your use case and ideas at [Github Discussions](https://github.com/apache/flink-agents/discussions).

## What is Apache Flink Agents?

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
- **Exactly-Once Consistency:** Ensures exactly-once consistency for agent actions, model inference and tool calls, and their side effects, by extending Flink's checkpointing mechanism with an external action state store.
- **Familiar Agent Abstractions:** Leverages well-known AI agent concepts, making it easy for developers experienced with agent-based systems to quickly adopt and build on Apache Flink Agents without a steep learning curve.
- **Multi-Language Support:** Provides native APIs in both Python and Java, enabling seamless integration into diverse development environments and allowing teams to use their preferred programming language.
- **Rich Ecosystem:** Natively integrates mainstream LLMs, vector stores from diverse providers, and tools or prompts hosted on MCP servers into your agents, while enabling customizable extensions.
- **Observability:** Adopts an event-centric orchestration approach, where all agent actions are connected and controlled by events, enabling observation and understanding of agent behavior through the event log.

## What's New in the 0.2 Release?

### Enhanced Java API Parity

In Flink Agents 0.1, certain features were only available in the Python API and not supported in the Java API.

Version 0.2 closes this gap by adding full support for the following capabilities in Java:
- Embedding Models
- Vector Stores
- MCP Server
- Asynchronous Execution

With these additions, the Java API is now functionally on par with the Python API.

See the [documentation](https://nightlies.apache.org/flink/flink-agents-docs-release-0.2/docs/faq/faq/#q3-should-i-choose-java-or-python) on how to choose between the Java & Python APIs.

### Expanded Ecosystem Integrations

Flink Agents 0.2 introduces built-in support for a broader range of model providers and vector stores:

- **Chat Models:**
  - Python API now supports Azure OpenAI.
  - Java API adds support for Azure AI, Anthropic, and OpenAI.
- **Embedding Models:** 
  - Java API now supports Ollama.
- **Vector Stores:**
  - Java API now supports Elasticsearch.

Additionally, Flink Agents 0.2 now supports cross-language resource access, enabling users to leverage integration support provided in one language within an agent built using the other - e.g., calling an Azure AI chat model (supported in Java) from a Python agent, or vice versa.

**Note:** Cross-language resource access is currently not supported within async execution code blocks. When using cross-language integration supports, the framework built-in actions will fall back to synchronous execution.

### Memory System Overhaul

Flink Agents 0.2 features a comprehensive upgrade to its memory management system. While the previous version only supported Short-Term Memory, the new release introduces three distinct memory types:
- **Sensory Memory:** Maintains states and passes context within a single agent run.
- **Short-Term Memory:** Preserves precise contextual information across multiple Agent runs.
- **Long-Term Memory:** Enables approximate semantic retrieval of large-scale contextual information. This also comes with preliminary information summary and compaction support.

See the [documentation](https://nightlies.apache.org/flink/flink-agents-docs-release-0.2/docs/development/memory/overview/) for more details.

### Durable Execution

Flink Agents 0.1 provided action-level exactly-once execution, ensuring that completed actions wouldn’t be re-executed after job recovery.

In version 0.2, this capability is refined to a finer granularity. You can now specify certain code blocks for durable execution within an action. Upon failure recovery, even if the entire action hasn’t completed, any successfully executed durable execution blocks will not be re-run.

This enhancement helps avoid:
- Redundant model invocations (saving time, tokens, and reducing non-determinism)
- Side effects from repeated tool calls (e.g., duplicate payments or email notifications)

See the [documentation](https://nightlies.apache.org/flink/flink-agents-docs-release-0.2/docs/development/workflow_agent/#durable-execution) for more details.

### Multi-Version Flink Compatibility

Previously, Flink Agents 0.1 was compatible only with Apache Flink 1.20.3.

Flink Agents 0.2 now supports a wider range of Flink versions: 1.20, 2.0, 2.1, and 2.2.

**Note:** We recommend always using the latest bugfix version (x.y.z) of your chosen Flink minor version (x.y), as it typically includes fixes for more known issues.

## Breaking Changes

- Python API
  - The API for creating `ResourceDescriptor` has changed.
    - In the previous version, users should indicate the resource provider by `clazz=Type[Resource]`
    - In Flink Agents 0.2, users should indicate by `clazz=ResourceName`, and we provide constant strings for using built-in integrations.
  - The `execute_async` method of `RunnerContext` has been changed to `durable_execute_async`.
  - `MCPTool`, `MCPPrompt` and `MCPServer` are no longer considered as APIs, and have been moved out from the `api` module.
- Configuration
  - `ERROR_HANDLING_STRATEGY` now affects not only ReAct but all agents, and has been moved from `ReActAgentConfigOptions` to `AgentExecutionOptions`.
- Java Ollama Chat Model
  - The type of parameter `extract_reasoning` for the chat model setup has changed from string to boolean, and the default value has changed from `false` to `true`.
  - A new parameter `think` is introduced for controlling whether the think mode should be enabled. `extract_reasoning` no longer affects this behavior.

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Alan Z., Eugene, Ioannis Stavrakantonakis, Liu Jiangang, Marcelo Colomer, Shekharrajak, Weiqing Yang, Wenjin Xie, Xiang Li, Xintong Song, Xuannan, Yash Anand, chouc, dependabot\[bot\], tsaiggo, twosom