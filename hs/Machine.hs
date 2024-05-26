{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Machine(
  Machine(..),
  POWER_CPU(..),
  Peripherals(..),
  machineInit) where

import Clash.Prelude
import Peripherals.Ram(Ram)
import Types(Pc, Mem)
import RegFiles(GPR, MSR, gprInit, msrInit)
import Peripherals.Ram(Ram)

data Peripherals = Peripherals 
  {
      ram :: Ram
  }
  deriving (Generic, Show, Eq, NFDataX)

data POWER_CPU = POWER_CPU
  { pc :: Pc,
    msr :: MSR,
    gpr :: GPR
  } 
  deriving (Generic, Show, Eq, NFDataX)

data Machine = Machine
  { cpu         :: POWER_CPU,
    peripherals :: Peripherals
  } 
  deriving (Generic, Show, Eq, NFDataX)

powerCPUInit :: POWER_CPU
powerCPUInit =
  POWER_CPU
    0
    msrInit
    gprInit

machineInit :: Peripherals -> Machine
machineInit peripheralsInit =
  Machine
    powerCPUInit
    peripheralsInit