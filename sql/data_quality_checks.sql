-- Data quality checks for L1/L2 data-platform support.
-- SQL dialect: broadly PostgreSQL-like. Adapt table and date functions to local platform.

-- 1. Freshness check: latest record per source feed
SELECT
    source_system,
    MAX(event_timestamp) AS latest_event_ts,
    EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - MAX(event_timestamp))) / 60 AS lag_minutes
FROM raw_events
GROUP BY source_system
ORDER BY lag_minutes DESC;

-- 2. Row-count baseline by business date
SELECT
    business_date,
    COUNT(*) AS row_count
FROM curated_positions
WHERE business_date >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY business_date
ORDER BY business_date DESC;

-- 3. Duplicate business keys
SELECT
    business_date,
    position_id,
    source_system,
    COUNT(*) AS duplicate_count
FROM curated_positions
WHERE business_date = CURRENT_DATE
GROUP BY business_date, position_id, source_system
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 4. Required-field null check
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN position_id IS NULL THEN 1 ELSE 0 END) AS missing_position_id,
    SUM(CASE WHEN instrument_id IS NULL THEN 1 ELSE 0 END) AS missing_instrument_id,
    SUM(CASE WHEN valuation_amount IS NULL THEN 1 ELSE 0 END) AS missing_valuation_amount,
    SUM(CASE WHEN updated_at IS NULL THEN 1 ELSE 0 END) AS missing_updated_at
FROM curated_positions
WHERE business_date = CURRENT_DATE;

-- 5. Source-to-curated reconciliation
SELECT
    r.business_date,
    r.raw_count,
    c.curated_count,
    r.raw_count - c.curated_count AS delta
FROM (
    SELECT business_date, COUNT(*) AS raw_count
    FROM raw_events
    WHERE business_date >= CURRENT_DATE - INTERVAL '7 days'
    GROUP BY business_date
) r
LEFT JOIN (
    SELECT business_date, COUNT(*) AS curated_count
    FROM curated_positions
    WHERE business_date >= CURRENT_DATE - INTERVAL '7 days'
    GROUP BY business_date
) c USING (business_date)
ORDER BY r.business_date DESC;

-- 6. Failed or delayed jobs
SELECT
    job_name,
    run_id,
    status,
    started_at,
    finished_at,
    error_message
FROM job_runs
WHERE started_at >= CURRENT_TIMESTAMP - INTERVAL '24 hours'
  AND (status <> 'SUCCESS' OR finished_at IS NULL)
ORDER BY started_at DESC;
