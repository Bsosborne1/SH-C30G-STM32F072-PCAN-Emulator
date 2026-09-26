# SH-C30G STM32F072 PCAN Emulator

Community firmware work for the **DSD TECH SH-C30G** USB-CAN adapter using its **STM32F072** MCU, based on the open-source `pcan_cantact` firmware family.

## Current status

The hardware-side STM32F072 build has been verified on an SH-C30G:

- STM32F072 firmware builds successfully
- firmware flashes successfully to the SH-C30G
- the adapter enumerates over USB
- the adapter's LEDs show activity

The remaining item that still needs explicit hardware verification is final PEAK/PCAN driver compatibility using the descriptor override in this repository. Until that test is completed, treat this as **working SH-C30G STM32F072 firmware with PCAN-compatibility work in progress**, not as a fully validated drop-in PCAN replacement.

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
