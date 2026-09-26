# SH-C30G STM32F072 PCAN Emulator

Firmware work for the DSD TECH SH-C30G USB-CAN adapter built around an STM32F072, derived from the open-source `pcan_cantact` project and its STM32F072-capable fork.

## Status

- STM32F072 build path: verified
- Firmware flash to SH-C30G: verified
- USB enumeration on the SH-C30G: verified
- TX/RX LED activity: verified
- PEAK/PCAN USB identity work: in progress; do not treat the current repository as hardware-verified PCAN compatibility until that step is documented as tested

The known-good hardware test build was produced with:

```sh
make canable MCU_SERIES=F072
```

and flashed from `build-canable/pcan_canable_hw.hex`.

## Hardware

Target: DSD TECH SH-C30G

MCU: STM32F072

## Upstream

This work is derived from the `pcan_cantact` project and the STM32F072 changes published by FooFooDamon. The repository will retain attribution and the upstream license.

## Disclaimer

This is an independent community project and is not affiliated with or endorsed by PEAK-System Technik GmbH or DSD TECH. PCAN and related names are trademarks of their respective owners.
