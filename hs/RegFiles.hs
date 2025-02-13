{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module RegFiles(
    GPR,
    FPR,
    CSR,
    gprInit,
    fprInit,
    csrInit
    ) where

import Clash.Prelude

-- In RISC-V, besides the GPR, FPR, and CSR, we may also encounter
-- the following which are not modeled in this codebase.
--  * VRF(Vector Registers File) for vector processing.
--  * Debug Registers (DBR) for hardware debugging.
--  * Shadow Registers for fast context switching (optional).
--  * MPU Registers for memory protection.
--  * Counter/Timer Registers for time/cycle counting.
--  * Hypervisor Registers (HPR) for guest virtualization.

type GPR = Vec 32 (Unsigned 64)
type FPR = Vec 32 (Unsigned 64)
type CSR = Vec 4096 (Unsigned 64)

gprInit :: GPR
gprInit = repeat 0

fprInit :: FPR
fprInit = repeat 0

-- TODO: CSR can't actually be all 0 during initialization.
-- We need to revisit the following and properly initialize
-- various registers later.
csrInit :: CSR
csrInit =
    replace (0x301 :: Integer) misa_init
  $ replace (0x300 :: Integer) mstatus_init
  $ replace (0x305 :: Integer) mtvec_init
  $ replace (0xF11 :: Integer) mvendorid_init
  $ replace (0xF12 :: Integer) marchid_init
  $ replace (0xF13 :: Integer) mimpid_init
  $ replace (0x701 :: Integer) mtime_init
  $ replace (0x321 :: Integer) mtimecmp_init
  $ repeat 0
  where
    misa_init     = 0x8000000000001104  -- `RV64IMAFD`
    mstatus_init  = 0x0000000000001800  -- Default `mstatus`
    mtvec_init    = 0x0000000000001000  -- Trap vector base
    mvendorid_init = 0x00000000
    marchid_init   = 0x00000000
    mimpid_init    = 0x00000000
    mtime_init     = 0x0000000000000000
    mtimecmp_init  = 0xFFFFFFFFFFFFFFFF
