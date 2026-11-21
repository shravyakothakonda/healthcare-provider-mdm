# Governance Controls and Proposed Stewardship Process

## Scope

This document describes the governance-related controls implemented in a healthcare provider master-data portfolio prototype.

The project uses 200 public CMS NPPES provider records and two simulated source datasets derived from the same baseline.

This is not a production governance framework. Roles and exception-handling steps marked as proposed have not been implemented as an operational workflow.

## Implemented Controls

| Control | Implementation | Evidence |
|---|---|---|
| Baseline preservation | Original baseline retained without cleaning updates | providers_baseline |
| Controlled simulation | Deliberately introduced issues recorded separately | simulation_change_log |
| Data quality rules | Three SQL checks applied before and after cleaning | data_quality_before and data_quality_comparison |
| Separate remediation output | Corrections applied to a cleaned copy | providers_cleaned |
| Name-recovery traceability | Five recovered names documented with before/after values and reference source | name_recovery_audit |
| Attribute-level source tracking | Reference source recorded for each provider name | provider_name_source in provider_master |
| Identifier uniqueness | Unique index created on master-table NPI | idx_provider_master_npi |

Evidence listed above refers to objects in the local SQLite project database. These objects are not automatically included in this GitHub repository.

## Data Quality Rule Register

| Rule ID | Field | Requirement | Remediation Used |
|---|---|---|---|
| DQ-01 | provider_name | Provider name must not be null or blank | Recover from simulated Source A using exact NPI match |
| DQ-02 | city | City must not contain extra surrounding whitespace | Remove surrounding spaces |
| DQ-03 | state | Deliberately introduced "Ohio" values must use "OH" | Replace "Ohio" with "OH"; preserve legitimate other states |

Each rule was evaluated against 200 records.

Each rule had 5 failures before remediation and 0 afterward.

Rule pass rates improved from 97.5% to 100% for each tested rule. These are not overall accuracy scores.

## Name-Recovery Rule and Assumption

For the five deliberately blanked provider names:

1. Match the Source B record to simulated Source A by exact NPI.
2. Use the matching Source A name as the replacement.
3. Record the recovery in name_recovery_audit.
4. Label the provider-name source as SIMULATED_SOURCE_A.

This rule was valid for the controlled simulation because the simulated sources were derived from the same baseline.

Source A was not independently verified as authoritative.

The process does not demonstrate fuzzy matching, resolution of conflicting identities, or independent validation of provider names.

## Proposed Stewardship Responsibilities

These roles are a design proposal, not actual assigned project staff.

| Proposed Role | Responsibility |
|---|---|
| Data owner | Approve quality standards and source-selection policies |
| Data steward | Review exceptions, assess proposed corrections, and document decisions |
| Data analyst | Run checks, prepare exception evidence, and report results |

## Proposed Exception Process

The following process is proposed and was not implemented as an automated workflow:

1. Flag records that fail a quality rule.
2. Apply only documented, unambiguous formatting corrections automatically.
3. Hold missing-name records for review if no unique exact-NPI reference match is available.
4. Do not overwrite a nonblank name solely because another source contains a different value.
5. Record the issue, evidence, proposed correction, reviewer decision, and resolution status.
6. Re-run relevant checks after an approved correction.

## Privacy and Publication Boundary

- This project uses public provider data, not patient records.
- Patient names, clinical workbooks, credentials, and private account details must not be uploaded.
- Files must be reviewed before publication.
- Public availability of source data does not establish that every attribute is accurate or current.

## Limitations

- Controls were demonstrated on a small, controlled sample.
- No organizational approval workflow was implemented.
- No role-based access-control system was configured or tested.
- No regulatory compliance assessment was performed.
- Source tracking covers provider names, not full enterprise data lineage.
