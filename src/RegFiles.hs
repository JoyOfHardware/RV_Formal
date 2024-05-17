{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module RegFiles(
    GPR,
    MSR, 
    gprInit,
    msrInit
    ) where

import Clash.Prelude

type GPR = Vec 32 (Unsigned 64) -- General Purpose Registers page 10
type MSR = Unsigned 64

gprInit :: GPR
gprInit = 
    0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :>
    0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :>
    0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :>
    0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :> 0 :>
    Nil

-- TODO : set/get functions for fields in MSR
-- and other registers
msrInit :: Unsigned 64
msrInit = 1