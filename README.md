# Healthcare Provider Master Data Quality and governance 

A healthcare provider master-data portfolio prototype using public CMS NPPES data, SQL, SQLite, and Power BI.

## Project Overview

This project demonstrates a controlled workflow for identifying, correcting, and documenting provider master-data quality issues.

The project uses 200 provider records retrieved from the CMS NPPES API using a Cincinnati, Ohio search. The original baseline was preserved unchanged, and two simulated source datasets were created for testing.

The quality issues described below were deliberately introduced for demonstration. They were not discovered as errors in the original CMS data.

## Dashboard

![Power BI dashboard showing 200 providers, 15 simulated issues before cleaning, and 0 after cleaning](provider_data_quality_dashboard.png)

## Tools Used

- CMS NPPES API: public provider data
- SQL and DB Browser for SQLite: validation, cleaning, matching, and audit tables
- Excel: project documentation
- Power BI: before-and-after data-quality reporting

## Workflow

1. Retrieved and prepared 200 provider records.
2. Preserved an unchanged baseline dataset.
3. Created simulated Source A and Source B datasets.
4. Introduced and logged controlled issues in Source B.
5. Implemented three SQL data-quality checks.
6. Created a cleaned copy without overwriting the baseline.
7. Recovered five missing names from Source A using exact NPI matching.
8. Recorded name recovery in an audit table.
9. Created a prototype provider master table with name-source tracking.
10. Visualized the before-and-after results in Power BI.

## Data Quality Results

Each rule was evaluated against 200 records.

| Quality Rule | Issues Before | Issues After | Pass Rate Before | Pass Rate After |
|---|---:|---:|---:|---:|
| Required provider name present | 5 | 0 | 97.5% | 100% |
| City has no extra surrounding spaces | 5 | 0 | 97.5% | 100% |
| Simulated "Ohio" state value standardized to "OH" | 5 | 0 | 97.5% | 100% |

Total simulated rule failures decreased from 15 to 0.

These percentages are rule pass rates, not overall data accuracy scores.

## Master-Table Validation

- Total provider records: 200
- Unique NPIs: 200
- Missing NPIs: 0
- Provider names recovered from simulated Source A: 5

## Governance and Traceability

- Preserved the original baseline.
- Logged deliberately introduced changes.
- Retained separate source and cleaned tables.
- Documented five name recoveries using exact NPI matches.
- Recorded the source used for each provider name.
- Preserved legitimate out-of-state addresses rather than forcing all records to Ohio.

## Assumptions and Limitations

- Source A and Source B are simulated copies derived from the same baseline, not independent operational systems.
- Source A was used as the name-recovery reference under an explicit simulation assumption; it was not independently verified as authoritative.
- Exact NPI matching demonstrates identifier-based matching, not fuzzy matching or comprehensive entity resolution.
- Passing the three checks does not verify every provider attribute.
- The API search sample is not a complete census of Cincinnati providers.
- This is a portfolio prototype, not a production enterprise MDM implementation.

## Repository Contents

- `README.md`: project overview, methods, results, and limitations
- `provider_data_quality_dashboard.png`: Power BI dashboard screenshot

## Data Source and Privacy

Source data was retrieved from the public CMS NPPES API.

No patient records or clinical workbooks are included in this repository.
