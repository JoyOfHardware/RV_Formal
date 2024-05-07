# About
A formal golden reference model for the POWER 3.0B ISA implemented in 
Clash Haskell.

[Link](https://wiki.raptorcs.com/w/images/c/cb/PowerISA_public.v3.0B.pdf) to the POWER 3.0 ISA PDF Spec.

# Getting Started
This works with ghc 9.4.8

The clash compiler is basically a modified version of ghc designed to allow for first class support of haskell code as circuits.

Note that this repository is currently very much W.I.P. That being said,
this is how you would currently run a simulation:

```bash
$MAIN=Main make
```

# Notes
All the context that we pick up as we execute an instruction in
essence forms the context of our micro-op machinery.

# TODO
 - [ ] getForm :: Opcode -> Form
   - all fields will be populated of course!
 - [ ] All Python scripts in one place in this repository

# TODO Quality of Life Enhancements
 - [ ] turn off derive generics
 - [ ] update commands to use flags that prevent ghc
       intermediate outputs from littering source tree
 - [ ] enable Phoityne debug
 - [ ] learn to use trace and jupyter
 - [ ] learn to debug with generic pretty prints
 - [ ] draw conclusions on feasibility of debugging
       without VCD viewer

# TODO : Binary Dev and Firmware Testing
 - [ ] Write test in Rust ppc baremetal toolchain
 - [ ] Move Python Haskell generators into codebase

# Considerations for FPGA Implementation
 - [ ] `Opcode -> PackedField` function should have intermediate
       step that specifies how to slice instruction bitpat to
       generate/populate sub-fields of a specific form - to the
       end that more efficient logic is generated for/during
       synthesis.