# Platform

## Overview

This directory contains the shared Kubernetes platform components deployed
across the RideShare Platform.

The Platform layer provides the capabilities that enable applications to run
consistently across multiple Amazon EKS clusters while remaining independent of
the underlying cloud infrastructure.

---

## Role in the Platform Evolution

As the platform evolves toward a production-oriented multi-region architecture,
this layer standardises the Kubernetes capabilities shared by both clusters.

It enables consistent deployment, security, networking, scaling and platform
operations across regional environments.

---

## Responsibilities

The Platform layer manages shared Kubernetes capabilities such as:

- NGINX Ingress Controller
- cert-manager
- External Secrets Operator
- Metrics Server
- Cluster Autoscaler
- Monitoring components
- Platform security policies
- Shared networking configuration

---

## Principles

Platform components should be:

- reusable
- standardised
- cluster independent
- declaratively managed
- consistently deployed across regions.

Business functionality belongs in the Applications layer.

---

## Directory Structure

```text
platform/

├── ingress/
├── cert-manager/
├── external-secrets/
├── monitoring/
├── autoscaling/
└── policies/
```

The structure may expand as additional platform capabilities are introduced.

---

## Relationship to Other Layers

The Platform layer consumes cloud resources provided by the Infrastructure
layer and provides shared services used by the Applications layer.

It does not contain business application code.

---

## Out of Scope

The Platform layer does not contain:

- business services;
- infrastructure provisioning;
- operational runbooks; or
- architecture documentation.