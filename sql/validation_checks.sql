sql


/*
Healthcare Provider Master Data Quality and Governance

Purpose:
Read-only validation of the completed portfolio database.

Prerequisite:
Open healthcare_provider_mdm.db in DB Browser for SQLite.
The project tables must already exist.

This script does not create the database or reproduce
the complete ingestion and cleaning workflow.

All deliberately introduced quality issues are simulated.
*/

-- 1. Validate master-table identifiers.
-- Expected: 200 records, 200 unique NPIs, 0 missing NPIs.

SELECT
    COUNT(*) AS total_providers,
    COUNT(DISTINCT npi) AS unique_npis,
    SUM(
        CASE
            WHEN npi IS NULL OR TRIM(npi) = ''
            THEN 1 ELSE 0
        END
    ) AS missing_npis
FROM provider_master;


-- 2. Check provider-name source distribution.
-- Expected:
-- SIMULATED_SOURCE_A: 5
-- SIMULATED_SOURCE_B: 195

SELECT
    provider_name_source,
    COUNT(*) AS provider_count
FROM provider_master
GROUP BY provider_name_source
ORDER BY provider_name_source;


-- 3. Review the five documented name recoveries.
-- Expected: 5 rows.

SELECT *
FROM name_recovery_audit
ORDER BY source_record_id;


-- 4. Review before-and-after quality results.
-- Expected: 5 issues before and 0 after for each rule.

SELECT
    stage,
    quality_check,
    issue_count,
    total_records,
    ROUND(
        100.0 * (total_records - issue_count)
        / NULLIF(total_records, 0),
        1
    ) AS rule_pass_rate_pct
FROM data_quality_comparison
ORDER BY
    quality_check,
    CASE stage
        WHEN 'Before' THEN 1
        WHEN 'After' THEN 2
        ELSE 3
    END;


-- 5. Confirm baseline and master record counts.
-- Expected: 200 rows in each table.
-- Equal counts alone do not prove the baseline is unchanged.

SELECT
    'providers_baseline' AS table_name,
    COUNT(*) AS row_count
FROM providers_baseline

UNION ALL

SELECT
    'provider_master' AS table_name,
    COUNT(*) AS row_count
FROM provider_master;
