# Platform Standards

## Overview

This document defines the engineering standards that govern the evolution of
the RideShare Platform.

These standards establish a consistent approach to designing, deploying and
operating the platform as it evolves from a single-region Amazon EKS
deployment to a production-oriented, multi-region AWS platform.

The standards apply across the Infrastructure, Platform, Applications and
Operations layers.

---

## Objectives

The Platform Standards are intended to:

- Promote consistency across the platform
- Support maintainable platform evolution
- Reduce operational complexity
- Encourage automation and repeatability
- Establish shared engineering practices.

---

# Engineering Principles

The RideShare Platform follows these principles:

- Infrastructure should be declaratively managed.
- Platform capabilities should be standardised across regions.
- Applications should remain portable and loosely coupled.
- Managed services should be preferred where they reduce operational complexity.
- Automation should replace manual processes wherever practical.
- Documentation should evolve alongside the platform.
- Significant architectural decisions should be recorded using ADRs.

---

## Infrastructure

Infrastructure should be:

- version controlled
- reproducible
- environment aware
- secure by default
- independent of application workloads.

---

## Platform

Platform capabilities should be:

- standardised across supported regions;
- reusable across applications;
- independently maintainable; and
- consistently deployed.

---

## Applications

Applications should:

- remain independently deployable;
- externalise configuration;
- avoid infrastructure-specific logic; and
- support resilient, cloud-native deployments.

---

## Operations

Operational practices should:

- be documented;
- be repeatable;
- include validation procedures;
- support recovery and troubleshooting; and
- evolve with the platform.

---

## Cross-Cutting Standards

Across all platform layers:

- configuration should be version controlled
- secrets should never be stored in source control
- changes should preserve consistency across supported regions
- documentation should remain aligned with the deployed platform
- engineering practices should favour repeatability, automation and continuous improvement.

---

## Relationship to Other Governance Documents

This document defines the engineering standards that guide the platform.

Supporting governance documents apply these standards within specific areas:

- **Cloud Conventions** defines AWS-specific conventions.
- **Repository Standards** defines repository organization.
- **Platform Inventory** records platform components.
- **Documentation Standards** defines engineering documentation practices.