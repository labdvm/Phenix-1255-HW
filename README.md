<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="documentation/images/phenix-1255_logo_white.png">
    <img src="documentation/images/phenix-1255_logo_transparent.png" alt="Phenix-1255 logo" width="240">
  </picture>
</p>

<p align="center">
  <b>"Pi-less" SX1255 RF shield for the NXP FRDM-MCXN947</b><br>
  KiCad hardware design · separate RX/TX paths · 38.4 MHz TCXO · HS USB or Ethernet via the FRDM board
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-CERN--OHL--P%20v2-blue" alt="License: CERN-OHL-P v2"></a>
  <a href="https://www.kicad.org/"><img src="https://img.shields.io/badge/KiCad-10-314CB0" alt="KiCad 10"></a>
  <a href="FRDM-SX1255.pdf"><img src="https://img.shields.io/badge/revision-V1.3-2e7d32" alt="Revision V1.3"></a>
  <a href="https://github.com/w4tchd0g/phenix-1255-sw"><img src="https://img.shields.io/badge/software-phenix--1255--sw-555" alt="Software: phenix-1255-sw"></a>
</p>

<p align="center">
  <a href="#overview">Overview</a> ·
  <a href="#features">Features</a> ·
  <a href="#documentation">Documentation</a> ·
  <a href="#repository-contents">Repository contents</a> ·
  <a href="#getting-started">Getting started</a> ·
  <a href="#license">License</a>
</p>

<p align="center">
  <img src="documentation/images/FRDM-SX1255.png" alt="Phenix-1255 PCB – top side" width="720">
</p>

## Overview

Phenix-1255 is a shield board that pairs the popular **Semtech SX1255** RF transceiver with the
**NXP FRDM-MCXN947** development board — no Raspberry Pi required. The MCX N947 handles the
I/Q sample stream and talks to the host PC over **High-Speed USB** or **Ethernet**.

The project idea comes from **[DM5LF](https://github.com/w4tchd0g)**, who also writes the software. The hardware was designed by **[Z32IT](https://github.com/labdvm)**.

| | |
|---|---|
| 🧠 **Controller** | NXP FRDM-MCXN947 (plugs directly onto the shield headers) |
| 📡 **RF transceiver** | Semtech SX1255 (I/Q, 400–510 MHz) |
| ⏱️ **Reference clock** | 38.4 MHz TCXO, 0.5–1 ppm |
| 🔌 **Host link** | High-Speed USB 2.0 or LAN, selectable via slide switch |
| ⚡ **Power** | 5 V from the FRDM-MCXN947 (USB-C); PoE operation possible with a 48 V → 5 V USB-C PoE splitter |
| 📐 **PCB** | 118 × 55 mm, 2 layers, 1.2 mm thickness |

## Features

- **Separate RX and TX paths** with U.FL connectors
  - RX: SAW band-pass filter (TDK B3909)
  - TX: low-pass filter (Mini-Circuits LFCN-490+)
- **Power supply** – 3.3 V LDO (MCP1703), ferrite-bead filtering, resettable 500 mA fuse, TVS diode array (SP0502BAHT)
- **User interface**
  - Rotary encoder with push button
  - Header for an I²C OLED display
  - Status LEDs: *PWR*, *Err*, *Warn*, *Good*
- **USB / LAN slide switch** to select the host interface

## Board views

| Top | Bottom |
|:---:|:---:|
| <img src="documentation/images/FRDM-SX1255.png" alt="Top side" width="420"> | <img src="documentation/images/FRDM-SX1255_b.png" alt="Bottom side" width="420"> |

The shield is designed for the NXP FRDM-MCXN947 development board, see the
[NXP FRDM-MCXN947 product page](https://www.nxp.com/design/design-center/development-boards-and-designs/FRDM-MCXN947)
for photos, documentation and the board pinout.

## Documentation

| Document | Content |
|---|---|
| [Hardware](documentation/hardware.md) | Block overview, header pin assignment, USB/LAN switch, PA supply and *bypass* jumper, power supply |
| [Manufacturing and assembly](documentation/manufacturing.md) | PCB specification, production files, assembly notes, first power-up |

## Host PC requirements

| Component | Minimum |
|---|---|
| Interface | USB 2.0 (High-Speed) or Ethernet |
| CPU | Intel or AMD, 4 cores |
| RAM | 4 GB DDR3 |
| Storage | SSD |
| OS | Xubuntu x64 |

## Repository contents

| File | Description |
|---|---|
| [`FRDM-SX1255.kicad_pro`](FRDM-SX1255.kicad_pro) | KiCad project |
| [`FRDM-SX1255.kicad_sch`](FRDM-SX1255.kicad_sch) | Schematic |
| [`FRDM-SX1255.kicad_pcb`](FRDM-SX1255.kicad_pcb) | PCB layout |
| [`FRDM-SX1255.pdf`](FRDM-SX1255.pdf) | Schematic as PDF |
| [`documentation/`](documentation) | Hardware and manufacturing documentation, images |
| [`Gerber and BOM/`](Gerber%20and%20BOM) | Manufacturing data |
| ├─ [`…_gerber.zip`](Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_gerber.zip) | Gerber files for PCB fabrication |
| ├─ [`…_bom.csv`](Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_bom.csv) | Bill of materials (incl. DigiKey part numbers) |
| ├─ [`…_positions.csv`](Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_positions.csv) | Pick-and-place positions for assembly |
| └─ [`…_netlist.ipc`](Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_netlist.ipc) | IPC-D-356 netlist for electrical testing |

## Getting started

1. **Order the PCB** – upload the Gerber ZIP to a PCB manufacturer of your choice
   (2 layers, **1.2 mm** board thickness). For assembly, provide the BOM and position files as well.
   Details: [Manufacturing and assembly](documentation/manufacturing.md).
2. **Assemble** the shield and plug it onto the FRDM-MCXN947.
3. **Connect antennas / RF cabling** to the U.FL connectors *RX* (J5) and *TX* (J6).
4. **Select the host interface** with the *USB/LAN* switch.
5. **Install the software** from [phenix-1255-sw](https://github.com/w4tchd0g/phenix-1255-sw).

## Related projects

- 💻 **Software:** [w4tchd0g/phenix-1255-sw](https://github.com/w4tchd0g/phenix-1255-sw)

## Credits

- **Idea & software:** DM5LF – [@w4tchd0g](https://github.com/w4tchd0g)
- **Hardware design:** Z32IT – [@labdvm](https://github.com/labdvm)

## License

Copyright © Z32IT 2026.

This source describes Open Hardware and is licensed under the **CERN-OHL-P v2**.

You may redistribute and modify this source and make products using it under the terms of the
[CERN-OHL-P v2](https://ohwr.org/cern_ohl_p_v2.txt). This source is distributed **WITHOUT ANY EXPRESS
OR IMPLIED WARRANTY, INCLUDING OF MERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A PARTICULAR
PURPOSE**. Please see the CERN-OHL-P v2 for applicable conditions.

Source location: <https://github.com/labdvm/Phenix-1255-HW>
