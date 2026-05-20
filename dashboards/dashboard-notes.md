# Dashboard Notes

## Panel: Ingestion Lag by Source

Purpose: quickly detect whether missing downstream data is caused by upstream ingestion delay.

Suggested thresholds:

- green: under 30 minutes
- orange: 30-60 minutes
- red: over 60 minutes

Support action:

- If lag is isolated to one source, check source-specific job runs and recent errors.
- If lag affects all sources, suspect scheduler, platform, network, or shared infrastructure.

## Panel: Transformation Job Status

Purpose: distinguish ingestion health from transformation failures.

Support action:

- If ingestion is current but transformed tables are stale, inspect the transformation run.
- Capture run ID, error message, input/output record counts, and timing before escalation.

## Panel: Curated Row Count vs Baseline

Purpose: detect abnormal output volume, including zero-row outputs that may not trigger hard job failure.

Support action:

- Compare current business date to rolling baseline.
- Validate whether lower volume is expected due to calendar/market/business context.

## Panel: Data Quality Failures

Purpose: summarize nulls, duplicates, reconciliation deltas, and validation rules.

Support action:

- Run SQL detail query for failing check.
- Attach affected keys and sample rows to the incident ticket.

## Panel: Open Incidents by Severity

Purpose: help support staff avoid duplicate incidents and understand ongoing impact.

Support action:

- Link user reports to existing incident when appropriate.
- Keep status updates consistent across regions.
