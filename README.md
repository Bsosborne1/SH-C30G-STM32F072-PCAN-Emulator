# SH-C30G STM32F072 PCAN Emulator

Community firmware work for the **DSD TECH SH-C30G** USB-CAN adapter using its **STM32F072** MCU, based on the open-source `pcan_cantact` firmware family.

## Current status

The STM32F072 build and PCAN-facing USB interface have now been verified on an SH-C30G:

- STM32F072 firmware builds successfully
- firmware flashes successfully to the SH-C30G
- the adapter enumerates over USB
- the adapter's LEDs show activity
- **Tesla Toolbox 2.1 detects the adapter as a PCAN device**

### Tesla Toolbox 2.1 offline verification

A direct unplugged/plugged comparison was performed in Tesla Toolbox 2.1:

- with the SH-C30G unplugged, Toolbox reports **`No PCAN devices found.`**
- with the programmed SH-C30G plugged in, that message disappears and Toolbox recognizes a PCAN interface

This verifies the USB identity / PEAK PCAN API detection path well enough to confirm that Toolbox 2.1 recognizes the adapter as PCAN-compatible hardware.

**Actual CAN transmit/receive communication through Tesla Toolbox has not yet been verified against a vehicle or a second CAN node.** That remains the final functional test before calling the adapter a fully validated drop-in replacement for this use case.

## Build

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/Bsosborne1/SH-C30G-STM32F072-PCAN-Emulator.git
cd SH-C30G-STM32F072-PCAN-Emulator
./scripts/build.sh
```

The wrapper builds the proven STM32F072 target equivalent to:

```bash
make canable MCU_SERIES=F072
```

and copies the generated firmware into `build/`.

Typical output includes:

```text
build/pcan_canable_hw.hex
build/pcan_canable_hw.bin
```

## Repository layout

- `upstream/` — pinned `FooFooDamon/pcan_cantact` source as a Git submodule
- `overrides/usbd_desc-fixup.c` — SH-C30G PCAN USB identity override
- `scripts/build.sh` — reproducible STM32F072 build wrapper
- `.github/workflows/build.yml` — CI build
- `ATTRIBUTION.md` — upstream history and credits

## Why the override is separate

The upstream firmware deliberately uses a neutral XCAN USB identity. Its Makefile supports a local `Src/usbd_desc-fixup.c` override, so this repository keeps the PCAN identity change separate from upstream code. That makes the modification easy to audit and avoids silently rewriting the upstream source tree.

## Hardware

Target hardware: **DSD TECH SH-C30G**

MCU: **STM32F072**

The STM32F072 support comes from the `FooFooDamon/pcan_cantact` fork, which added the F072 startup file, linker script, MCU definitions, and `MCU_SERIES=F072` build path.

## Flashing

Flash the generated `.hex` or `.bin` with your normal STM32 programming method. Verify the target MCU and flash address before programming.

## Upstream and license

See `ATTRIBUTION.md` for project history. The upstream project uses **WTFPL v2**; a copy is included in `LICENSE`.

## Trademark / affiliation notice

This is an independent community project. It is not affiliated with or endorsed by PEAK-System Technik GmbH or DSD TECH. PCAN and related names are trademarks of their respective owners.
