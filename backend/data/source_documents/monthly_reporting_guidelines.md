# Monthly Maintenance Report – Guidelines & Template

| Field | Value |
|---|---|
| Document No. | VTC-MNT-RPT-008 |
| Revision | Rev 2.0 |
| Effective Date | 2024-03-15 |
| Prepared By | D. Bucci – SQL Engineer |

## 1. Purpose & Scope

This document defines the standard process, content requirements, and submission guidelines for the Vulcan Tire Corporation monthly maintenance performance report. The report is produced by the Maintenance Manager with input from the Maintenance Planner and SQL Engineer. It is automatically emailed to the Plant Manager and VP of Operations on the 2nd Monday of a given calendar month, covering the prior month's performance.

The monthly report is the primary accountability document for the maintenance department. It must contain accurate KPI data sourced from eMaint, ManTrak, and SQL databases; include honest commentary on performance vs. targets; document significant events; and commit to specific corrective actions when KPIs are below target.

## 2. Required Report Sections

### 2.1 Executive Summary

Maximum 1 page. Must include: overall OEE performance vs. target; top 3 maintenance issues impacting production; significant safety events (incidents, near-misses); and overall maintenance cost vs. budget. The Executive Summary is written last but appears first in the report. Use plain language suitable for non-technical readers.

### 2.2 KPI Performance Dashboard

Present all KPIs from VTC-MNT-KPI-001 in a standard table format showing: actual performance, target, variance (+/-), RAG (Red/Amber/Green) status, and trend vs. prior 3 months. Data must be pulled directly from eMaint monthly reports and ManTrak production summary. No manual calculation is permitted for primary KPIs.

| KPI Code | Metric | Target | Actual | Variance | RAG | Trend (3mo) |
|---|---|---|---|---|---|---|
| KPI-001 | OEE | ≥ 85% | [data] | [+/-] | Green | [↑↓→] |
| KPI-002 | MTBF | ≥ 120 hrs | [data] | [+/-] | Amber | [↑↓→] |
| KPI-003 | MTTR | ≤ 2.5 hrs | [data] | [+/-] | Green | [↑↓→] |
| KPI-004 | Asset Availability | ≥ 92% | [data] | [+/-] | Red | [↑↓→] |
| KPI-005 | PM Compliance | ≥ 95% | [data] | [+/-] | Green | [↑↓→] |
| KPI-006 | Reactive Maint. Ratio | ≤ 20% | [data] | [+/-] | Amber | [↑↓→] |
| KPI-007 | PM Schedule Adherence | ≥ 90% | [data] | [+/-] | Green | [↑↓→] |
| KPI-008 | Maint. Cost/Unit | ≤ $0.38 | [data] | [+/-] | Green | [↑↓→] |

### 2.3 Top 5 Downtime Events Analysis

List the 5 individual downtime events with the greatest production impact (in hours lost) during the reporting month. For each event provide: asset ID, date/time, downtime code (per VTC-MNT-DT-006), duration, production units lost (from ManTrak), root cause summary, and current status of corrective action.

| Rank | Asset ID | Date | DT Code | Duration | Units Lost | Root Cause / Status |
|---|---|---|---|---|---|---|
| 1 | [Asset ID] | [Date] | [Code] | [hrs] | [#] | [Root cause + action status] |
| 2 | [Asset ID] | [Date] | [Code] | [hrs] | [#] | [Root cause + action status] |
| 3 | [Asset ID] | [Date] | [Code] | [hrs] | [#] | [Root cause + action status] |
| 4 | [Asset ID] | [Date] | [Code] | [hrs] | [#] | [Root cause + action status] |
| 5 | [Asset ID] | [Date] | [Code] | [hrs] | [#] | [Root cause + action status] |

### 2.4 PM Compliance Detail

Report PM compliance by department and asset class. List all PM tasks that were completed late (outside the compliance window per VTC-MNT-CMMS-002 Section 3.2) with reason codes and owner. If department PM compliance falls below the Warning threshold (88%), a written explanation and corrective action plan must be attached.

### 2.5 Maintenance Cost Summary

Provide a cost breakdown by category (labor – direct, labor – contractor, materials/spare parts, external services) compared to monthly budget. Flag any single WO or project exceeding $10,000 with a brief explanation. The Maintenance Cost Per Unit (KPI-008) must reconcile with the production unit count from ManTrak.

### 2.6 Corrective Action Register (CAR) Update

List all open corrective actions from previous reports. For each: provide original issue, action owner, target completion date, current status (Open/In Progress/Complete), and updated completion date if changed. Close completed actions with evidence reference (WO number, test result, photo). New corrective actions opened this month must be added to the register.

### 2.7 Safety & Environmental Section

Report all safety events (incidents, near-misses, first-aid cases, OSHA recordable events) that occurred in the maintenance department or involved maintenance personnel during the month. Each event must have: date, brief description, affected personnel (role only – no names in report), immediate action taken, and investigation status. LOTO violations or breaches must be highlighted separately and reported to the EHS Manager.

## 3. Data Sources & Cut-Off Dates

| Data Element | Source System | Data Cut-Off |
|---|---|---|
| WO Labor, Downtime, PM Completion | eMaint Enterprise v11.4 | Last day of month, 23:59 |
| Production Units, Quality Rejects | ManTrak MES | Last day of month, 23:59 |
| Materials Cost, PO Values | SAP MM / FI Module | 2nd business day of next month |
| Contractor Invoices | SAP AP Module | 2nd business day of next month |
| Vibration/Temperature Trends | OSIsoft PI Historian | Last day of month |

## 4. Report Submission & Distribution

### 4.1 Submission Deadline

The monthly report must be submitted by 17:00 on the 3rd business day of the following month. Submit to the Plant Manager and VP of Operations via email with the eMaint PDF export attached. Late submission requires advance notification to the Plant Manager with a reason and revised submission date.

### 4.2 Distribution List

- Plant Manager (primary recipient – full report)
- VP of Operations (full report)
- Production Manager (Sections 2.1, 2.3, 2.5 only)
- EHS Manager (Section 2.7 only)
- Maintenance Planner & SQL Engineer (full report)
- Maintenance Supervisor (full report)

### 4.3 Report Filing

Completed reports are filed in the SharePoint Maintenance Reports library under Plant 3 > Maintenance > Monthly Reports > [Year]. Reports are retained for a minimum of 5 years per VTC records retention policy. The eMaint raw data export used to generate the report must also be saved in the same SharePoint folder as supporting evidence.
