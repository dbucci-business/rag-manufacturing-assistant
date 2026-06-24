# Maintenance KPI Definitions & Targets

| Field | Value |
|---|---|
| Document No. | VTC-MNT-KPI-001 |
| Revision | Rev 3.1 |
| Effective Date | 2024-01-15 |
| Prepared By | D. Bucci – SQL Engineer |

## 1. Purpose & Scope

This document defines the standard Key Performance Indicators (KPIs) used by Vulcan Tire Corporation to measure and manage maintenance department performance across all manufacturing facilities. These KPIs are tracked in the eMaint CMMS system and reported monthly to the Plant Manager and VP of Operations.

These definitions apply to all tire manufacturing lines including Green Tire Building (GTB), Banbury Mixing, Curing/Vulcanization, and Finishing & Inspection departments. All maintenance personnel, planners, and supervisors are expected to understand and apply these metrics consistently.

## 2. Core Availability & Reliability KPIs

### 2.1 Overall Equipment Effectiveness (OEE)

**KPI-001:** OEE = Availability Rate × Performance Rate × Quality Rate

OEE is the primary production efficiency metric at Vulcan Tire. A world-class OEE target for tire manufacturing is considered 85% or above. Planned downtime (scheduled PMs, changeovers) is excluded from the Availability denominator.

| Sub-Metric | Formula | Target | Calculation Period |
|---|---|---|---|
| Availability Rate | Uptime / (Uptime + Unplanned DT) | ≥ 92% | Monthly |
| Performance Rate | Actual Output / Ideal Output | ≥ 95% | Monthly |
| Quality Rate | Good Units / Total Units | ≥ 98.5% | Monthly |

### 2.2 Mean Time Between Failures (MTBF)

MTBF measures average operating time between unplanned equipment failures. It is calculated per asset class and rolled up to department level.

**KPI-002:** MTBF = Total Uptime Hours / Number of Unplanned Failures

### 2.3 Mean Time To Repair (MTTR)

MTTR measures the average time required for maintenance to restore equipment to operational status following a failure. Clock starts when the ticket moves from diagnosis phase to repair; ticket is finished with repair when phase moves to signoff.

**KPI-003:** MTTR = Total Repair Hours / Number of Repairs

### 2.4 Asset Availability (AA)

Asset Availability is tracked individually for critical Tier 1 assets including Banbury mixers, tire building machines (TBMs), and curing presses. Differs from OEE Availability in that it uses total working hours as the denominator, inclusive of planned maintenance.

**KPI-004:** AA = (Total Working Hours – All Downtime Hours) / Total Working Hours × 100

### KPI Targets Summary

| KPI Code | Metric Name | Target | Warning | Critical |
|---|---|---|---|---|
| KPI-001 | Overall Equipment Effectiveness (OEE) | ≥ 85% | 80–84% | < 80% |
| KPI-002 | Mean Time Between Failures (MTBF) | ≥ 120 hrs | 80–119 hrs | < 80 hrs |
| KPI-003 | Mean Time To Repair (MTTR) | ≤ 2.5 hrs | 2.5–4 hrs | > 4 hrs |
| KPI-004 | Asset Availability | ≥ 92% | 88–91% | < 88% |
| KPI-005 | Planned Maintenance Compliance (PMC) | ≥ 95% | 88–94% | < 88% |
| KPI-006 | Reactive Maintenance Ratio | ≤ 20% | 21–30% | > 30% |
| KPI-007 | PM Schedule Adherence | ≥ 90% | 80–89% | < 80% |
| KPI-008 | Maintenance Cost / Unit Produced | ≤ $0.38 | $0.39–$0.50 | > $0.50 |

## 3. Maintenance Efficiency KPIs

### 3.1 Planned Maintenance Compliance (PMC)

PMC measures the percentage of scheduled preventive maintenance (PM) tasks completed on time within the defined tolerance window. In eMaint, a PM is considered "on time" if completed within ±10% of its scheduled interval or within the defined PM window.

**KPI-005:** PMC = (PM Tasks Completed On Time / Total PM Tasks Scheduled) × 100

The 95% PMC target applies at the monthly department level. Individual asset PM compliance is tracked separately for Tier 1 critical equipment (Banbury mixers, TBMs, curing presses) where a 100% on-time target is enforced.

### 3.2 Reactive Maintenance Ratio (RMR)

RMR is the ratio of unplanned/reactive maintenance hours to total maintenance hours (planned + unplanned). Industry best practice for tire manufacturing is to maintain reactive work below 20% of total maintenance effort. A high RMR indicates insufficient preventive maintenance coverage or aging equipment issues.

**KPI-006:** RMR = (Reactive WO Hours / Total WO Hours) × 100

### 3.3 Maintenance Cost Per Unit (MCU)

MCU normalizes maintenance expenditure against production output, enabling cost benchmarking across different production periods and facility sizes. Includes labor (direct + contractor), parts consumption, and external service costs. Excludes capital expenditures.

**KPI-008:** MCU = Total Maintenance Cost ($) / Total Good Tires Produced

## 4. KPI Data Sources & Reporting

### 4.1 Primary Data Sources

- eMaint CMMS – Work order labor, downtime, PM schedules, parts consumption
- Production MES (ManTrak) – Units produced, cycle time, quality defects
- SAP ERP – Material costs, purchase orders, contractor invoices
- Asset sensor data – Vibration, temperature readings fed via OSIsoft PI Historian

### 4.2 Reporting Cadence

| Report | Frequency | Audience | Owner |
|---|---|---|---|
| Daily Department KPIs | Daily | Dept. Managers | SQL Engineer |
| Weekly Reliability Review | Weekly | Dept. Managers | SQL Engineer |
| Monthly Performance Report | Monthly | Plant Manager, VP Ops | Maint. Manager |

## 5. KPI Ownership & Accountability

The Maintenance Manager is the KPI owner for all metrics listed in this document and is responsible for monthly review and corrective action when KPIs fall below target. The SQL Engineer is responsible for data integrity, trend analysis, and root cause investigation for sustained KPI degradation (3+ consecutive months below target).

Corrective Action Plans (CAPs) must be submitted to the Plant Manager within 5 business days whenever any Critical threshold is breached. CAPs are tracked in the eMaint action register.
