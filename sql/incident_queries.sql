-- Queries for active incident investigation.

-- Incident context variables to replace:
-- :business_date, :source_system, :dashboard_name, :run_id

-- A. Confirm affected business date and source
SELECT
    business_date,
    source_system,
    COUNT(*) AS raw_rows,
    MIN(event_timestamp) AS first_event_ts,
    MAX(event_timestamp) AS last_event_ts
FROM raw_events
WHERE business_date = :business_date
GROUP BY business_date, source_system
ORDER BY source_system;

-- B. Check curated layer for the same date
SELECT
    business_date,
    COUNT(*) AS curated_rows,
    MIN(updated_at) AS first_update_ts,
    MAX(updated_at) AS last_update_ts
FROM curated_positions
WHERE business_date = :business_date
GROUP BY business_date;

-- C. Inspect the latest transformation run
SELECT
    run_id,
    job_name,
    status,
    started_at,
    finished_at,
    records_in,
    records_out,
    error_message
FROM job_runs
WHERE job_name LIKE '%positions%'
ORDER BY started_at DESC
LIMIT 10;

-- D. Find outlier volume changes
WITH daily_counts AS (
    SELECT business_date, COUNT(*) AS row_count
    FROM curated_positions
    WHERE business_date >= :business_date - INTERVAL '14 days'
    GROUP BY business_date
)
SELECT
    business_date,
    row_count,
    AVG(row_count) OVER (ORDER BY business_date ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING) AS prior_7_day_avg,
    row_count - AVG(row_count) OVER (ORDER BY business_date ROWS BETWEEN 7 PRECEDING AND 1 PRECEDING) AS delta_vs_baseline
FROM daily_counts
ORDER BY business_date DESC;

-- E. Sample affected rows for validation
SELECT *
FROM curated_positions
WHERE business_date = :business_date
ORDER BY updated_at DESC
LIMIT 50;
