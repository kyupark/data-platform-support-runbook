#!/usr/bin/env python3
"""Generate tiny synthetic CSVs for the support runbook examples."""
from __future__ import annotations

import csv
import random
from datetime import date, datetime, timedelta, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "sample-data"
OUT.mkdir(exist_ok=True)

random.seed(7)
base = date.today()
sources = ["positions_api", "risk_feed", "reference_data"]

with (OUT / "raw_events.csv").open("w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["business_date", "source_system", "event_timestamp", "event_id", "payload_status"])
    writer.writeheader()
    for day_offset in range(7, -1, -1):
        business_date = base - timedelta(days=day_offset)
        for source in sources:
            rows = random.randint(80, 140)
            if day_offset == 0 and source == "positions_api":
                rows = 120
            for i in range(rows):
                ts = datetime.combine(business_date, datetime.min.time(), tzinfo=timezone.utc) + timedelta(hours=7, minutes=i % 60)
                writer.writerow({
                    "business_date": business_date.isoformat(),
                    "source_system": source,
                    "event_timestamp": ts.isoformat(),
                    "event_id": f"{source}-{business_date}-{i}",
                    "payload_status": "ok",
                })

with (OUT / "job_runs.csv").open("w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=["run_id", "job_name", "status", "started_at", "finished_at", "records_in", "records_out", "error_message"])
    writer.writeheader()
    for i, day_offset in enumerate(range(7, -1, -1), start=8400):
        business_date = base - timedelta(days=day_offset)
        status = "FAILED" if day_offset == 0 else "SUCCESS"
        records_in = random.randint(100000, 180000)
        records_out = 0 if status == "FAILED" else records_in - random.randint(0, 100)
        start = datetime.combine(business_date, datetime.min.time(), tzinfo=timezone.utc) + timedelta(hours=7, minutes=12)
        finish = "" if status == "FAILED" else (start + timedelta(minutes=18)).isoformat()
        writer.writerow({
            "run_id": i,
            "job_name": "positions_transform",
            "status": status,
            "started_at": start.isoformat(),
            "finished_at": finish,
            "records_in": records_in,
            "records_out": records_out,
            "error_message": "missing config mapping" if status == "FAILED" else "",
        })

print(f"Wrote {OUT}")
