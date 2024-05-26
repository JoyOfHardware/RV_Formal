{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Fetch(fetchInstruction) where

import Clash.Prelude
import Types(Mem, Insn, Addr)
import Machine(Endian(..), getEndian)
import RegFiles(MSR)
import Util(endianSwap)
import IOTransactionTypes(Request(..), Resp(..))

fetchInstruction :: KnownNat n => Mem n -> MSR -> Addr -> Insn
fetchInstruction mem msr addr =
  let
    endian = getEndian msr
    addrWordAligned = addr `shiftR` 2
    insn = mem !! addrWordAligned
  in
    case endian of
      Big -> insn
      Little -> endianSwap insn
