# CMMS Work Order & PM Procedures

| Field | Value |
|---|---|
| Document No. | VTC-MNT-CMMS-002 |
| Revision | Rev 4.0 |
| Effective Date | 2024-02-01 |
| Prepared By | M. Okafor – Maintenance Planner |

## 1. Purpose & Scope

This procedure establishes the standard operating procedures for Vulcan Tire Corporation's Computerized Maintenance Management System (CMMS), currently eMaint Enterprise v11.4. All maintenance work orders, PM schedules, asset records, and inventory transactions must be processed through eMaint. This document covers work order lifecycle management, asset hierarchy, PM creation, and spare parts requisitioning.

Adherence to these procedures is mandatory for all maintenance technicians, planners, supervisors, and anyone who creates or closes work orders in eMaint. Failure to follow CMMS procedures affects KPI accuracy, inventory control, and regulatory compliance.

## 2. Work Order (WO) Lifecycle

### 2.1 Work Order Types

| WO Type | Code | Description | Priority System |
|---|---|---|---|
| Preventive | PM | Scheduled PMs generated from asset PM templates | Scheduled Date |
| Corrective | CM | Unplanned repairs to failed/degraded equipment | P1–P4 Scale |
| Predictive | PdM | WOs generated from condition monitoring findings | Condition Finding |
| Project | PROJ | Capital or improvement projects >$5,000 | Project Schedule |
| Shutdown | SHD | Planned shutdown/overhaul work packages | Shutdown Plan |

### 2.2 Priority Classification (Corrective Work Orders)

| P# | Priority | Criteria | Response Time | Completion Target |
|---|---|---|---|---|
| P1 | High | Safety hazard OR complete production line stoppage | < 1 hr | 8 hrs or ASAP |
| P2 | Low | Partial production loss or quality impact pending | < 2 hrs | < 24 hrs |
| P3 | Routine | Equipment running but PM finding or minor defect | Same shift | < 7 days |
| P4 | Planned | Non-critical, can be scheduled in advance | Next planning cycle | < 30 days |

### 2.3 Work Order Creation

All corrective work orders must be created by the requestor in eMaint before work begins, except in P1 emergency situations where verbal notification to the supervisor is permitted, followed by WO creation within 30 minutes of initiating work.

Required Fields – Corrective Work Orders:

- Asset ID (from eMaint asset hierarchy – never use free-text asset name alone)
- Work Order Type (CM, PM, PdM, PROJ, SHD)
- Priority (P1–P4)
- Diagnosis Description (minimum 15 words describing observed failure or defect)
- Downtime Start Timestamp (if equipment is down, should be automatically calculated)
- Requesting Supervisor name and department

### 2.4 Work Order Closure Requirements

Work orders must be closed in eMaint after completion of repair phase. Work orders must be signed off by a shift lead or higher position to complete the signoff phase portion of eMaint. Maintenance Technicians are responsible for entering all accurate labor hours, materials consumed, and failure codes (Reason and Category) as completed via the android system. Call phase, diagnosis phase, repair phase, and signoff phase must reflect accurate hours to ensure data validity. Supervisors must review and approve closure of all P1 and P2 WOs.

Closure Checklist:

- Ensure all phases of work order are valid before signoff of ticket
- Enter all parts consumed with quantities (link to storeroom issue transactions)
- Select Category and Reason from the eMaint dropdown after diagnosing
- Enter Work Accomplished description (minimum 20 words)
- Attach photos of completed repair if P1 or P2
- Generate follow-up WO if additional work was identified during repair

### 2.5 Work Order Phase System & Mobile Workflow

Work orders (also referred to as tickets — the terms are synonymous) are created and managed through the eMaint mobile app on Android phones issued to operators and maintenance technicians on the floor. Every corrective work order progresses through four mandatory phases: Call, Diagnosis, Repair, and Signoff. Each phase captures a timestamp and duration; all four must reflect accurate real-world times to ensure valid KPI data.

**Phase 1 – Call**
The Call phase begins when an operator creates a ticket on their Android device after a machine goes down or a defect is observed. The operator selects the asset from the eMaint hierarchy, describes the issue, and submits the ticket. The Call phase clock runs from ticket creation until a maintenance technician physically arrives at the machine and advances the ticket to Diagnosis.

**Phase 2 – Diagnosis**
The technician arrives at the equipment and presses the Diagnosis button in the eMaint app, ending the Call phase and starting Diagnosis. During this phase the technician inspects the equipment, identifies the root cause, and selects the correct Category and Reason codes from the eMaint dropdown menus. Accurate code selection is critical — these codes drive failure analysis and KPI calculations. Diagnosis ends when the technician submits the selected codes and moves the ticket into Repair.

**Phase 3 – Repair**
Repair phase begins immediately after Diagnosis is submitted and covers all active hands-on work to restore the equipment. For P1 and P2 work orders, the repair duration target is under 1 hour. Work orders that remain in Repair phase for longer than one day are typically on hold awaiting parts from the storeroom; a parts hold reason must be noted in the Work Accomplished field. All labor hours, materials consumed, and parts issued must be recorded in eMaint before the technician advances to Signoff.

**Phase 4 – Signoff**
Repair completion alone does not close a work order. The ticket enters Signoff phase and must be reviewed and approved by a shift lead, supervisor, or manager before it is marked Complete. The approving party verifies that all required fields are filled, phase durations are accurate, parts are recorded, and photos are attached (required for P1/P2). A ticket is not counted as complete in KPI reporting until the Signoff phase is finished.

**Invalid Tickets**
Phase durations that are implausible or inconsistent — for example, a Diagnosis phase of zero minutes or a Repair phase that ends before it begins — result in the ticket being flagged as invalid. Invalid tickets are excluded from MTTR and MTBF calculations, which degrades reporting accuracy. Specific thresholds that trigger the invalid flag are managed by the Maintenance Planner and are not published in this document. Technicians must enter accurate phase timestamps at the time of transition, not retroactively.

| Phase | Starts When | Ends When | Key Requirement |
|---|---|---|---|
| Call | Operator creates ticket on Android | Technician arrives and presses Diagnosis | Accurate downtime start timestamp |
| Diagnosis | Technician presses Diagnosis at machine | Category and Reason codes submitted | Correct Category/Reason selection |
| Repair | Diagnosis codes submitted | Technician advances ticket to Signoff | All parts and labor recorded; P1/P2 target < 1 hr |
| Signoff | Repair advanced by technician | Shift lead or manager approves | All fields complete; photos attached for P1/P2 |

## 3. PM Schedule Management

### 3.1 PM Frequency Codes

| Code | Interval | Typical Application | Trigger | WO Lead Time |
|---|---|---|---|---|
| PM-D | Daily | Curing press mold inspection, lubrication routes | Calendar | Same day |
| PM-W | Weekly | TBM stitcher roll inspection, Banbury rotor check | Calendar | 2 days |
| PM-M | Monthly | Hydraulic system inspection, conveyor alignment | Calendar | 5 days |
| PM-Q | Quarterly | Gearbox oil analysis, motor insulation testing | Calendar | 10 days |
| PM-A | Annual | Curing press overhaul, TBM full refurbishment | Shutdown | 30 days |
| PM-MH | Meter-based | Belt replacements, bearing changes by cycle count | Machine hrs/cycles | Per schedule |

### 3.2 PM Compliance Window

PMs are considered "on time" when completed within the defined compliance window. Early completion beyond the early window requires supervisor approval and resets the PM clock from the date completed. Overdue PMs trigger an automatic escalation email to the department supervisor at 24 hours past due, and to the Maintenance Manager at 72 hours past due.

| PM Frequency | Early Window | On-Time Window | Late (Overdue) |
|---|---|---|---|
| Daily | Same day | ± 0 days | Next day |
| Weekly | 2 days early | ± 1 day | > 1 day past due |
| Monthly | 5 days early | ± 3 days | > 3 days past due |
| Quarterly | 10 days early | ± 7 days | > 7 days past due |
| Annual | 14 days early | ± 14 days | > 14 days past due |

## 4. Asset Hierarchy

eMaint uses a 5-level asset hierarchy. All equipment must be registered at the correct level before work orders can be raised against it. The Maintenance Planner is the asset hierarchy administrator and must approve all new asset records.

| Level | Name | Example | eMaint ID Format |
|---|---|---|---|
| 1 | Site | Vulcan Tire – Plant 3 (Akron, OH) | VTC-P3 |
| 2 | Department | Banbury Mixing Department | VTC-P3-BAN |
| 3 | System | Banbury #4 Mixer System | VTC-P3-BAN-004 |
| 4 | Asset | Banbury BB-16 Mixer (Asset #BAN-004) | VTC-P3-BAN-004-MXR |
| 5 | Component | Banbury #4 Rotor Assembly | VTC-P3-BAN-004-MXR-ROT |

## 5. Spare Parts Requisitioning via eMaint

Technicians request spare parts through the eMaint Parts Request module linked to the active work order. All parts issues from the storeroom must be recorded against a WO number. Parts not in the eMaint catalog require a New Part Request submitted to the Maintenance Planner at least 48 hours before needed.

For emergency parts procurement outside storeroom hours, contact the on-call Maintenance Supervisor who holds P-card authority up to $500 per transaction. All emergency purchases must be linked to the P1/P2 work order in eMaint within 24 hours with receipt attached.
