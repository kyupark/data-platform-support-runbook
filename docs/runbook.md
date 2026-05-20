# L1/L2 Data Platform Support Runbook

## Purpose

Provide a repeatable first-response workflow for data-platform incidents, service requests, and business-user issues.

## Scope

This runbook covers:

- delayed or missing data
- dashboard freshness issues
- failed or delayed batch jobs
- duplicate records
- unexpected nulls or invalid values
- access/request triage
- escalation from L1/L2 to L3 or Engineering

It does not cover production code changes or infrastructure remediation. Those belong to L3/Engineering after evidence-based escalation.

## First response checklist

1. Capture the user report
   - user/team
   - affected dashboard/table/feed
   - expected result
   - actual result
   - first noticed time
   - business impact

2. Classify the issue
   - user-specific access or permission issue
   - single dashboard/report issue
   - single dataset/table issue
   - upstream ingestion issue
   - transformation/batch job issue
   - platform-wide availability/performance issue

3. Check monitoring
   - ingestion lag
   - transformation failures
   - scheduler status
   - error rate
   - row volume anomaly
   - dashboard freshness
   - API response latency, if applicable

4. Run SQL checks
   - freshness by table/date
   - row count against baseline
   - duplicate key checks
   - null checks on required columns
   - reconciliation between source and curated layers

5. Decide action path
   - resolve at L1/L2 if it is access, documentation, known data delay, or user guidance
   - escalate if there is confirmed data loss, job failure, platform instability, or code/config defect

## Severity guide

### SEV1

Use when the issue blocks critical business workflows for multiple teams or causes materially incorrect decision data.

Examples:
- core platform unavailable
- key data feed missing for current business day
- dashboards showing incorrect values used for time-sensitive decisions

### SEV2

Use when impact is significant but contained.

Examples:
- one dataset stale or partially missing
- one regional team blocked
- repeated transformation failure with known workaround

### SEV3

Use for limited impact or non-urgent defects.

Examples:
- single-user access issue
- minor dashboard inconsistency
- documentation gap

## Escalation packet

Before escalating, include:

- incident summary in one paragraph
- affected users/teams
- affected table/dashboard/feed
- severity and business impact
- timeline with timestamps and timezone
- SQL queries executed and results
- Grafana/dashboard screenshots or panel links
- recent job/run IDs if available
- whether workaround exists
- requested next action from L3/Engineering

## Resolution notes

After resolution, update:

- root cause
- recovery action
- user communication
- monitoring gap, if any
- runbook improvement
- problem ticket if recurrence risk exists
