---
title: "Apache Flink Agents 0.4.0 Release Announcement"
date: "2026-10-30T00:00:00.000Z"
authors:
- wenjin:
  name: "Wenjin Xie"
aliases:
- /news/2026/10/30/release-flink-agents-0.4.0.html
---

The Apache Flink community is excited to announce the release of Apache Flink Agents 0.4.0.

Apache Flink Agents brings AI agents into Flink streaming pipelines. Applications can continuously respond to real-time events, combine AI processing with business logic, and use Flink for distributed execution and fault recovery.

Shaped by feedback from early production adopters and advances in the agent ecosystem, Flink Agents 0.4 marks the final planned step toward a production-ready 1.0 release for streaming agent applications. It expands agent capabilities with sub-agents and Decision Models, refines APIs to simplify application development, and strengthens observability to make agent behavior easier to understand and diagnose.

Flink Agents 0.4 remains a preview release, with APIs and configuration options still evolving. If you are upgrading from 0.3, please review the Breaking Changes below.

## What's New in 0.4?

### New Agent Primitives and Capabilities

#### Sub-agents: Delegate Tasks to Specialized Agents

[**Sub-agents**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/multi-agent/subagents/) let an agent delegate tasks to other agents in the same Flink job or to integrated external agent services, then continue processing with their results. Applications can delegate explicitly in code or let the model choose a sub-agent. Calls support durable execution, allowing recorded results to be reused during recovery.

#### Decision Models: Evaluate and Score Against Business Criteria

**Decision models**, such as TypeSafe's Jev, evaluate application context against defined criteria and return typed decisions as probabilities, choices, or scores. Flink Agents 0.4 introduces a unified [**Decision Model API**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/decision_models/) supporting TypeSafe, OpenAI, and Alibaba Cloud Model Studio, bringing these capabilities to streaming workflows for tasks such as content classification, satisfaction scoring, and risk assessment.

#### Model Routing: Choose the Right Model for Each Request

[**Model Routing**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/model_routing/) dynamically selects a model for each request from a set of candidates, using rule-based matching, an LLM judge, or custom routing logic. For example, an application can use a lightweight model for routine requests and a more capable model for complex tasks. Model Routing is currently available through the Java programmatic API.

#### Multimodal Input: Work with Text, Images, Audio, and Documents

New [**multimodal messages**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/chat/#message-content-blocks) can combine text, images, audio, and documents in a single message, enabling agents to analyze problems with visual context or extract information from documents.

#### Structured Output: Make Results Ready for Application Code

Version 0.4 expands [**native structured output**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/structured-output/) support across major model providers. Models can return classifications, extracted fields, and other data in an application-defined schema for direct use in business logic.

### Agent Build and Execution Enhancements

#### ctx.chat: Call Models Directly from Application Code

The new [`ctx.chat`](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/chat/#using-ctx-chat) API combines model calls and subsequent business logic in a single Action, without splitting request and response handling across two Actions. The framework executes configured tools requested by the model and returns the final result, with support for retries and structured output. With durable execution enabled, recorded responses can be reused during recovery.

#### Conditional Triggers: Select Processing Steps by Event Content

Previously, Actions were triggered by Event type alone. Version 0.4 adds [conditions on Event fields](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/create-agent/actions/#trigger-conditions) for finer control, such as running extra checks only when a transaction exceeds a threshold or escalating only severe alerts.

#### Tool Parameter Injection

[**Tool parameter injection**](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/tool_use/#tool-parameter-injection) lets users supply known arguments for tool calls instead of having the model generate them. Tools that depend on application configuration or runtime context can receive those values through injection, leaving the model to generate the arguments that require reasoning.

#### Asynchronous Execution: Support for More JDK Versions

Flink Agents already supported asynchronous execution in Python and in Java on JDK 21. Version 0.4 extends [Java asynchronous execution to JDK 11 and 17](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/create-agent/actions/#jdk-and-scheduling-requirements).

### Improved Observability

#### Trace Log: Follow Agent Execution

[Trace Log](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/operations/monitoring/#trace-log) extends 0.3's Event Log to capture execution steps, model, tool, and sub-agent calls, and their lineage—linking events, steps, and calls to show how an input produces a result. Users can configure recording scope and detail, and use a companion tool to visualize event lineage as a tree.

#### Richer Built-in Metrics

Version 0.4 adds [metrics](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/operations/monitoring/#built-in-metrics) for input processing successes and failures, backlog, queueing and execution latency, and calls to models, tools, and other components. These metrics integrate with existing Flink monitoring, helping users detect failures or latency issues and investigate them with Trace Log.

### Development Tools and Integrations

#### Build Applications with Coding Agents

The new [`flink-agents-dev` Skill](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/coding-agent-skill/) gives coding agents guidance specific to Flink Agents to help create, modify, and validate applications. Install it with:

```bash
npx skills add 'apache/flink-agents#release-0.4@flink-agents-dev'
```

#### More Model Integrations

This release adds:

- **Chat Models:** [Google Gemini](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/chat-models/providers/#gemini) for Java, and [vLLM](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/chat-models/providers/#vllm) and [IBM watsonx.ai](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/calling-llms/chat-models/providers/#watsonx-ibm-watsonxai) for Java and Python.
- **Embedding Models:** [OpenAI embeddings](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/docs/development/vector-search/embedding_models/providers/#openai) for Java.

## Breaking Changes

Version 0.4 includes more breaking changes than previous releases as we prepare for 1.0, when we plan to begin guaranteeing API compatibility. Feedback from early production users and our own API review revealed issues worth addressing before that commitment. We have therefore used 0.4 to make broader API improvements, aiming to resolve these issues before 1.0 rather than carry them forward as technical debt. When upgrading from 0.3, review:

- **APIs and message formats:** Update Action and cross-language declarations, and adapt to changes in how messages, model responses, and tool results are represented.
- **Defaults and configuration:** Review changes to retry defaults, concurrent execution, and default models. Check tool arguments, model settings, and retrieval limits against stricter validation rules, and update affected settings, integrations, and dependencies.
- **Action State and logging compatibility**: Action State Store data from 0.3 is incompatible with 0.4. Update Event Log settings and log readers for Trace Log, keep long-term memory handles within each Action, and review stricter restrictions on Skill downloads and shell commands.

We expect 0.4 to be the last release before 1.0. Feedback on this release may lead to further adjustments in 1.0, but we expect those changes to be limited. We will share the API compatibility policy with the community soon.

### Agent Definitions and Execution

- **Action declarations:** Java `@Action(listenEventTypes = ...)` becomes `@Action(...)`. Python’s programmatic `add_action(events=...)` argument and YAML’s `listen_to` field become `trigger_conditions`. Event-type names that could be interpreted as expressions must be quoted as literal trigger conditions. Ordinary Python `@action("event_type")` declarations remain valid.
- **Cross-language declarations:** The old Action `target` declarations, language-specific resource wrapper APIs, and Python `@java_resource` decorator have been removed. Use direct function declarations for cross-language Actions and `PythonResourceDescriptor` or `JavaResourceDescriptor` for resources. Ordinary YAML resource declarations using `type: java` or `type: python` remain available. Applications that persist resource descriptors must update their serialized declarations.
- **Python execution:** The standalone Python execution path, including `from_list()` and `to_list()`, has been removed. Supply a Flink `StreamExecutionEnvironment` and use DataStream or Table inputs and outputs. Local development remains possible through a local Flink runtime.
- **Durable asynchronous calls:** Java `durableExecuteAsync()` now returns a `DurableFuture`; callers must await it. Creating a future alone does not execute the call. Python’s normal `await ctx.durable_execute_async(...)` usage remains valid, but the old `AsyncExecutionResult` type has been replaced. The new Python `durable_id` keyword is reserved by the framework and is no longer forwarded to the called function.
- **Table outputs:** Java `toTable(Schema)` now maps output fields by the declared column names; schemas relying on the previous nested `f0` representation need updating. In Python, supplying both `schema` and `output_type` requires them to describe the same row type.
- **Concurrency defaults:** Independent tool calls can run concurrently under the default asynchronous configuration. Tools that depend on execution order should use separate sequential steps or explicitly limit parallelism. Experimental parallel Action execution is enabled by default for plans with only Java Actions on JDK 11–20 and can be disabled with `parallel-execution.enabled`.

### Messages, Model Results, and Tools

- **Chat messages and results:** `ChatMessage` now represents content through `blocks` and additional attributes through `metadata`. Update code using the old `content`, `extra_args`, and tool-call fields. Message content is updated by constructing a new message or using the provided replacement methods. Model calls now return `ChatResult`, which separates the assistant message from model information and usage. Update custom model integrations and stored message JSON to the new format.
- **Response handling:** `ChatResponseEvent` explicitly represents success or failure. Check its status before reading the response, and read parsed structured output from the event’s `structured_output` field rather than message metadata.
- **Retries and failure policy:** The framework’s `max-retries` default changes from **3 to 0**, and `error-handling-strategy` has been removed. Configure retries explicitly and handle failed chat responses in application logic. Provider SDK retries remain a separate setting.
- **Tool results and events:** Tool results use `ToolResponse` with text or content blocks and optional metadata. Java callers using `success(Object)` or `getResult()` must update; Python response events now carry `ToolResponse` objects instead of bare values. Tool request events use `ToolCallBlock`, and response events associate results with call IDs instead of the old `external_ids` field. MCP and Skill errors are reported as failed tool calls.
- **Tool arguments and metadata:** Arguments are validated before execution. Unknown fields, incorrect types, and invalid values fail the call; numeric strings and booleans are not converted into numbers. Defaults apply to missing arguments, while explicit null requires a nullable parameter. Java `@ToolParam.defaultValue` must be a JSON literal, and optional parameters need a valid default or must allow null. Python tool metadata exposes `args_schema` as a JSON Schema dictionary.
- **Reserved tool names:** Tool names must not start with `_subagent_`, which is now reserved for sub-agent calls. Rename existing function or MCP tools that use this prefix.
- **Structured-output behavior:** The default `AUTO` strategy can select native structured output, including an additional final formatting call. Applications that need the prompt-based behavior should select `PROMPT`. Requiring `NATIVE` fails when the request cannot use native structured output.
- **Java prompt substitution:** Substitution is now single-pass. Placeholders contained inside an inserted argument are treated as text rather than expanded again.

### Integrations and Configuration

- **DashScope naming:** Tongyi chat and embedding integrations have been renamed to DashScope. Update imports, class names, resource constants, and YAML aliases; the old names are not retained.
- **Azure AI Inference:** The deprecated Azure AI Inference integration, its Maven module, resource constants, and `azure` YAML alias have been removed. Azure OpenAI remains supported.
- **Model configuration:** Native Python chat-model connections and setups reject unknown constructor arguments instead of silently ignoring them. Correct unsupported or misspelled options and use the integration’s documented extension parameters.
- **Default models:** The Python OpenAI default model changes from `gpt-3.5-turbo` to `gpt-4o-mini`, and Anthropic’s default changes from `claude-sonnet-4-20250514` to `claude-sonnet-4-6`. Applications relying on implicit defaults should configure their intended model explicitly.
- **Provider timeouts, retries, and errors:** Java OpenAI, Azure OpenAI, and OpenAI Responses connections use a 60-second default timeout and three SDK retries. Timeout and retry values are validated more strictly; a zero timeout disables the timeout. Direct calls to these Java integrations preserve provider exceptions instead of wrapping them in a generic exception. Anthropic sampling parameters are omitted for models that reject them.
- **OpenAI embeddings:** Python `additional_kwargs` are sent as additional request-body properties and cannot override explicitly supported fields. They are also represented as a nested entry in `model_kwargs`. Embedding dimensions must be positive integers, and `request_timeout=0` disables the timeout.
- **Retrieval parameters:** `VectorStoreQuery.limit` and `ContextRetrievalRequestEvent.max_results` must be positive. Elasticsearch configurations should use `k` rather than the previous `top_k` entry in `model_kwargs`, and ensure `num_candidates >= k`.
- **Python dependencies:** Dependency requirements have changed, notably to Pydantic 2.12.x and OpenAI SDK 3.26 or later within 3.x. Update application dependency constraints and lock files accordingly.

### State, Logging, and Usage Constraints

- **Action State Store compatibility:** **Action State Store data written by 0.3 is not compatible with 0.4.** Plan upgrades without reusing the old Action execution history. This applies to saved Action execution records and does not imply that all Flink checkpoint or savepoint data is incompatible.
- **Pending Actions during upgrades:** Restoring operator snapshots containing pending Actions may fail when upgrading from earlier versions to 0.4.0. This limitation also existed in earlier releases. Validate checkpoint or savepoint restoration with representative application state before upgrading.
- **Trace Log migration:** Event Log configuration and extension APIs have been replaced by Trace Log. Old keys such as `eventLoggerType`, `baseLogDir`, `prettyPrint`, and `event-log.*` are rejected. Use `trace-log.output-type`, `trace-log.base-dir`, `trace-log.pretty-print`, `trace-log.standard.*`, and `trace-log.targets` as appropriate. Update custom logger implementations, collectors, and parsers for the new interfaces, format, logger category, and filenames. Recording remains Event-only by default.
- **Long-term memory:** Obtain a `MemorySet` within each Action that uses it; do not cache it across Actions. Obtaining or deleting sets by name requires the Action context, and operations without a nonempty partition key are rejected.
- **Memory references:** Java `MemoryRef` equality now considers both memory type and path, so sensory and short-term memory references with the same path are distinct. Null memory types and paths are rejected. Applications with custom JSON readers or writers for memory references must follow the updated representation.
- **Built-in Event validation:** At JSON deserialization and cross-language boundaries, built-in Events must satisfy their declared attribute formats. Missing, incorrectly typed, or additional attributes are rejected. Use custom Events or attachments for additional application data.
- **Other validation changes:** Invalid memory paths, including empty path components and writes beneath an existing value field, are rejected. Retry settings must use valid nonnegative counts and backoff ranges. Raw byte payloads are not accepted as PyFlink Agent inputs.
- **Batch execution:** Explicit BATCH execution with Flink’s default batch state backend is rejected. Use STREAMING execution or explicitly disable the batch state backend for an otherwise supported workflow.
- **Remote Skills:** Remote Skill downloads require HTTPS by default. HTTP requires explicit opt-in, and URLs containing embedded credentials are rejected. URL and hostname validation is stricter, including checks on redirect targets.
- **Skill shell commands:** Shell execution rejects additional unsafe constructs, including arithmetic expansion, declaration commands, standalone variable assignments, environment variable assignments that affect command execution, and file redirections. Review existing Skill scripts against the supported command rules.

## Get Started and Share Your Feedback

Visit the [Apache Flink downloads page](https://flink.apache.org/downloads/#apache-flink-agents-040) for release artifacts. For guidance on building, deploying, and operating agents, see the [Flink Agents documentation](https://nightlies.apache.org/flink/flink-agents-docs-release-0.4/).

We welcome feedback on the applications you are building, the capabilities you need, and any problems you encounter. Submit feature requests and bug reports through [GitHub Issues](https://github.com/apache/flink-agents/issues), or share use cases and ideas in [GitHub Discussions](https://github.com/apache/flink-agents/discussions). You can also ask questions and share feedback in the [#flink-agents-user](https://apache-flink.slack.com/archives/C09KP5YUWE8) channel on the Apache Flink Slack workspace.

## List of Contributors

The Apache Flink community thanks everyone who contributed code, documentation, tests, reviews, and feedback to this release.

Alan Z., Ashfaq, Cansu Kertmen, Dagdraumur, daierenao, daken, Edson, Eugene, Femi, Gen Luo, Goutam Adwant, Haocong Wang, Howie Wang, hulincup, hylin, Jinkun Liu, John, Kerui Wang, Leo Wang, Muhammad Naufal Mahdi, Purshotam Shah, rob-9, Sangkyoon Nam, Shawn, Stefan Wang, Tachikoma, vishnu prakash, wank125, Weiqing Yang, Wenjin Xie, william, yanjin, Yi Zhang, Yifan Chen, Yu Tang, yunfengzhou-hub, zxs1633079383, zzwqqq
