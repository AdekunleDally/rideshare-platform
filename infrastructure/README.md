# Infrastructure

## Overview

This directory contains the cloud infrastructure that supports the engineering
evolution of the RideShare Platform.

It defines the AWS resources required to evolve the platform from its
current single-region Kubernetes deployment to a production-oriented,
multi-region platform built on managed AWS services.

Infrastructure provides the foundation on which the Platform and Applications
layers operate.

---

## Role in the Platform Evolution

The Infrastructure layer establishes the cloud foundation for each stage of the
platform evolution.

It provisions the AWS resources that enable the transition from
CloudNativePG and the Redis Operator to Amazon RDS and Amazon ElastiCache,
while supporting standardized multi-region deployments.

---

## Responsibilities

The Infrastructure layer provisions and manages resources such as:

- AWS networking
- Amazon EKS clusters
- Amazon RDS
- Amazon ElastiCache
- Amazon ECR
- IAM roles and policies
- Route 53
- Load balancers
- Security groups
- Supporting AWS services

Infrastructure should remain reproducible, secure and environment aware.

---

## Principles

Infrastructure should be:

- declarative;
- version controlled;
- repeatable;
- secure by default;
- independent of application deployments.

Applications should consume infrastructure rather than provision it.

---

## Directory Structure

```text
infrastructure/

├── global/
└── regions/
    ├── us-east-1/
    └── us-east-2/
```

The structure may evolve as additional environments or regions are introduced.

---

## Relationship to Other Layers

The Infrastructure layer provides the cloud resources consumed by the
Platform layer.

It does not deploy Kubernetes platform services or application workloads.

---

## Out of Scope

The Infrastructure layer does not contain:

- application source code;
- Kubernetes application manifests;
- operational procedures; or
- architecture documentation.