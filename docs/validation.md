# Data Platform Support Runbook Case Study

This project is documentation-first. CI performs lightweight validation so the repository stays usable as a portfolio artifact.

## Validate locally

```bash
python3 scripts/generate_sample_data.py
python3 -m json.tool dashboards/grafana-dashboard.json >/dev/null
```
