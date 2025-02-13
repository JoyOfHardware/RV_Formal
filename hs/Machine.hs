{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Machine(
  Machine(..),
  RISCVCPU(..),
  Endian(..),
  machineInit) where

import Clash.Prelude
import Types(Pc, Mem)
import RegFiles(GPR, FPR, CSR, gprInit, fprInit, csrInit)

data Endian = Big | Little
  deriving (Generic, Show, Eq, NFDataX)

data PrivilegeLevel
  = MachineMode
  | SuperVisorMode
  | UserMode
  deriving (Generic, Show, Eq, NFDataX)

data RISCVCPU = RISCVCPU
  { pc  :: Pc,
    gpr :: GPR,
    fpr :: FPR,
    privilegeLevel :: PrivilegeLevel
  }
  deriving (Generic, Show, Eq, NFDataX)

data Machine = Machine
  { cpu :: RISCVCPU,
    mem :: Mem 14
  }
  deriving (Generic, Show, Eq, NFDataX)

riscvCPUInit :: RISCVCPU
riscvCPUInit =
  RISCVCPU
    0
    gprInit
    fprInit
    MachineMode

machineInit :: Machine
machineInit =
  Machine
    riscvCPUInit
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
