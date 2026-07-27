# Infrastructure

## Overview

This directory contains the infrastructure required to provision and support the
RideShare Platform.

Infrastructure represents the cloud resources on which the platform operates.
These resources exist independently of the applications deployed onto them.

The objective of this layer is to provide secure, scalable and repeatable
infrastructure that supports the platform across multiple AWS regions.

---

# Responsibilities

The infrastructure layer is responsible for provisioning and managing:

- AWS networking
- Amazon EKS clusters
- Amazon RDS
- Amazon ElastiCache
- Amazon ECR
- IAM roles and policies
- DNS infrastructure
- Load balancers
- Security groups
- Supporting AWS services

Infrastructure should be reproducible and environment-independent wherever
practical.

---

# Principles

Infrastructure should be:

- declarative;
- repeatable;
- version controlled;
- environment aware;
- secure by default;
- independent of application deployments.

Application code should never provision infrastructure directly.

---

# Directory Structure


```text
infrastructure/

├── global/
|── regions
|    ├── us-east-1/
|    ├── us-east-2/
```

The exact structure may evolve as the platform grows.

---

# Relationship to Other Layers

The infrastructure layer provides the foundation on which the platform layer
operates.

It does not deploy application workloads.

Application deployment is handled by the Platform and Applications layers.

---

# Out of Scope

The infrastructure layer does not contain:

- application source code;
- Kubernetes manifests for business services;
- operational procedures;
- application configuration.