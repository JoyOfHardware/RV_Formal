# About
An attempt at a formal reference model for the RISC-V ISA written in
Clash Haskell.

# Getting Started
This works with ghc 9.4.8

The clash compiler is basically a modified version of ghc designed to allow for first class support of haskell code as circuits.

Note that this repository is currently very much W.I.P. That being said,
this is how you would currently run a simulation:

```bash
cabal run main --ghc-options="-D_RAM_DEPTH=2048" -- --firmware=./rv_tests/hello_world/hello.bin
```

# Notes
All the context that we pick up as we execute an instruction in
essence forms the context of our micro-op machinery.

## Installing GCC-RISC-V Toolchain on [Insert Platform Here]

Change instructions to support Nix


# TODO
 - [ ] fetch should invoke mem read function

# Organization Thoughts
 - Potential functions
   1. BitPat -> Opcode
   2. Opcode -> Fields
   3. Fields -> Field Vals
   4. Field Vals -> Reg Vals

# Thoroughness
 - [ ] Check that all forms get used!! Remove unused forms!!

# Grant Notes
 - [ ] Some forms may be redundant(may need to remove some)

## Quality of Life Enhancements
 - [ ] turn off derive generics
 - [ ] update commands to use flags that prevent ghc
       intermediate outputs from littering source tree
 - [ ] enable Phoityne debug
 - [ ] learn to use trace and jupyter
 - [ ] draw conclusions on feasibility of debugging
       without VCD viewer
