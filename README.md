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

## Installing GCC-PPC Toolchain on MacOS

```bash
brew install gcc@10 gmp mpfr libmpc
cd resources
bash build_gcc.sh
```

# TODO
 - [ ] getForm :: Opcode -> Form
   - all fields will be populated of course!
 - [ ] audit behavior of ffil
 - [ ] Correct typo from 'FlagAbosolute' to 'FlagAbsolute'
 - [ ] rename `isa_generator` to `haskell_gen`
 - [ ] rename `isa_packed.csv` and remove uneeded columns
 - [ ] Perhaps update generator scripts to use Pandas

## Readability Improvements
- [ ] Need to improve readability of Haskell Code generators

## Quality of Life Enhancements
 - [ ] turn off derive generics
 - [ ] update commands to use flags that prevent ghc
       intermediate outputs from littering source tree
 - [ ] enable Phoityne debug
 - [ ] learn to use trace and jupyter
 - [ ] learn to debug with generic pretty prints
 - [ ] draw conclusions on feasibility of debugging
       without VCD viewer

## Binary Dev and Firmware Testing
 - [ ] Write test in Rust ppc baremetal toolchain
 - [ ] Move Python Haskell generators into codebase

# Considerations for FPGA Implementation
 - [ ] `Opcode -> PackedField` function should have intermediate
       step that specifies how to slice instruction bitpat to
       generate/populate sub-fields of a specific form - to the
       end that more efficient logic is generated for/during
       synthesis.

# Generating Haskell Opcodes, Forms, Decoder, and Populated Forms
Some of the Haskell sources are auto-generated using a Python script
that reads in POWER ISA information in machine format from a CSV.

Run the following to re-generate the auto-generated Haskell sources.
```bash
python3 -m venv .env
cd hs_gen
pip3 install -r requirements.txt
python3 extract_opcodes_to_haskell.py ../src/Opcodes.hs
python3 extract_bitpat_to_haskell.py ../src/Decode.hs
python3 generate_form_variants.py ../src/Forms.hs
```