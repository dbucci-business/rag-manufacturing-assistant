# Downtime Classification & Coding Guide

| Field | Value |
|---|---|
| Document No. | VTC-MNT-DT-006 |
| Revision | Rev 2.3 |
| Effective Date | 2024-02-12 |
| Prepared By | M. Okafor – Maintenance Planner |

## 1. Purpose & Scope

This document defines the standard downtime classification codes used at Vulcan Tire Corporation for recording all equipment downtime events in eMaint CMMS. Accurate downtime classification is critical for correct OEE calculation, MTBF/MTTR tracking, maintenance cost reporting, and production loss analysis. Misclassification directly corrupts KPI data reported to management.

All downtime entries must be recorded within 2 hours of downtime start by the maintenance technician or production supervisor. Classification changes after the fact require Maintenance Manager approval. Downtime records are locked for editing after the monthly report is generated (first business day of the following month).

## 2. Downtime Category Hierarchy

### 2.1 Level 1 – Primary Categories

| Code | Category | Definition | OEE Impact |
|---|---|---|---|
| PLN | Planned Downtime | Scheduled maintenance, planned changeovers, tooling changes – agreed upon in advance | Excluded from OEE denominator |
| UPL | Unplanned Maintenance | Reactive breakdowns, equipment failures, component defects discovered during production | Reduces Availability |
| OPS | Operational Downtime | Operator-controlled stoppages: material shortages, product changeovers, shift change, startup/warmup | Reduces Performance |
| EXT | External / Facility | Utility failures, facility emergencies, contractor-caused delays, external supply chain events | Reduces Availability |
| QUA | Quality Hold | Equipment stopped due to out-of-spec product; investigation or rework in progress | Reduces Quality Rate |

## 3. Detailed Code Library – Unplanned Maintenance (UPL)

| Code | Subcategory | Examples / Notes | Tier 1 Asset? | Auto-Alert? |
|---|---|---|---|---|
| UPL-MECH | Mechanical Failure | Bearing failure, shaft breakage, gear tooth damage, coupling failure | P1 Escalation | Yes – P1/P2 |
| UPL-ELEC | Electrical Failure | Motor failure, drive fault, sensor failure, wiring damage, PLC fault | P1 Escalation | Yes – P1/P2 |
| UPL-HYD | Hydraulic Failure | Hose rupture, cylinder seal failure, HPU pump failure, valve malfunction | P1 Escalation | Yes – P1/P2 |
| UPL-PNE | Pneumatic Failure | Air cylinder failure, solenoid valve stuck, pressure regulator failure, air leak | P2/P3 | Yes – P1/P2 |
| UPL-STM | Steam/Thermal Failure | Steam trap failure, steam leak, heat platen temperature loss, condensate backup | P1/P2 | Yes |
| UPL-INST | Instrumentation Failure | Temperature transmitter fault, pressure transducer drift, encoder failure | P2/P3 | No |
| UPL-SEAL | Seal/Gasket Failure | Dust stop seal failure (Banbury), bladder failure (TBM/press), gasket blowout | P1/P2 | Yes – P1 |
| UPL-STRCT | Structural/Weld Failure | Frame crack, weld failure, pin shear, structural component failure | P1 | Yes – P1 |
| UPL-UTIL | Utility-Related Unplanned | Unplanned utility failure affecting production (steam, compressed air, cooling water) | P1/P2 | Yes |

## 4. Planned Downtime Codes (PLN)

| Code | Type | Description & Scheduling Requirements |
|---|---|---|
| PLN-PM | Preventive Maintenance | Scheduled PM work per VTC-MNT-PM-004. Must be pre-scheduled in eMaint; auto-generated WO required. |
| PLN-CO | Planned Changeover | Mold change, tire size changeover. Duration target: <45 min for curing presses, <30 min for TBMs. Track as OEE Performance loss if exceeds target. |
| PLN-SHD | Scheduled Shutdown | Annual/semi-annual planned overhaul. Engineering approval required 60 days prior. SHD work order package required in eMaint. |
| PLN-CAL | Calibration / Testing | Scheduled calibration of measuring equipment, pressure testing, safety system testing. Record calibration certificate in eMaint document links. |
| PLN-TRN | Training Downtime | Equipment taken out of production for training exercises. Must be pre-approved by Production Supervisor. |

## 5. Downtime Recording Requirements in eMaint

Every downtime event exceeding 10 minutes must be recorded in eMaint. The following fields are mandatory:

- **Downtime Start Timestamp** – within 10 minutes of actual event
- **Downtime End Timestamp** – within 30 minutes of equipment return to service
- **Primary Downtime Code** (Level 1 + subcategory, e.g., UPL-MECH)
- **Asset ID** (eMaint Level 4 or Level 5 asset)
- **Contributing Factor Code** (secondary classification, optional but encouraged)
- **Downtime Notes** – minimum 15 words describing the failure and what was done

Downtime records are the primary data source for OEE, MTBF, and MTTR calculations. Inaccurate or missing records must be flagged by the Maintenance Planner during daily data review. Persistent recording failures by individual technicians must be escalated to the Maintenance Supervisor.
