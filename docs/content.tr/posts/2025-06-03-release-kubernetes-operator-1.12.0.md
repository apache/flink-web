---
title:  "Apache Flink Kubernetes Operator 1.12.0 Release Announcement"
date: "2025-06-03T18:00:00.000Z"
authors:
- gaborgsomogyi:
  name: "Gabor Somogyi"
aliases:
- /news/2025/06/03/release-kubernetes-operator-1.12.0.html
---

The Apache Flink community is excited to announce the release of Flink Kubernetes Operator 1.12.0!
The version brings a number of important fixes and improvements to both core and autoscaler modules.

We encourage you to [download the release](https://flink.apache.org/downloads.html) and share your experience with the
community through the Flink [mailing lists](https://flink.apache.org/community.html#mailing-lists) or
[JIRA](https://issues.apache.org/jira/browse/flink)! We're looking forward to your feedback!

## Highlights

### Enhanced Error Visibility and Event Reporting

This release places a strong emphasis on improving the visibility and transparency of errors across the entire Flink Kubernetes Operator stack. These improvements aim to significantly enhance the user experience by making error diagnosis and resolution faster and more intuitive.

- **Comprehensive Event Reporting**: Events are now emitted across all critical stages of the job lifecycle-from controller errors within the operator itself, to failures during job startup, and even runtime exceptions within Flink jobs. This end-to-end observability ensures that users are promptly informed of any issues that occur.

- **Detailed Error Messages**: The operator now captures and surfaces more granular error messages for deployment and reconciliation failures. These messages are visible in the custom resource status and help users understand and address problems more effectively.

- **Automatic Kubernetes Event Generation**: Whenever a job enters the `FAILED` state or restarts unexpectedly, the operator emits corresponding Kubernetes events. These events can be consumed by external monitoring systems or used directly in `kubectl` to monitor job health.

- **Improved Operator Diagnostics**: Controller-level errors, which were previously difficult to trace, are now clearly reported and contextualized with helpful messages, allowing users and developers to better trace the root cause of failures.

These improvements make the Flink Kubernetes Operator more robust, transparent, and easier to operate, especially in complex or large-scale production environments.

### Helm Chart Improvements

- **Flink `config.yaml` Support**: The operator adds compatibility with Flink's `config.yaml` format, ensuring seamless integration with the latest Flink configurations.
- **Upfront YAML Configuration Validation**: Introduced validation for Flink 2.x configurations, enabling early detection of misconfigurations before deployment.
- **Init and Sidecar Container Configuration**: Users can now configure init and sidecar containers within their deployments, offering greater flexibility in customizing the Flink runtime environment.
- **Observer Optimization**: The observer component has been refined to avoid checking all JobManager replicas, reducing unnecessary overhead and improving performance.

### Bug Fixes and Stability Enhancements

- **Batch Job Completion Handling**: Resolved an issue where finished batch jobs threw `ReconciliationException` and did not reach the FINISHED state in the custom resource.
- **Savepoint Information Update**: Fixed a bug where upgrade savepoints were not added to the deprecated `savepointInfo`, ensuring accurate tracking of savepoints during upgrades.
- **Last-State Upgrade Mode for Flink 2.0**: Addressed a problem where the last-state upgrade mode was broken for Flink 2.0, restoring expected behavior during upgrades.
- **Helm Chart Correction**: Corrected the Helm chart to reference the valid image repository, preventing deployment issues related to incorrect image paths.

## Release Notes

The full release notes can be found [here]( https://issues.apache.org/jira/secure/ReleaseNote.jspa?projectId=12315522&version=12355683).

## Release Resources

The source artifacts and helm chart are available on the Downloads page of the Flink website. You can easily try out the new features shipped in the official 1.12.0 release by adding the Helm chart to your own local registry:

```
$ helm repo add flink-kubernetes-operator-1.12.0 https://archive.apache.org/dist/flink/flink-kubernetes-operator-1.12.0/
$ helm install flink-kubernetes-operator flink-kubernetes-operator-1.12.0/flink-kubernetes-operator --set webhook.create=false
```

You can also find official Kubernetes Operator Docker images of the new version on [Dockerhub](https://hub.docker.com/r/apache/flink-kubernetes-operator).

For more details, check the [updated documentation](https://nightlies.apache.org/flink/flink-kubernetes-operator-docs-release-1.12/) and the release notes. We encourage you to download the release and share your feedback with the community through the Flink mailing lists or JIRA.

## List of Contributors

Andrea, Daren, David Kornel, Eduardas Kazakas, Gyula Fora, Nick Caballero, Rodrigo, Santwana Verma, Thomas Weise, ctrlaltdilj, pchoudhury22, siddr
