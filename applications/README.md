# Applications

## Overview

This directory contains the RideShare application workloads that deliver the
platform's business capabilities.

Applications remain independent of the underlying infrastructure and platform
implementation, allowing the same workloads to be deployed consistently across
multiple Kubernetes clusters.

---

## Role in the Platform Evolution

As the platform evolves from a single-region deployment to a multi-region
architecture, this layer focuses on delivering consistent, portable and
independently deployable application services.

The evolution of the platform should require minimal changes to application
logic.

---

## Responsibilities

This layer contains application services such as:

- frontend
- rider-service
- driver-service
- trip-service
- matching-service
- email-service

It also contains application deployment configuration and service-specific
documentation where appropriate.

---

## Principles

Applications should remain:

- stateless wherever practical;
- independently deployable;
- loosely coupled;
- externally configurable;
- infrastructure agnostic.

Infrastructure and platform concerns should remain outside application code.

---

## Directory Structure

```text
applications/

├── frontend/
├── rider-service/
├── driver-service/
├── trip-service/
├── matching-service/
└── email-service/
```

Each application is expected to contain its own deployment artifacts and
service documentation where appropriate.

---

## Relationship to Other Layers

Applications consume capabilities provided by the Infrastructure and Platform
layers, while operational procedures are documented within the Operations
layer.

Applications should not provision infrastructure or manage shared platform
services.

---

## Out of Scope

The Applications layer does not contain:

- infrastructure provisioning;
- shared Kubernetes platform services;
- operational runbooks; or
- architecture documentation.