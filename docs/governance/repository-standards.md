# Repository Standards

## Overview

This document defines the standards used to organize and maintain the
RideShare Platform repository.

A consistent repository structure improves discoverability, reduces duplication
and supports the engineering evolution of the platform from a single-region
Amazon EKS deployment to a production-oriented, multi-region AWS platform.

---

## Objectives

The Repository Standards are intended to:

- maintain a clear and consistent repository structure;
- separate architecture, implementation and operations;
- support maintainable platform growth;
- reduce duplication of engineering assets; and
- improve collaboration across the platform.

---

# Repository Organization

The repository is organized into layers that separate engineering concerns.

| Layer | Purpose |
|--------|---------|
| Architecture | Defines the platform's architectural direction and evolution. |
| Governance | Defines the engineering standards and conventions that guide the platform. |
| Infrastructure | Contains the cloud infrastructure that supports the platform. |
| Platform | Contains shared Kubernetes platform capabilities. |
| Applications | Contains the RideShare business services and deployment artifacts. |
| Operations | Contains operational procedures, validation and runbooks. |

Each layer should contain only the assets required to fulfil its
responsibility.

---

# Repository Principles

The repository should:

- maintain a clear separation of responsibilities;
- avoid duplicated content;
- organize related assets together;
- use descriptive directory and file names; and
- evolve alongside the platform architecture.

---

# Documentation Expectations

Engineering documentation should:

- include a README for major directories;
- remain aligned with the current platform;
- reference related documents where appropriate; and
- be updated when significant architectural or engineering changes occur.

Major architectural decisions should be recorded using Architecture Decision
Records (ADRs).

---

# Configuration Management

Configuration should be organized to promote consistency and reuse.

Environment-specific configuration should remain separate from shared
configuration, while sensitive information should never be committed to source
control.

---

# Relationship to Other Governance Documents

This document defines how the RideShare Platform repository is organized.

Related governance documents define:

- **Platform Standards** — engineering standards for the platform.
- **Cloud Conventions** — conventions for AWS resources.
- **Documentation Standards** — standards for engineering documentation.
- **Platform Inventory** — the platform components managed within the repository.