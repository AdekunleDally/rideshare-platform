# Engineering Journey

## The Story This Repository Tells

RideShare began as a working cloud-native application in one Amazon EKS
cluster, `lukman-rideshare-cluster`, in `us-east-2`. The application consisted
of independently deployed microservices behind NGINX Ingress. PostgreSQL ran
inside Kubernetes through CloudNativePG and Redis ran through the Opstree Redis
Operator.

That implementation proved the application and Kubernetes deployment model,
but it also exposed the boundaries of a single-region, operator-managed data
platform.
- A cluster or regional failure could remove the whole service
- Stateful systems shared the lifecycle and operational burden of Kubernetes
- Naming and configuration preceded the governance model
- Reproducibility,observability and recovery evidence were incomplete.

The project therefore evolves the existing platform rather than replacing the
application.

## Evolution in One View

```text
rideshare-pro
Original application and Kubernetes baseline
        |
        v
lukman-rideshare-cluster, us-east-2
EKS + CloudNativePG + Redis Operator
        |
        | assess and document
        v
Current Architecture + Cluster Assessment
        |
        | retain proven components
        | replace operationally heavy components
        v
Platform Governance + ADRs + Target Architecture
        |
        v
rideshare-prod-use1, us-east-1
First governance-compliant regional implementation
EKS + RDS + ElastiCache + automation + observability
        |
        | coexist, compare, migrate and validate
        v
Route 53 multi-region transition
Legacy us-east-2 + compliant us-east-1
        |
        v
rideshare-prod-use2, us-east-2
Legacy cluster rebuilt from governed definitions
        |
        v
Two reproducible, compliant regional platforms
with recorded operational and migration evidence
```

## What the Baseline Proved

The original implementation established reusable engineering capabilities:

- the RideShare microservice boundaries
- container images distributed through Amazon ECR
- Helm-based Kubernetes deployment
- NGINX path and WebSocket routing
- automated TLS through cert-manager
- secret delivery through AWS Secrets Manager and External Secrets Operator
- workload identity through IRSA
- application health checks and internal Kubernetes service discovery.

These capabilities are retained and standardised.

## Why the Platform Evolves

The assessment identified four major improvement areas:

1. **Failure isolation:** one cluster and one region represented the entire
   application execution environment.
2. **Stateful operational ownership:** PostgreSQL and Redis required Kubernetes
   scheduling, storage, backup, upgrade and recovery management.
3. **Consistency and reproducibility:** the environment was created before the
   current naming, repository and platform standards.
4. **Operational proof:** monitoring, recovery testing and migration evidence
   needed a standard home and completion criteria.

## How the Second Region Is Different

`rideshare-prod-use1` in `us-east-1` is not intended to be an uncritical copy of
the original cluster. It is the reference implementation of the new platform
model:

- standard regional naming
- version-controlled `eksctl` cluster definitions
- standard platform Helm releases
- Amazon RDS for PostgreSQL
- Amazon ElastiCache for Redis
- consistent identity, secrets and namespace conventions
- metrics, logs, alerts and dashboards designed with the platform
- validation gates and retained evidence.

The existing `lukman-rideshare-cluster` continues serving as a rollback and
comparison point while the new region is validated.

## How the Legacy Cluster Becomes Compliant

The cluster cannot be renamed in place. The intended end state is achieved by
building `rideshare-prod-use2` from the same governed definitions used for
`rideshare-prod-use1`, migrating the application and data dependencies, testing
traffic withdrawal and recovery, and then decommissioning the old cluster.

This approach removes hidden drift and proves reproducibility instead of merely
changing a label.

## Application and Platform Repository Contract

`rideshare-pro` remains the application source of truth. It builds and publishes
versioned images to Amazon ECR.

`rideshare-platform` is the platform source of truth. It selects approved image
versions and defines the AWS infrastructure, EKS clusters, shared platform
services, regional values, operational controls and evidence required to run
those images.

The repositories therefore evolve independently but integrate through explicit
contracts: image versions, Helm values, health endpoints, service ports,
secrets and application routes.

## Evidence, Not Claims

The project is complete only when evidence demonstrates:

- repeatable cluster and platform creation;
- healthy application deployment;
- successful PostgreSQL migration to RDS;
- successful Redis migration to ElastiCache;
- valid TLS, DNS and ingress behaviour;
- failure recovery at pod, node, ingress and regional levels; and
- the ability to rebuild the replacement `us-east-2` platform from source.

The [Evidence Index](../evidence/README.md) records current assessment output
and defines the evidence required for each future migration stage.

## Architectural Trade-offs

- The chosen direction accepts additional regional cost and AWS service coupling
in return for reduced stateful operational ownership, clearer failure domains,
repeatability and stronger recovery capability.
- Route 53 provides a simple managed traffic layer, but DNS failover is not instantaneous.
- Separate application and platform repositories improve ownership, but require disciplined
version coordination.

The detailed reasoning is retained in the
[Architecture Decision Records](./architecture/decisions/README.md).
