# HF BB-16 Banbury Mixer – Equipment Manual

| Field | Value |
|---|---|
| Document No. | VTC-EQP-BAN-003 |
| Revision | Rev 2.2 |
| Effective Date | 2023-11-10 |
| Prepared By | J. Petrov – Mechanical Engineer |

## 1. Introduction

This manual covers the operation, maintenance, and troubleshooting of the HF Mixing Solutions BB-16 Banbury Internal Mixer as installed at Vulcan Tire Corporation. The BB-16 is used for the intensive mixing of rubber compound ingredients including natural rubber (NR), synthetic rubbers (SBR, BR), carbon black, process oils, curatives, and accelerators.

The Banbury mixer is one of the most critical assets in the tire manufacturing process. Compound quality directly affects tire uniformity, durability, and safety ratings. Unplanned downtime on Banbury assets is classified as Tier 1 Critical and triggers immediate P1 response protocols per VTC-MNT-CMMS-002.

> **SAFETY:** Never perform maintenance on the Banbury mixer without completing LOTO procedure VTC-SAF-LOTO-007. High-voltage (480V/3-phase) and high-pressure hydraulic systems (3,000 PSI) are present throughout.

## 2. Equipment Specifications

| Parameter | Specification |
|---|---|
| Model | HF Mixing Solutions BB-16 Tangential Rotor Mixer |
| Chamber Volume | 160 liters (net working volume 112 liters) |
| Fill Factor Range | 0.65 – 0.75 (target 0.70) |
| Rotor Speed | 20–80 RPM (variable frequency drive controlled) |
| Drive Motor | 1,500 kW, 6,600V, 3-phase, 60Hz |
| Ram (Ram Cylinder) | Hydraulic, 3,000 PSI system pressure |
| Ram Pressing Force | 80 tonnes maximum |
| Mixing Chamber Temperature | Up to 180°C (356°F) during mixing |
| Cooling System | Closed-loop water cooling – rotors, chamber walls, ram |
| Cooling Water Pressure | 2.5–4.0 bar supply |
| Drop Door | Hydraulic actuated, 1,800 kN clamping force |
| Weight (Mixer Only) | 48,000 kg (approx.) |
| VTC Asset ID | VTC-P3-BAN-004-MXR (Banbury #4) |
| Serial Number | HF-BB16-2019-0421 |
| Installation Date | March 2019 |

## 3. Major Subsystems

### 3.1 Rotor Assembly

The BB-16 uses a 4-wing tangential rotor configuration. Rotors are made from alloy steel with a surface hardness of 58–62 HRC. Rotor tip clearance to chamber wall is factory-set at 2.5 mm and must be verified during annual overhaul.

- Rotor type: 4-wing tangential, counter-rotating
- Rotor material: Alloy steel, nitride hardened
- Main bearing: SKF 23284 CA/C3W33 spherical roller bearing
- Rotor seal type: Mechanical seals with Kalrez compound sealing faces
- Rotor tip wear limit: Replace or rebuild when tip clearance exceeds 5.0 mm

### 3.2 Hydraulic System

The hydraulic power unit (HPU) supplies 3,000 PSI to the ram cylinder and drop door actuators. The HPU uses ISO VG 46 anti-wear hydraulic oil. Oil temperature must be maintained between 40–55°C via the integral oil cooler. High-temperature alarm activates at 65°C; automatic shutdown at 75°C.

- HPU pump: Rexroth A10VSO140 variable displacement piston pump
- Hydraulic oil: Mobil DTE 25 (ISO VG 46 AW) – change interval 4,000 hours
- System relief valve setting: 3,150 PSI (do not adjust without engineering approval)
- Filter: 10 micron, absolute – change at delta-P indicator or every 2,000 hours
- Accumulator pre-charge: 1,500 PSI nitrogen – check monthly

### 3.3 Cooling Water System

Cooling water prevents thermal runaway during intensive mixing cycles. The closed-loop cooling circuit supplies chilled water (15–20°C inlet) to the rotor internals, chamber walls, and ram. A differential temperature rise (ΔT) exceeding 12°C indicates inadequate flow or fouled passages.

| Cooling Zone | Flow Rate (l/min) | Max Outlet Temp (°C) |
|---|---|---|
| Rotor (each) | 60–80 | 32°C |
| Chamber Walls | 120–160 | 28°C |
| Ram | 25–40 | 30°C |

## 4. Lubrication Schedule

| Lubrication Point | Lubricant | Method | Quantity | Interval |
|---|---|---|---|---|
| Main Rotor Bearings | Mobilux EP2 | Auto-lube system | 15 g/point | Weekly |
| Ram Guide Bearings | Mobilux EP2 | Manual grease gun | 10 g | Weekly |
| Drop Door Pivots | Mobilux EP2 | Manual grease gun | 20 g each | Monthly |
| Dust Stop Seal Lip | Molykote 111 | Manual application | Thin film | Weekly |
| Gearbox | Mobil SHC 630 | Level check / Oil analysis | Per level | Monthly / 4k hrs |

## 5. Common Faults & Troubleshooting

| Symptom | Probable Cause | Diagnostic Check | Corrective Action |
|---|---|---|---|
| Excessive compound temperature | Low cooling water flow or high inlet temp | Check flow meters and inlet temp gauge | Restore flow; check chiller |
| Hydraulic pressure loss | HPU pump wear or relief valve bypass | Pressure gauge at HPU output | Inspect pump; reset relief valve |
| Rotor seal leak (dust stop) | Worn seal faces or improper spring tension | Inspect seal housing for rubber bleed-through | Replace dust stop assembly (WO required) |
| High gearbox temperature | Low oil level, wrong grade, or bearing failure | Check oil level sight glass; oil temp sensor | Top up oil; send sample for analysis |
| Abnormal mixing energy profile | Incorrect fill factor; ingredient error; worn rotors | Review batch card; check rotor tip clearance | Adjust fill factor; inspect rotors |
