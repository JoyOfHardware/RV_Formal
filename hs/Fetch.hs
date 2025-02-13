{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Fetch(fetchInstruction) where

import Clash.Prelude
import Types(Mem, Addr, FullWord)
import Util(endianSwapWord)

data Insn = Instruction FullWord
          | Misaligned Addr

fetchInstruction :: KnownNat n => Mem n -> Addr -> Insn
fetchInstruction mem addr =
  let
    isWordAligned = addr .&. 3 == 0
    addrWordAligned = addr `shiftR` 2
    insn = mem !! addrWordAligned
    -- TODO : check if instruction is word aligned and create type
    -- to capture if its not.
  in
    case isWordAligned of
      True -> Instruction insn
      False -> Misaligned addr
