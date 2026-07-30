# Contributing

Thank you for your interest in contributing to the RideShare Platform.

This repository documents and implements the engineering evolution of a
cloud-native RideShare platform from a single-region Amazon EKS deployment with
Kubernetes operators to a production-oriented, multi-region AWS platform using
managed services and Platform Engineering principles.

Every contribution should support this vision while maintaining the quality,
consistency and maintainability of the repository.

---

## Before You Contribute

Before making significant changes, please review the following documentation:

- Architecture documentation
- Governance documentation
- Architecture Decision Records (ADRs)

Understanding the platform's architecture and engineering standards helps
ensure new contributions remain consistent with the project's direction.

---

## Repository Organization

The repository is organized into dedicated engineering layers:

- **Architecture** – Architectural direction and platform evolution
- **Governance** – Engineering standards and conventions
- **Infrastructure** – Cloud infrastructure resources
- **Platform** – Shared Kubernetes platform capabilities
- **Applications** – RideShare application services
- **Operations** – Operational procedures and validation

New content should be added to the directory that best matches its
responsibility.

---

## Documentation

Documentation is treated as an essential part of the platform.

When making changes:

- update relevant documentation alongside implementation;
- avoid duplicate or conflicting documentation;
- include a README for new major directories where appropriate; and
- record significant architectural decisions using an ADR.

---

## Engineering Expectations

Contributions should:

- follow the Platform Standards and Cloud Conventions;
- maintain consistency across supported AWS Regions;
- prefer reusable and maintainable solutions;
- avoid introducing unnecessary complexity; and
- align with the Platform Evolution Roadmap.

---

## Submitting Changes

Before submitting a change:

- ensure the implementation is complete and well documented;
- review affected documentation for accuracy;
- keep changes focused on a single objective where practical; and
- provide a clear and descriptive commit message.

---

## Questions and Suggestions

If you are unsure about a proposed change, start a discussion before making
significant architectural or platform modifications.

Collaboration and constructive feedback are encouraged to ensure the platform
continues to evolve in a consistent and maintainable manner.