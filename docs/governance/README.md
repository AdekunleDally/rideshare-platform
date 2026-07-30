# Governance

## Overview

This directory contains the governance documents that guide the engineering
evolution of the RideShare Platform.

Governance establishes the standards, conventions and engineering practices
that promote consistency, maintainability and repeatability as the platform
evolves from a single-region Amazon EKS deployment to a production-oriented,
multi-region AWS platform.

These documents define *how* the platform should be engineered rather than
*how* individual technologies are implemented.

---

## Governance Areas

The governance layer currently consists of:

| Document | Purpose |
|----------|---------|
| Platform Standards | Defines the engineering standards that apply across the platform. |
| Cloud Conventions | Defines how AWS resources are organised and managed. |
| Repository Standards | Defines the organisation and maintenance of the repository. |
| Platform Inventory | Records the components that make up the platform. |
| Documentation Standards | Defines how engineering knowledge is documented. |

Additional governance documents may be introduced as the platform evolves.

---

## Role in the Platform Evolution

Governance bridges the gap between architecture and implementation.

It establishes the standards that guide the evolution of the platform before
new infrastructure, platform services and operational capabilities are
introduced during later phases of the Platform Evolution Roadmap.

---

## Guiding Principles

The governance layer promotes:

- consistency across environments;
- reusable engineering practices;
- maintainable platform design;
- clear engineering documentation;
- controlled architectural evolution.

---

## Relationship to Other Documentation

The governance documents should be read alongside:

- the **Current-State Architecture**;
- the **Target-State Architecture**;
- the **Platform Evolution Roadmap**; and
- the **Architecture Decision Records (ADRs)**.

Together they define both the architectural direction and the engineering
standards that guide the platform's evolution.