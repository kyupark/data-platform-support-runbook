# Sample Incident: Curated Positions Dashboard Stale

## Summary

The positions dashboard showed stale values for Geneva business users. L1/L2 support confirmed the issue was not user-specific, verified ingestion freshness, identified a failed transformation job, and escalated to Engineering with SQL evidence and Grafana panel references.

## Timeline

| Time | Event |
| --- | --- |
| 08:15 CET | User reports dashboard values have not updated for current business date. |
| 08:20 CET | Support confirms issue affects multiple users. |
| 08:27 CET | Grafana ingestion lag panel shows source events are current. |
| 08:35 CET | SQL check shows raw table has current records but curated table has zero rows. |
| 08:42 CET | Transformation job status panel shows failed job run. |
| 08:50 CET | Ticket escalated to Engineering with run ID, SQL output, and impact summary. |
| 09:35 CET | Engineering reruns transformation after fixing config issue. |
| 09:50 CET | Support validates dashboard freshness and confirms recovery with users. |

## Impact

- Affected users: Geneva operations users
- Affected component: curated positions dashboard
- Severity: SEV2
- Business impact: users could not rely on current-day dashboard values until recovery

## Evidence collected

- Raw ingestion current for business date
- Curated table row count was zero for same business date
- Transformation job failed at 07:12 UTC
- No user-specific access issue found
- Workaround: use previous exported report until recovery

## Escalation note

```text
Positions dashboard stale for business date 2026-05-20.
Multiple Geneva users affected. Raw ingestion is current, but curated_positions has zero rows.
Grafana shows positions_transform job failed at 07:12 UTC, run_id 8421.
SQL checks attached: raw row count 184,233; curated row count 0.
Please investigate transformation failure and advise ETA.
```

## Resolution

Engineering corrected a job configuration issue and reran the transformation. Support validated row counts, dashboard freshness, and user-facing recovery.

## Follow-up

- Add alert for zero-row curated output when raw input is non-zero.
- Add runbook step for raw-vs-curated reconciliation.
- Add dashboard panel showing records_in vs records_out per transformation run.
