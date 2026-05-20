# Support Model

## Roles

## L1 support

- receive user report
- verify known issues and documented workarounds
- collect basic impact and reproduction details
- handle access/request/documentation issues
- route tickets to L2 when technical investigation is required

## L2 support

- investigate data and application behavior
- run SQL checks and compare expected vs actual values
- inspect monitoring dashboards and job health
- identify whether the issue is user, data, application, or infrastructure related
- coordinate escalation to L3/Engineering with evidence
- communicate status to business users
- update runbooks and knowledge base articles

## L3 / Engineering

- investigate defects requiring code, configuration, infrastructure, or deployment changes
- own remediation for confirmed platform defects
- provide prevention actions and technical root cause

## Business users

- provide expected outcome, business impact, and timing constraints
- validate recovery from the user perspective

## Handoff principles

A good escalation should let Engineering start with evidence, not discovery.

Bad handoff:

> Dashboard broken. Please check.

Good handoff:

> Positions dashboard is stale for business date 2026-05-20. Three users in Geneva report same result. Ingestion table has current records, but curated table row count is zero for run_id 8421. Grafana shows transform job failure at 07:12 UTC. SQL checks attached. No user-specific permission issue found.
