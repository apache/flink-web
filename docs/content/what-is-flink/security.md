---
title: Security
bookCollapseSection: false
weight: 8
aliases:
- /security.html
- /security/index.html
---
<!--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

# Security

## Apache Flink

Apache Flink is a distributed stream and batch processing framework that executes user-supplied code across a cluster of machines.

### Trust Boundary

Flink's security model is built around one explicit trust boundary: **the cluster operator is trusted; the cluster network interfaces are not public**.

**Authenticated users who submit jobs are fully trusted.** Flink executes submitted code unconditionally. A job can spawn processes, open network connections, read and write local files, and perform any operation the operating system permits. This is intentional -- restricting what user code can do would prevent legitimate use cases. Flink is not a sandbox.

**Unauthenticated access to cluster interfaces is the threat Flink protects against.** The REST API, SQL Gateway, and BLOB server are the surfaces that must be secured from external attackers.

### Security Boundary Reference

The table below is intended for security researchers and enterprise security teams evaluating Flink:

| Scenario | Security boundary | Notes |
|---|---|---|
| Unauthenticated access to the REST API | **In scope** | Vulnerability -- report it |
| Path traversal or unauthorized file access via REST API | **In scope** | Vulnerability -- report it |
| SQL injection or auth bypass via SQL Gateway | **In scope** | Vulnerability -- report it |
| Credential or secret exposure in cluster interfaces | **In scope** | Vulnerability -- report it |
| Code execution via unsafe deserialization of input data where no Flink-level control exists to prevent it | **In scope** | Vulnerability -- report it |
| Remote Code Execution (RCE) via a submitted JAR, DataStream program, or UDF | **Out of scope** | By design -- these submitters run arbitrary code; does not apply to SQL Gateway submissions |
| Spawning processes or opening connections from within a running job | **Out of scope** | By design |
| Reading or writing files from within a running job | **Out of scope** | By design |

### Deployment Requirements

Flink clusters must not be exposed to the public internet. Access to all Flink network interfaces must be restricted to trusted principals via network-level controls (firewalls, security groups, VPN).

SSL/TLS, REST API authentication, and SQL Gateway authentication are all **disabled by default**. A default Flink deployment is unauthenticated and unencrypted on its network interfaces. These need to be explicitly configured for any production or shared deployment.

The REST API supports mutual TLS for client certificate authentication; anything beyond that, and all SQL Gateway authentication, needs to be provided by a proxy in front of Flink's network interfaces.

Flink does not manage the security of external systems it connects to. Through its delegation token framework, Flink can obtain and renew short-lived tokens on the operator's behalf, but the underlying long-lived credentials remain an operator responsibility.

## Flink Kubernetes Operator

The [Flink Kubernetes Operator](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-stable/) is the standard deployment mechanism for Flink on Kubernetes. Its security model extends the Flink model above -- both apply when the operator is in use.

### Trust Boundary

The Kubernetes RBAC layer replaces direct cluster access as the authentication mechanism. Any principal with permission to apply Flink custom resources (`FlinkDeployment`, `FlinkSessionJob`) is the equivalent of an authenticated Flink user -- they can submit arbitrary jobs with full execution trust. The operator's own service account is trusted by the Kubernetes control plane with cluster-scoped permissions.

### Security Boundary Reference

| Scenario | Security boundary | Notes |
|---|---|---|
| Using the operator API to access resources beyond the submitting principal's own permissions | **In scope** | Vulnerability -- report it |
| Credential exposure via Flink custom resource spec or status fields | **In scope** | Vulnerability -- report it |
| Webhook bypass allowing malformed or malicious resources to be applied | **In scope** | Vulnerability -- report it |
| Information disclosure via operator logs or metrics | **In scope** | Vulnerability -- report it |
| A principal with Flink custom resource apply permission submitting a malicious job | **Out of scope** | By design -- same trust model as authenticated job submission |
| RBAC misconfiguration by the cluster administrator | **Out of scope** | Operator responsibility |

### Deployment Requirements

The operator runs with cluster-scoped RBAC by default -- apply least-privilege principles and restrict its service account to the minimum required permissions. The admission webhook requires TLS, which Kubernetes enforces. Credentials in Flink custom resource specifications flow through Kubernetes secrets and must be managed according to your organization's secret management policies. Restrict Flink custom resource apply permissions to trusted principals.

## Known Vulnerabilities

The Flink project does not maintain its own CVE list. For a complete and up-to-date record of known vulnerabilities, consult the authoritative external databases:

- [Apache Security](https://security.apache.org/projects/flink/) -- ASF-maintained, authoritative record for Apache Flink CVEs

## Reporting a Vulnerability

If you discover a vulnerability in Flink's own infrastructure, please report it privately through one of the following channels:

- **Apache Security Team:** [security@apache.org](mailto:security@apache.org) -- preferred for CVE assignment and coordinated disclosure
- **Flink PMC (private):** [private@flink.apache.org](mailto:private@flink.apache.org) -- for direct discussion with the Flink PMC
