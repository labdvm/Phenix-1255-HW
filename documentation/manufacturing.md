# Manufacturing and assembly

Notes for ordering and assembling the Phenix-1255 shield, revision **V2** and the **V2 Plus**
variant (layout of 25 Nov 2026). The production files are in
[`FRDM-SX1255/Gerber and BOM/`](../FRDM-SX1255/Gerber%20and%20BOM) (V2) and
[`FRDM-SX1255+/Gerber and BOM/`](../FRDM-SX1255+/Gerber%20and%20BOM) (V2 Plus).

## Production files

| File (V2) | Use |
|---|---|
| [`FRDM-SX1255-V2.kicad_pcb_gerber.zip`](../FRDM-SX1255/Gerber%20and%20BOM/FRDM-SX1255-V2.kicad_pcb_gerber.zip) | Gerber and drill files for PCB fabrication |
| [`FRDM-SX1255-V2.kicad_pcb_bom.csv`](../FRDM-SX1255/Gerber%20and%20BOM/FRDM-SX1255-V2.kicad_pcb_bom.csv) | Bill of materials with manufacturer and DigiKey part numbers |
| [`FRDM-SX1255-V2.kicad_pcb_positions.csv`](../FRDM-SX1255/Gerber%20and%20BOM/FRDM-SX1255-V2.kicad_pcb_positions.csv) | Pick-and-place positions |
| [`FRDM-SX1255-V2.kicad_pcb_netlist.ipc`](../FRDM-SX1255/Gerber%20and%20BOM/FRDM-SX1255-V2.kicad_pcb_netlist.ipc) | IPC-D-356 netlist for the electrical test |

The V2 Plus files have the same structure and are named `FRDM-SX1255+ V2.kicad_pcb_*`.

The Gerber ZIP also contains `User_Comments.gbr`. The manufacturer does not need it.

**BOM notes:**

- The **SAW filter X1** (Tai-Saw TA0655A) is excluded from the BOM in both variants (on V2 Plus it is
  also marked *do not populate*). It is in the position files; order it separately or add it to
  the BOM for the assembler.
- The BOM lists **J9** (FRDM header, value `~`, no part number). Like the other FRDM headers it
  is fitted by hand, so remove the line before sending the BOM to an assembly service. The
  position files contain all FRDM headers (J1–J4, J9, J12) and the OLED socket J7 as `tht` parts;
  these are not placed by the assembler either.

## PCB specification

| Parameter | Value |
|---|---|
| Size | 118 × 55 mm |
| Layers | 2 |
| Board thickness | **1.2 mm** |
| Copper | 35 µm (1 oz) outer layers |
| Min. track width / clearance | 0.2 mm / 0.2 mm |
| Vias | 0.6 mm pad / 0.3 mm drill (signal and stitching), 0.9 mm pad / 0.6 mm drill |
| Smallest drill | 0.3 mm (V2); **0.25 mm** for the three thermal vias in the U2 footprint (V2 Plus) |
| Min. copper to board edge | 0.5 mm |
| Mounting holes | 4 × M3 (3.2 mm) |

The board is designed for **1.2 mm**. Many manufacturers default to 1.6 mm, so set the thickness
explicitly when ordering.

## Assembly notes

- **SX1255 (IC1)** – QFN-32 with exposed pad and thermal vias. Reflow soldering is recommended;
  the exposed pad must be soldered to GND.
- **TCXO (Y1)** – The footprint fits 38.4 MHz TCXOs in 3225 and 2520 packages. The BOM uses an
  Epson TG2520SMN (clipped sine, 0.5–1 ppm). If you use a different part, keep 38.4 MHz: the sample
  rates are derived from it.
- **TQP3M9036 (U2, V2 Plus only)** – 2 × 2 mm DFN with exposed pad. Reflow soldering is
  recommended; the exposed pad must be soldered to GND.
- **PA switch (Q1)** – Diodes DMP1045UQ-7, P-channel MOSFET in SOT-23. (The `MPN` column of the
  BOM still shows the DigiKey number of the former BSS84; the manufacturer part and DigiKey part
  number columns are correct.)
- **U.FL connectors (JJ1 *TX*, JJ2 *RX*)** – Rated for a limited number of mating cycles. Use a
  short U.FL to SMA pigtail instead of connecting and disconnecting the antenna cable directly.
- **Push buttons (SW1–SW3)** – E-Switch TL3305CF260QG, SMD, on the C&K PTS647 footprint.
- **OLED socket (J7)** – 1×4 female header, 2.54 mm, for a 0.96″ SSD1306 I²C module.
- **FRDM headers** – Use stacking or socket headers that match the FRDM-MCXN947 (Samtec SSQ series
  in the design).

## First power-up

1. Check for shorts between `+5V0`, `+3V3` and GND before plugging the shield onto the FRDM board.
2. Plug the shield onto the FRDM-MCXN947 and power it. The *PWR* LED (D2) must light up.
3. Connect a 50 Ω load or antenna to *TX* (JJ1) before transmitting. Q1 has no gate pull-up, so the
   PA may be powered before the firmware drives `~PA_EN`
   (see [hardware.md](hardware.md#pa-supply)).
4. Flash the firmware from [phenix-1255-sw](https://github.com/w4tchd0g/phenix-1255-sw).
