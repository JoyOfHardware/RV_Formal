{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Machine(
  Machine(..),
  POWER_CPU(..),
  Endian(..),
  getEndian,
  machineInit) where

import Clash.Prelude
import Types(Pc, Mem, Endian)
import RegFiles(GPR, MSR, gprInit, msrInit)
import Peripherals.Ram(Ram)
import Types(Endian(..))

data POWER_CPU = POWER_CPU
  { pc :: Pc,
    msr :: MSR,
    gpr :: GPR
  } 
  deriving (Generic, Show, Eq, NFDataX)

data Machine = Machine
  { cpu :: POWER_CPU,
    ram :: Ram,
    mem :: Mem 14
  } 
  deriving (Generic, Show, Eq, NFDataX)


-- | Defined on page 946 of POWER 3.0 ISA
getEndian :: MSR -> Endian
getEndian msrVal = 
  let
    endianBit = pack msrVal ! 0
  in
    if endianBit == 1 then Little else Big

powerCPUInit :: POWER_CPU
powerCPUInit =
  POWER_CPU
    0
    msrInit
    gprInit

machineInit :: Ram -> Machine
machineInit ram =
  Machine
    powerCPUInit
    ram
    memInit

memInit :: Vec 14 (Unsigned 32)
memInit =
     0x0000A03C
  :> 0x3000A5E8
  :> 0x1A002038
  :> 0x18002598
  :> 0x10002588
  :> 0x01002170
  :> 0xF8FF8141
  :> 0x08002588
  :> 0x01002138
  :> 0x00002598
  :> 0xE8FFFF4B
  :> 0x00000060
  :> 0x002000C0
  :> 0x00000000
  :> Nil
