# Manufacturing and assembly

Notes for ordering and assembling the Phenix-1255 shield, revision **V1.3**. All production files
are in [`Gerber and BOM/`](../Gerber%20and%20BOM).

## Production files

| File | Use |
|---|---|
| [`FRDM-SX1255.kicad_pcb_gerber.zip`](../Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_gerber.zip) | Gerber and drill files for PCB fabrication |
| [`FRDM-SX1255.kicad_pcb_bom.csv`](../Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_bom.csv) | Bill of materials with manufacturer and DigiKey part numbers |
| [`FRDM-SX1255.kicad_pcb_positions.csv`](../Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_positions.csv) | Pick-and-place positions |
| [`FRDM-SX1255.kicad_pcb_netlist.ipc`](../Gerber%20and%20BOM/FRDM-SX1255.kicad_pcb_netlist.ipc) | IPC-D-356 netlist for the electrical test |

The Gerber ZIP also contains `User_Comments.gbr`. The manufacturer does not need it.

## PCB specification

| Parameter | Value |
|---|---|
| Size | 118 × 55 mm |
| Layers | 2 |
| Board thickness | **1.2 mm** |
| Copper | 35 µm (1 oz) outer layers |
| Min. track width / clearance | 0.2 mm / 0.2 mm |
| Vias | 0.6 mm pad / 0.3 mm drill |
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
- **U.FL connectors (J5, J6)** – Rated for a limited number of mating cycles. Use a short U.FL to
  SMA pigtail instead of connecting and disconnecting the antenna cable directly.
- **Rotary encoder** – Alps EC11E series with push button, 20 mm shaft height (through-hole).
- **FRDM headers** – Use stacking or socket headers that match the FRDM-MCXN947 (Samtec SSQ series
  in the design).
- ***bypass* solder jumper** – Leave open for normal operation. Closing it powers the SX1255 PA
  permanently, see [hardware.md](hardware.md#pa-supply-and-bypass-jumper).

## First power-up

1. Check for shorts between `+5V0`, `+3V3` and GND before plugging the shield onto the FRDM board.
2. Plug the shield onto the FRDM-MCXN947 and power it. The *PWR* LED (D1) must light up.
3. Connect a 50 Ω load or antenna to *TX* (J6) before transmitting.
4. Flash the firmware from [phenix-1255-sw](https://github.com/w4tchd0g/phenix-1255-sw).
