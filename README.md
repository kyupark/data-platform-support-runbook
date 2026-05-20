# Data Platform Support Runbook

A compact case study showing how I approach L1/L2 support for a data-platform application: incident triage, SQL investigation, Grafana-style monitoring, data integrity checks, escalation criteria, and runbook documentation.

This is a portfolio-safe synthetic project. The data, queries, incidents, and dashboards are fictional, but the workflow reflects real support operations patterns I used in regulated SaaS environments.

## Scenario

A trading or operations team relies on a data platform that ingests events, transforms them into curated tables, and serves downstream dashboards. Support must detect broken data flows quickly, separate user/request issues from platform incidents, and escalate clean evidence to Engineering when needed.

## What this demonstrates

- L1/L2 incident triage for data-platform applications
- SQL checks for freshness, duplicates, nulls, and reconciliation
- Grafana-style dashboard design for application health and data-flow monitoring
- Runbook-first support: clear decision paths, severity rules, escalation packets
- Jira-style ticket fields and handoff notes for distributed teams
- Root-cause analysis and problem-management follow-up

## Repository map

```text
docs/
  runbook.md                 # L1/L2 support workflow and escalation rules
  support-model.md           # How L1/L2, L3, Engineering, and business users interact
  jira-ticket-template.md    # Ticket structure for clean triage and escalation
sql/
  data_quality_checks.sql    # Freshness, volume, duplicate, null, and reconciliation checks
  incident_queries.sql       # Queries used during active incident investigation
dashboards/
  grafana-dashboard.json     # Example Grafana dashboard JSON skeleton
  dashboard-notes.md         # Panel rationale and alert thresholds
incidents/
  sample-incident.md         # Example incident timeline and escalation packet
scripts/
  generate_sample_data.py    # Small synthetic dataset generator
```

## Quick workflow

1. Confirm whether the issue is user-specific, data-specific, or platform-wide.
2. Check dashboard signals: ingestion lag, failed jobs, error rate, row volume, and downstream freshness.
3. Run SQL checks against the affected dataset.
4. Compare current results with baseline volume and freshness expectations.
5. If impact is confirmed, open or update an incident ticket with evidence.
6. Escalate to L3/Engineering only with reproducible queries, timestamps, affected users, and business impact.
7. After recovery, document the root cause, prevention action, and monitoring/runbook update.

## Example support outcome

A downstream dashboard shows stale values. The support workflow identifies that ingestion is healthy, but a transformation job produced zero rows for one business date. SQL checks confirm the gap, Grafana panels show the job failure window, and the escalation packet gives Engineering enough evidence to fix without a long back-and-forth.

## Why this matters

Data-platform support is not just ticket handling. Good support reduces time-to-diagnosis by combining operational context, SQL investigation, monitoring signals, and clear escalation hygiene.
