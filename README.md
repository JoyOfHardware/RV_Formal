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
 - [ ] getOpcode :: Instr -> Opcode
 - [ ] getForm :: Opcode -> Form

# TODO Quality of Life Enhancements
 - [ ] turn off derive generics
 - [ ] update commands to use flags that prevent ghc
       intermediate outputs from littering source tree
 - [ ] enable Phoityne debug
 - [ ] learn to use trace and jupyter
 - [ ] learn to debug with generic pretty prints
 - [ ] draw conclusions on feasibility of debugging
       without VCD viewer