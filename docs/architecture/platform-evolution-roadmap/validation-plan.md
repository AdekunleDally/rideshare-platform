# Validation Plan

## Overview

This document defines the approach for validating the evolution of the RideShare Platform throughout its migration to the target architecture.

Validation ensures that each migration phase achieves its intended outcomes before subsequent architectural changes are introduced. The objective is to identify issues early, maintain platform stability and ensure that the evolving platform continues to meet functional and operational expectations.

## Phase Status

| Phase   | Objective                  | Status   |
| ------- | -------------------------- | -------- |
| Phase 0 | Architecture and strategy  | Complete |
| Phase 1 | Platform governance        | Complete |
| Phase 2 | Platform evolution         | Complete |
| Phase 3 | Platform automation        | Complete |
| Phase 4 | Operations and reliability | Planned  |

A phase is considered complete only when its implementation has been validated and the supporting evidence has been recorded.

---

# Validation Principles

Platform validation follows these principles:

* Validate each migration phase independently.
* Confirm both functional and operational behaviour.
* Test architectural changes before decommissioning existing components.
* Validate failure scenarios in addition to normal operation.
* Automate validation where practical.
* Retain evidence for significant implementation and validation activities.

A migration phase should only be considered complete when its defined exit criteria have been satisfied.

---

# Validation by Phase

## Phase 0 – Architecture and Strategy

### Status

**Complete**

### Validation Objectives

Confirm that the architectural direction for the platform has been clearly defined.

### Validation Criteria

* Current-state architecture has been documented.
* Target-state architecture has been documented.
* Migration strategy has been defined.
* Major architectural decisions have been recorded.
* Repository structure supports the proposed platform evolution.

---

## Phase 1 – Platform Governance

### Status

**Complete**

### Validation Objectives

Verify that engineering standards and documentation provide a consistent foundation for future platform development.

### Validation Criteria

* Platform standards have been documented.
* Cloud conventions are established.
* Platform inventory is complete.
* Architecture documentation is organised and consistent.
* Architecture Decision Records accurately reflect significant design decisions.

---

## Phase 2 – Platform Evolution

### Status

**Complete**

### Validation Objectives

Confirm that the platform successfully operates using its target architectural components.

### Validation Criteria

#### Regional Platform

* Both Amazon EKS clusters successfully deploy the RideShare application.
* Regional configurations remain consistent.
* Platform components operate correctly in both regions.

#### Managed Data Services

* Amazon RDS successfully replaces CloudNativePG.
* Amazon ElastiCache successfully replaces the Redis Operator.
* Application data remains consistent following migration.
* Secrets are synchronised successfully using External Secrets Operator.

#### Application

* All services deploy successfully.
* Application APIs operate correctly.
* WebSocket communication functions correctly.
* TLS certificates are valid.
* Ingress routing behaves as expected.

#### Global Traffic Management

- Route 53 latency-based routing is configured for both regions.
- Both regional endpoints participate in global traffic routing.
- Health checks correctly report the current health of each regional endpoint.
- The global production endpoint remains accessible under normal operation.

---

## Phase 3 – Platform Automation

### Status

**Complete**

### Validation Objectives

Confirm that application delivery is automated, repeatable, controlled and reliable across both production regions.

### Validation Criteria

* Continuous Integration pipelines complete successfully.
* Application images are published successfully.
* Continuous Delivery deployments complete successfully.
* GitHub Actions uses OpenID Connect to obtain short-lived AWS credentials.
* Deployment access to both Amazon EKS clusters functions correctly.
* The use1 production deployment is protected by a GitHub Environment approval gate.
* Helm deployments are repeatable across both production regions.
* Kubernetes application rollouts complete successfully.
* Regional and production application health checks complete successfully.
* Failed Helm upgrades automatically restore the previous successful release.
* Resources created by failed upgrades are cleaned up.
* Platform deployments remain consistent across regions.

### Continuous Delivery Validation

Continuous Delivery was validated against:

| Region      | Cluster               | Result |
| ----------- | --------------------- | ------ |
| `us-east-1` | `rideshare-prod-use1` | Pass   |
| `us-east-2` | `rideshare-prod-use2` | Pass   |

The validation confirmed:

* successful GitHub OIDC authentication;
* successful EKS authentication and authorisation;
* correct regional cluster selection;
* successful Helm deployments;
* successful Kubernetes rollouts;
* healthy application workloads;
* successful regional health checks; and
* successful production health checks.

Supporting evidence:

* [Multi-Region Continuous Delivery Validation](../../../evidence/application-validation/2026-09-02-multi-region-cd-validation.md)

### Rollback Validation

Automatic Helm rollback protection was implemented using:

```text
--atomic
--cleanup-on-fail
--timeout 10m
```

Rollback behaviour was validated in `rideshare-prod-use2` through a controlled failed deployment using a deliberately nonexistent frontend image tag.

The test produced the following Helm revisions:

| Revision | Status     | Description                                            |
| -------: | ---------- | ------------------------------------------------------ |
|        9 | Superseded | Previous successful application release                |
|       10 | Failed     | Controlled upgrade failure caused by the invalid image |
|       11 | Deployed   | Automatic rollback to revision 9                       |

Post-rollback validation confirmed:

* Helm returned the release to `deployed`;
* the frontend image was restored to tag `2.0`;
* the failed frontend ReplicaSet was scaled down to zero;
* no pod referenced the deliberately invalid image;
* all application deployments had their required replicas available;
* HPA-managed replica counts remained correct;
* the use2 regional health endpoint returned `OK`; and
* the production health endpoint returned `OK`.

Supporting evidence:

* [Helm Rollback Validation](../../../evidence/application-validation/2026-09-02-helm-rollback-validation.md)

### Phase 3 Conclusion

Phase 3 is complete because the platform now provides:

* repeatable multi-region application delivery;
* protected use1 production deployment;
* short-lived AWS authentication through GitHub OIDC;
* automated Kubernetes and application validation;
* automatic rollback protection; and
* validated recovery from a failed Helm upgrade.

---
## Phase 4 – Observability & Site Reliability Engineering

### Status

**Planned**

### Objective

Establish the telemetry, reliability objectives, operational controls and
recovery procedures required to operate the RideShare Platform as a measurable,
resilient and supportable multi-region production service.

### Validation Criteria

#### Metrics and Dashboards

- Prometheus collects Kubernetes, platform and application metrics.
- Grafana provides regional and global platform dashboards.
- Kubernetes control-plane, node and workload health are visible.
- Application request rate, error rate, duration and saturation are measurable.
- Amazon RDS and Amazon ElastiCache metrics are available.
- Dashboard configuration is maintained through version-controlled definitions.

#### Centralized Logging

- Application and platform logs are collected centrally.
- Logs can be filtered by region, cluster, namespace, service and pod.
- Failed requests can be correlated with the responsible workload.
- Log retention and storage limits are defined.
- Sensitive information is excluded from collected logs.

#### Distributed Tracing

- Application requests can be traced across relevant RideShare services.
- Trace context is propagated between participating services.
- Slow and failed service interactions can be identified.
- Trace data can be correlated with metrics and logs.

#### Service Level Objectives

- User-facing Service Level Indicators are defined.
- Availability and latency Service Level Objectives are documented.
- Error-budget calculations are implemented.
- Reliability performance can be measured independently for each region.
- Global production availability can be measured.

#### Alerting

- Alerts detect user-impacting symptoms rather than only infrastructure events.
- Alerts exist for availability, latency, error rate and resource saturation.
- Alerts include severity, impact and investigation guidance.
- Alert notifications reach a configured destination.
- Alerts are tested deliberately.
- Noisy or unactionable alerts are removed or refined.

#### Incident Response

- Incident severity levels are defined.
- Alert triage and escalation procedures are documented.
- Operational runbooks exist for significant failure scenarios.
- A simulated incident has been investigated using platform telemetry.
- Incident findings and corrective actions are captured in a post-incident review.

#### Resilience and Recovery

- Backup procedures complete successfully.
- Data restoration is validated.
- Regional failure is detected by health checks and monitoring.
- Route 53 withdraws an unhealthy region successfully.
- The application remains available through the healthy region.
- Regional recovery and traffic restoration are validated.
- Recovery Point Objective and Recovery Time Objective results are recorded.

#### Capacity and Performance

- Node and workload resource utilisation are reviewed.
- HPA behaviour is observable and validated.
- Cluster Autoscaler behaviour is observable and validated.
- Capacity thresholds and scaling limits are documented.
- Application performance is tested under representative load.

### Exit Criteria

Phase 4 is complete when:

- metrics, logs and traces are available for the required platform components;
- dashboards represent regional and global application health;
- measurable SLIs and SLOs have been defined;
- actionable alerts have been delivered and tested;
- an incident scenario has been investigated using collected telemetry;
- backup restoration has been validated;
- regional failover and recovery have been demonstrated;
- operational runbooks have been validated; and
- supporting evidence has been recorded.




---

# Validation Categories

Platform validation should include the following categories:

| Category       | Validation focus                                                          |
| -------------- | ------------------------------------------------------------------------- |
| Infrastructure | AWS resources, networking and Kubernetes clusters                         |
| Platform       | Ingress, cert-manager, External Secrets Operator and platform controllers |
| Application    | APIs, frontend, WebSocket communication and service health                |
| Data           | Amazon RDS, Amazon ElastiCache and data integrity                         |
| Networking     | DNS, TLS, ingress and Route 53 routing                                    |
| Automation     | CI, CD, deployment approval, post-deployment validation and rollback      |
| Observability  | Metrics, dashboards, logs, alerts and traces                              |
| Reliability    | Regional failover, disaster recovery and backup restoration               |
| Operations     | Monitoring, troubleshooting and operational procedures                    |

---

# Evidence Requirements

Each validation record should include:

* validation date;
* target environment and AWS Region;
* change or test performed;
* expected result;
* actual result;
* relevant commands, logs or screenshots;
* pass or fail conclusion;
* rollback result where applicable; and
* related workflow, pull request, issue or ADR.

Evidence is maintained under:

```text
evidence/
```

A phase must not be marked complete until its required validation evidence has been recorded.

---

# Completion Criteria

The platform evolution is considered successfully validated when:

* every migration phase satisfies its defined exit criteria;
* application functionality has been verified in both Amazon EKS clusters;
* managed AWS services operate correctly;
* regional traffic routing has been validated;
* platform automation is operational;
* failed deployments can be recovered safely;
* observability and operational tooling function as expected; and
* the platform demonstrates resilience during planned failure scenarios.

---

# Relationship to Other Documents

This document should be read alongside:

* [Platform Evolution Roadmap](./platform-roadmap.md), which defines the platform evolution phases and implementation sequence;
* [Dependency Map](./dependency-map.md), which identifies dependencies between migration activities;
* [Risks and Mitigations](./risks-and-mitigations.md), which identifies migration risks and mitigation strategies;
* [Evidence Index](../../../evidence/README.md), which indexes implementation and validation evidence; and
* [Architecture Decision Records](../decisions/README.md), which explain the rationale behind significant architectural decisions.

Together, these documents define how the RideShare Platform is evolved, protected and validated throughout its architectural transformation.
