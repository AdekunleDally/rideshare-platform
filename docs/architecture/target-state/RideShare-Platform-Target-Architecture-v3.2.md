# RideShare Platform Target Architecture

**Document ID:** RSPA-001  
**Version:** 3.2  
**Status:** Target State  
**Owner:** Platform Engineering

---

# 1. Purpose

The RideShare Platform Target Architecture defines the desired production architecture for the RideShare Platform and the controlled evolution from the current implementation to that target state.

The architecture reflects the project theme:

> **Engineering the evolution of a cloud-native RideShare application from a single-region Kubernetes deployment using Amazon EKS, CloudNativePG and the Redis Operator to a production-oriented, multi-region platform built on Amazon RDS, Amazon ElastiCache, automation, observability, operational controls and Platform Engineering principles.**

This document explains:

- what the original platform was;
- the limitations and governance gaps of that platform;
- what will be retained;
- what will be replaced;
- how the second region will be designed;
- how the current and new clusters will coexist during migration;
- how the existing cluster will become governance-compliant;
- how the infrastructure can be reproduced;
- what evidence will prove the migration succeeded;
- the main architectural trade-offs.

Detailed engineering rules remain in the governance documents. Implementation procedures remain in runbooks, Helm charts, `eksctl` configuration, validation scripts and CI/CD workflows.

---

# 2. Original Platform

The RideShare application currently runs in a single Amazon EKS cluster:

```text
lukman-rideshare-cluster
Region: us-east-2
Repository: rideshare-pro
```

The cluster hosts the RideShare microservices together with several platform and data components.

## 2.1 Original Architecture

```text
Users
  |
Route 53
  |
AWS Load Balancer
  |
NGINX Ingress Controller
  |
RideShare Services
  |
  +--------------------+
  |                    |
CloudNativePG      Redis Operator
PostgreSQL         Redis Cluster
inside EKS         inside EKS
```

The original platform successfully established:

- containerised RideShare microservices;
- Kubernetes-based deployment;
- NGINX ingress routing;
- TLS certificate automation;
- secret synchronisation;
- Helm-based application deployment;
- Amazon ECR image distribution;
- PostgreSQL and Redis integration;
- a working production-style application entry point.

It remains an important proof that the application can run successfully on Kubernetes.

---

# 3. Limitations of the Original Platform

The original platform is functional, but it was created before the Platform Governance Framework and does not fully meet the target production standard.

## 3.1 Main Limitations

| Area | Original implementation | Limitation |
|---|---|---|
| Regional resilience | One EKS cluster in `us-east-2` | A regional or cluster failure can make the application unavailable |
| Cluster naming | `lukman-rideshare-cluster` | Uses a personal name and does not follow the approved naming convention |
| PostgreSQL | CloudNativePG inside EKS | Platform team owns database scheduling, storage, backup and recovery complexity |
| Redis | Redis Operator inside EKS | Platform team owns cache clustering, failover and lifecycle operations |
| Infrastructure consistency | Existing resources created before governance | Naming, structure and implementation are not fully standardised |
| Reproducibility | Mixed implementation history | The complete environment cannot yet be rebuilt from one governed platform definition |
| Observability | Partial operational visibility | No single standard for cross-region metrics, logs, dashboards and alerts |
| Disaster recovery | No complete second regional platform | Regional failover is not fully available or regularly validated |
| Operational controls | Limited validation evidence | Compliance, recovery and migration evidence are not yet centrally recorded |

## 3.2 Standards Not Fully Met

The current cluster does not completely satisfy the following target standards:

- regional symmetry;
- governance-compliant resource naming;
- managed-services-first data architecture;
- independently reproducible regional infrastructure;
- standardised observability;
- tested regional disaster recovery;
- documented platform validation gates;
- consistent operational evidence.

The existing implementation is therefore classified as a **legacy but operational platform**, not as a failed platform.

---

# 4. What Is Retained and What Is Replaced

The target architecture builds on proven elements of the original implementation rather than discarding everything.

## 4.1 Retained

| Capability | Decision |
|---|---|
| Amazon EKS | Retained as the Kubernetes platform |
| RideShare microservices | Retained |
| Helm deployment model | Retained and standardised |
| Amazon ECR | Retained |
| NGINX Ingress Controller | Retained |
| cert-manager | Retained |
| External Secrets Operator | Retained |
| AWS Secrets Manager | Retained |
| Route 53 | Retained and expanded for multi-region traffic management |
| IAM Roles for Service Accounts | Retained and applied consistently |
| Application health probes | Retained and standardised |
| Existing application routes and service boundaries | Retained |

## 4.2 Replaced or Modernised

| Current capability | Target capability | Reason |
|---|---|---|
| CloudNativePG | Amazon RDS for PostgreSQL | Reduce database operational ownership and improve managed backup, recovery and Multi-AZ capability |
| Redis Operator | Amazon ElastiCache for Redis | Reduce in-cluster operational complexity and use managed cache availability |
| Personal cluster naming | Governance-compliant naming | Improve predictability, ownership and regional consistency |
| Single-region platform | Two regional platforms | Improve resilience and disaster recovery |
| Partial observability | Standard metrics, logs, dashboards and alerts | Improve operational visibility |
| Manual or historical configuration | Reproducible `eksctl`, Helm and automation | Reduce drift and allow repeatable builds |
| Informal validation | Evidence-driven validation gates | Prove that migration and recovery work |

---

# 5. Repository Relationship

The platform is intentionally separated into two repositories.

## 5.1 `rideshare-pro`

The `rideshare-pro` repository is the existing application repository and the source of the workloads currently deployed to `lukman-rideshare-cluster`.

It contains:

- application source code;
- Dockerfiles;
- application Helm charts;
- application configuration;
- microservice definitions;
- image build workflows;
- business logic.


## 5.2 `rideshare-platform`

The `rideshare-platform` repository defines the governed target platform.

It contains:

- target architecture;
- platform governance;
- cloud conventions;
- `eksctl` cluster definitions;
- regional infrastructure configuration;
- platform Helm releases;
- observability configuration;
- migration documentation;
- validation scripts;
- operational runbooks;
- architecture decision records.

## 5.3 Connection Between the Repositories

```text
                    rideshare-pro
            Application source of truth
                       |
               Build and test images
                       |
                       v
                   Amazon ECR
                       |
        +--------------+--------------+
        |                             |
        v                             v
lukman-rideshare-cluster       rideshare-prod-use1
Legacy us-east-2 platform      New compliant us-east-1 platform
        |                             |
        +--------------+--------------+
                       |
          Same versioned application images
                       |
                       v
              rideshare-platform
        Governs deployment, infrastructure,
        observability, validation and migration
```

During the migration, both clusters will draw application images produced by `rideshare-pro`.

The platform repository determines **where and how** those images are deployed. The application repository determines **what the application contains**.

---

# 6. Evolution Architecture

The target platform will be introduced without immediately removing the existing cluster.

## 6.1 Transitional Coexistence

```text
                                      Users
                                        |
                             rideshare.lukmonadeokun.com
                                        |
                                 Amazon Route 53
                         Latency routing + health checks
                                        |
              +-------------------------+-------------------------+
              |                                                   |
              v                                                   v
  Existing operational platform                      New compliant platform
          us-east-2                                          us-east-1
  lukman-rideshare-cluster                           rideshare-prod-use1
              |                                                   |
  Existing governance deviations                     Governance-compliant build
              |                                                   |
  EKS + NGINX + cert-manager                         EKS + NGINX + cert-manager
  + ESO + RideShare services                         + ESO + observability
              |                                                   |
  CloudNativePG + Redis Operator                     Amazon RDS + ElastiCache
              |                                                   |
              +-------------------------+-------------------------+
                                        |
                          Common images from Amazon ECR
                                        |
                           Migration and validation evidence
```

This transitional state allows the new regional platform to be built, tested and compared against the working original platform.

The existing cluster provides continuity while the new architecture is validated.

## 6.2 Why the Second Region Is Designed Differently

The `us-east-1` platform will be the first implementation built completely from the governance and standards documents.

It will differ from the original platform in the following ways:

| Area | `lukman-rideshare-cluster` | `rideshare-prod-use1` |
|---|---|---|
| Creation model | Historical implementation | Reproducible governed configuration |
| Naming | Legacy name | Standard name |
| Database | CloudNativePG | Amazon RDS for PostgreSQL |
| Cache | Redis Operator | Amazon ElastiCache for Redis |
| Observability | Partial | Standardised metrics, logs, dashboards and alerts |
| Validation | Operational testing | Defined validation gates and recorded evidence |
| DR role | Original production platform | Independently deployable second regional platform |
| Repository ownership | Primarily application-centred | Platform-centred and governance-driven |

The new region is not merely a copy of the old cluster. It is the first implementation of the improved platform model.

---

# 7. Target Production Architecture

The final platform will consist of two equivalent and governance-compliant regional platforms.

| Region | Role | Cluster |
|---|---|---|
| `us-east-1` | Preferred production region | `rideshare-prod-use1` |
| `us-east-2` | Resilient production region | `rideshare-prod-use2` |

```text
                              Users
                                |
                     rideshare.lukmonadeokun.com
                                |
                         Amazon Route 53
                  Latency routing + health checks
                                |
              +-----------------+-----------------+
              |                                   |
        us-east-1                            us-east-2
   rideshare-prod-use1                  rideshare-prod-use2
              |                                   |
       Regional AWS NLB                    Regional AWS NLB
              |                                   |
     NGINX Ingress Controller             NGINX Ingress Controller
              |                                   |
       RideShare services                  RideShare services
              |                                   |
      +-------+--------+                  +--------+-------+
      |                |                  |                |
 Amazon RDS       ElastiCache        Amazon RDS       ElastiCache
 PostgreSQL       for Redis          PostgreSQL       for Redis
```

Both regions will expose the same:

- namespaces;
- platform services;
- application services;
- Helm release structure;
- identity model;
- secret-management model;
- observability controls;
- health checks;
- deployment and validation processes.

---

# 8. Target Naming and Regional Standards

## 8.1 Clusters

```text
rideshare-prod-use1
rideshare-prod-use2
```

## 8.2 VPCs

```text
rideshare-prod-use1-vpc
rideshare-prod-use2-vpc
```

## 8.3 Proposed CIDRs

```text
us-east-1: 10.10.0.0/16
us-east-2: 10.20.0.0/16
```

## 8.4 Managed Data Services

```text
rideshare-prod-use1-postgres
rideshare-prod-use2-postgres

rideshare-prod-use1-redis
rideshare-prod-use2-redis
```

## 8.5 Node Groups

```text
system-ng
application-ng
```

## 8.6 Namespaces

```text
kube-system
ingress-nginx
cert-manager
external-secrets
monitoring
logging
rideshare
```

---

# 9. Managed Data Migration

## 9.1 PostgreSQL Migration

PostgreSQL will move from CloudNativePG inside EKS to Amazon RDS for PostgreSQL.

The migration process will include:

1. provision an encrypted Multi-AZ RDS instance;
2. configure private network access from EKS;
3. create the required databases and users;
4. migrate schema and data from CloudNativePG;
5. validate record counts and critical application queries;
6. update AWS Secrets Manager with the RDS connection details;
7. allow External Secrets Operator to synchronise the new credentials;
8. deploy the application against RDS;
9. complete functional and performance validation;
10. retain the original database until rollback is no longer required.

The exact cross-region PostgreSQL replication and failover design will be recorded in an ADR because it affects consistency, RPO, RTO, cost and operational complexity.

## 9.2 Redis Migration

Redis will move from the Redis Operator inside EKS to Amazon ElastiCache for Redis.

The migration process will include:

1. provision a Multi-AZ ElastiCache replication group;
2. configure encryption and private network access;
3. update the Redis endpoint in AWS Secrets Manager or application configuration;
4. deploy the application against ElastiCache;
5. validate cache operations, event flow and WebSocket-dependent behaviour;
6. monitor latency, errors and connection stability;
7. remove the in-cluster Redis deployment after validation.

Redis is treated as transient state. Durable business data will remain in PostgreSQL.

---

# 10. Reproducibility and Automation

The new regional platform must be reproducible from version-controlled configuration.

The platform will use:

- `eksctl` for EKS cluster and managed node-group configuration;
- Helm for platform and application releases;
- region-specific values files;
- AWS Secrets Manager for secret source data;
- scripted validation for post-deployment checks;
- CI/CD automation for image promotion and deployment.

Target repository structure:

```text
rideshare-platform/
├── apps/
├── helm/
│   ├── platform/
│   └── rideshare/
├── infrastructure/
│   ├── base/
│   ├── us-east-1/
│   └── us-east-2/
├── docs/
│   ├── architecture/
│   ├── governance/
│   ├── adr/
│   ├── migration/
│   └── operations/
├── evidence/
└── scripts/
```

A reviewer should be able to trace each regional resource from architecture to configuration and then to validation evidence.

---

# 11. Migration Evidence

The migration will not be considered complete merely because resources were created.

The repository will retain evidence showing that the target platform works.

## 11.1 Infrastructure Evidence

- successful `eksctl` cluster creation;
- healthy EKS control plane and node groups;
- expected namespaces and platform services;
- RDS and ElastiCache availability;
- Route 53 records and health-check status.

## 11.2 Deployment Evidence

- successful Helm releases;
- immutable ECR image versions;
- healthy Deployments, Pods and Services;
- readiness and liveness probes passing;
- valid ingress and TLS configuration.

## 11.3 Application Evidence

- frontend loads successfully;
- rider and driver workflows succeed;
- trip creation, matching and completion succeed;
- WebSocket connections return `101 Switching Protocols`;
- database records persist correctly;
- Redis-dependent behaviour operates correctly.

## 11.4 Migration Evidence

- PostgreSQL schema and record-count comparison;
- successful application connection to RDS;
- successful application connection to ElastiCache;
- rollback test or rollback plan;
- removal criteria for CloudNativePG and the Redis Operator.

## 11.5 Resilience Evidence

- pod-failure recovery;
- worker-node failure recovery;
- ingress failure detection;
- Route 53 withdrawal of an unhealthy region;
- successful service from the remaining healthy region;
- documented disaster-recovery test results.

Evidence may include command output, screenshots, test reports, logs, dashboards and validation summaries.

---

# 12. Standardising `lukman-rideshare-cluster`

The existing `lukman-rideshare-cluster` will not remain permanently as a special or non-standard platform.

It will evolve through a controlled process.

```text
lukman-rideshare-cluster
Legacy but operational
        |
        v
Document current state and deviations
        |
        v
Build and validate rideshare-prod-use1
        |
        v
Adopt managed RDS and ElastiCache
        |
        v
Apply standard namespaces, IAM, observability and automation
        |
        v
Rebuild or replace the legacy cluster
        |
        v
rideshare-prod-use2
Governance-compliant regional platform
```

The preferred approach is to build `rideshare-prod-use2` from the approved `eksctl` and Helm definitions rather than attempting an in-place cluster rename.

This avoids preserving hidden configuration drift and proves that the platform is reproducible.

The legacy cluster will be decommissioned only after:

- the replacement cluster is healthy;
- application services are validated;
- PostgreSQL and Redis migration are validated;
- Route 53 health checks are operating;
- regional failover is tested;
- rollback requirements are satisfied;
- migration evidence is recorded.

---

# 13. Trade-offs

| Decision | Benefit | Trade-off |
|---|---|---|
| Two regional EKS platforms | Regional resilience | Higher cost and operational footprint |
| Amazon RDS instead of CloudNativePG | Managed backups, Multi-AZ and reduced database operations | Less Kubernetes-native control and continued need for a cross-region data strategy |
| Amazon ElastiCache instead of Redis Operator | Managed cache availability and reduced operational ownership | Additional AWS cost and service dependency |
| Latency-based Route 53 routing | Directs users to a low-latency healthy region | DNS failover is not instantaneous |
| Separate `rideshare-pro` and `rideshare-platform` repositories | Clear application/platform ownership | Requires version coordination between repositories |
| Rebuild `us-east-2` rather than rename in place | Removes drift and proves reproducibility | Requires a controlled migration and temporary duplicate capacity |
| Standardised platform services | Consistency and easier support | Reduces freedom for region-specific customisation |
| Managed-services-first approach | Lower infrastructure management burden | Increased AWS coupling |

These trade-offs are accepted because the project prioritises resilience, reproducibility, operational clarity and managed-service adoption.

---

# 14. Target-State Summary

The completed evolution will result in:

- two governance-compliant production AWS Regions;
- one standard EKS cluster per region;
- a documented transition from `lukman-rideshare-cluster` to `rideshare-prod-use2`;
- repeatable cluster creation using `eksctl`;
- standard application and platform deployment using Helm;
- managed PostgreSQL using Amazon RDS;
- managed Redis using Amazon ElastiCache;
- standard naming, tagging, namespaces and workload identity;
- centralised metrics, logs, dashboards and alerts;
- Route 53 latency routing with regional health checks;
- tested regional failure and recovery procedures;
- evidence proving infrastructure, application, data and resilience validation;
- clear separation between `rideshare-pro` and `rideshare-platform`.

The original platform proves the application works on Kubernetes.

The new platform demonstrates how that implementation is deliberately evolved into a reproducible, governed, observable and resilient multi-region production platform.