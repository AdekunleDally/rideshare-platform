# Applications

## Overview

This directory contains the RideShare application workloads deployed onto the
platform.

Applications implement business functionality while relying on the platform and
infrastructure layers for networking, security, storage and runtime services.

The purpose of this layer is to package and deploy application components
without embedding infrastructure concerns into the application itself.

---

# Responsibilities

This layer contains the workloads that deliver business capabilities, including
services such as:

- frontend
- rider-service
- driver-service
- trip-service
- matching-service
- email-service

Application deployment configuration also resides within this layer.

---

# Principles

Applications should remain:

- stateless wherever practical;
- independently deployable;
- loosely coupled;
- externally configurable;
- infrastructure agnostic.

Infrastructure concerns should remain outside application code.

---

# Relationship to Other Layers

Applications depend on:

- Infrastructure for cloud resources.
- Platform services for Kubernetes capabilities.
- Operations for deployment and support procedures.

Applications should not provision infrastructure or manage platform services.

---

# Directory Structure

Example:

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
service-specific documentation where appropriate.

---

# Out of Scope

The applications layer does not contain:

- infrastructure provisioning;
- platform-wide operational procedures;
- Architecture Decision Records;
- AWS networking configuration;
- shared platform services.