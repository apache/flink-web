---
title:  "Apache Flink Agents 0.3.0 Release Announcement"
date: "2026-06-19T00:00:00.000Z"
authors:
- wenjin:
  name: "Wenjin Xie"
aliases:
- /news/2026/06/19/release-flink-agents-0.3.0.html
---

The Apache Flink Community is excited to announce the release of Apache Flink Agents 0.3.0.

Get access to Flink Agents 0.3.0 now:
- Download the release [here](https://flink.apache.org/downloads/#apache-flink-agents-030).
- Find documentation and quickstart examples [here](https://nightlies.apache.org/flink/flink-agents-docs-release-0.3/).

<div class="alert alert-info" markdown="1">
<span class="label label-info" style="display: inline-block"><span class="glyphicon glyphicon-info-sign" aria-hidden="true"></span> Note</span>
Agents 0.3.0 is a preview version, which means:

- Some functionalities may contain known or unknown issues. You can check the list of known issues and their resolution status via the [Github Issues](https://github.com/apache/flink-agents/issues).
- The current APIs and configuration options are experimental and may undergo non-backward compatible changes in future versions.
</div>

We greatly appreciate any feedback you can provide, whether it's sharing how you're using our product, suggesting new features, helping us identify and fix bugs, or anything else that comes to mind. Your insights are invaluable to us.

You may reach out to us via:
- [Join the Apache Flink Slack](https://flink.apache.org/what-is-flink/community/#slack) and ask for help in [#flink-agents-user](https://apache-flink.slack.com/archives/C09KP5YUWE8).
- Post feature requirements and bug reports at [Github Issues](https://github.com/apache/flink-agents/issues).
- Share your use case and ideas at [Github Discussions](https://github.com/apache/flink-agents/discussions).

## What is Apache Flink Agents?

Apache Flink Agents is a **streaming Agent OS** for enterprise, production-grade scenarios. Three characteristics define it: it is **event-driven, distributed, and reliable**. Like any other Agent OS, it manages the core building blocks of an agent — orchestration, context, memory, and tool/MCP invocation. But more than that, because it targets production workloads at scale, it also handles distributed coordination, consistency, fault tolerance and recovery.

In one line, Flink Agents brings AI agents into the Flink streaming pipeline — an agent becomes a first-class operator in your real-time datastream. Why would you want that? Because a fast-growing class of workloads needs AI decisions to be made in the flow of live events, not in response to a human prompt:

*   **Intelligent operations (AIOps).** System telemetry — logs, metrics, traces, alerts — streams in continuously; an agent on that stream can detect anomalies, diagnose root causes, and trigger remediation the moment a problem surfaces, rather than waiting for an engineer to notice and ask.

*   **Real-time risk control.** Transactions, logins, and user actions arrive as a high-rate event stream; an agent must assess each one and act — approve, block, or challenge — within seconds, to stop fraud before it completes.

*   **IoT.** Fleets of devices and sensors emit measurements nonstop; an agent can interpret these streams, catch equipment anomalies, and decide on actions as conditions change — autonomously and around the clock.

*   **Real-time multimodal processing.** Live audio, video, and image streams need to be understood and acted on as they arrive; an agent can perceive, reason over, and respond to multimodal input in the flow, instead of in one-off batch requests.


## Why Flink?

These production agent scenarios share a common shape:

*   **Event-driven.** The AI processing is triggered automatically by system events, not by human requests.

*   **Distributed.** Systems emit events at a volume, scale, and frequency far beyond human-initiated requests, so they must be processed in a distributed fashion.

*   **Reliable.** Being event-driven, these agents must run continuously and correctly without human supervision. Combined with the high stability bar of production — and the fact that single-point failures are inevitable in any distributed system — this demands strong fault tolerance and self-healing.


Years of building Flink have taught us that a reliable, distributed, coordinated event-stream processing system is not something you get by running a single-node agent as a few replicas, adding some retries, and switching to event-triggered invocation. Massive scale, millisecond latency, exactly-once consistency, fault tolerance, and stateful coordination are hard distributed-systems problems — and they are exactly what Flink has spent over a decade solving in production. So instead of reinventing that runtime, Flink Agents lets you run modern AI agents directly on Flink's battle-tested distributed streaming runtime.

## What's New in the 0.3 Release?

### Agent Primitives

#### Agent Skills Support

Agent Skills are an emerging standard for packaging prompts, tools, and resources into self-contained capabilities that an agent can discover and load on demand. Flink Agents 0.3 adds support for using Agent Skills, available in both the Python and Java APIs. See the documentation for more details.

#### Mem0-Based Long-Term Memory

Long-Term Memory is now backed by [Mem0](https://github.com/mem0ai/mem0) in both Python and Java, replacing the previous vector-store-based implementation. This delivers more robust semantic retrieval, summarization, and isolation, and comes with a Mem0 vector store integration.

### Programming Model

#### YAML API for Declaring Agents

Flink Agents 0.3 introduces a declarative YAML API for describing agents in both Python and Java. Resources such as chat model connections, prompts, tools, and vector stores are declared in YAML, while action logic continues to live in Python or Java code and is referenced from YAML via function pointers. This separation decouples infrastructure configuration from business logic, making it easy to swap model providers or adjust prompts across environments without touching action code. A [JSON Schema](https://github.com/apache/flink-agents/blob/release-0.3/docs/yaml-schema.json) is published alongside the YAML API to support IDE validation, autocompletion, and LLM-assisted authoring.

#### Cross-Language Actions

Building on the cross-language resource access introduced in 0.2, Flink Agents 0.3 adds **Cross-Language Actions**: you can author an action in one language and run it inside an agent built in the other — for example, invoking a Java action from a Python agent, or vice versa. Functions, FunctionTools, and events are now unified across the two runtimes.

### Reliability & Observability

#### Durable Reconciler

Durable execution gains a reconciler mechanism: durable blocks can register reconciler callables to reconcile in-flight side effects upon failure recovery, with reconciler exceptions persisted as failures. This is supported in both Python and Java.

#### Fluss as Action State Store

Flink Agents 0.3 adds [Apache Fluss (Incubating)](https://fluss.apache.org/) as a supported backend for the action state store, alongside the existing options such as Kafka.

#### Enhanced Observability

*   EventLog display is enabled in the Flink WebUI by default.

*   Support per-event-type configurable log levels.

*   New key-value metric groups for model and action dimensions, along with chat-model retry metrics.


### Expanded Ecosystem Integrations

Flink Agents 0.3 broadens its built-in integrations across model providers and vector stores:

*   **Chat Models:**

    *   Amazon Bedrock.

    *   Azure OpenAI and the OpenAI Responses API.

*   **Embedding Models:**

    *   Amazon Bedrock.

    *   Tongyi.

*   **Vector Stores:**

    *   Amazon OpenSearch, Amazon S3 Vectors, Milvus, and Mem0.


### Other Improvements

*   Short-Term Memory now supports TTL.

*   Chat actions support a configurable retry interval, complementing the new retry metrics.

*   Async execution support for cross-language resources.

*   Custom job names, an installation Import Wizard, and Python 3.12 support.


## Breaking Changes

*   **Event-typed action declaration:** Actions now listen on _event type strings_ rather than event classes. In Java, `@Action(listenEvents = {InputEvent.class})` becomes `@Action(listenEventTypes = {InputEvent.EVENT_TYPE})`; in Python, `@action(InputEvent)` becomes `@action(InputEvent.EVENT_TYPE)`. 
    
*   **Chat model `chat()` signature:** Prompt arguments and model parameters are now separate. Java `chat(messages, params)` becomes `chat(messages, promptArgs, modelParams)` and Python `chat(messages, **kwargs)` becomes `chat(messages, prompt_args, **kwargs)`; the connection-layer argument is renamed to `modelParams`.

*   **Model name now required:** `ChatModelSetup` requires an explicit model name; configurations that previously relied on a default must specify one.

*   **Action state store backend:** The backend must be configured explicitly (e.g. Kafka or the newly added Fluss) — there is no implicit default.

*   **Long-Term Memory:** The vector-store-based long-term memory implementation has been removed in favor of Mem0-based long-term memory. Agents using long-term memory should migrate to the Mem0 backend.

*   **Vector store API:** The vector store API was refactored — `embedding_model` is now optional (pass pre-computed embeddings when omitted), and queries support a unified `filters` DSL.


### API Compatibility & Roadmap

We know that a stable, backward-compatible API matters to anyone building on Flink Agents, and committing to compatibility as early as possible is a priority for us. At the same time, the agent space is evolving fast, and our own experience working alongside early users has surfaced real usability gaps in the current API. We'd rather fix those now than freeze them into a 1.0 we all have to live with.

So our plan is:

*   **0.4** will focus on polishing the existing API. This means it may still introduce breaking changes relative to 0.3 — the last round, aimed at getting the API right.

*   After 0.4 ships, we'll let it settle and validate it in real use. If things go smoothly, **1.0** will follow shortly after, with only minor adjustments from 0.4.

*   From **1.0** onward, we will formally commit to API compatibility.


If you're building on Flink Agents today, thank you — your feedback is exactly what's shaping these final changes. Expect one more migration across 0.3 → 0.4 → 1.0, and a stable foundation from there.

## List of Contributors

The Apache Flink community would like to thank each and every one of the contributors that have made this release possible:

Adesh Nalpet Adimurthy, Alan Z., Avichay Marciano, Eugene, Haocong Wang, Howie Wang, JennyChen, Jinkun Liu, Joey Tong, Junbo Wang, Kerui Wang, Leonard Xu, meichuanyi, Nico Duldhardt, Vino1016, WAR10CK, Weiqing Yang, Wenjin Xie, XL Zhao, Xintong Song, Xuannan, Yash Anand, bosiew.tian, daken, hope, twosom, vishnu prakash, wangxinglong, yan.xu, yunfengzhou-hub
