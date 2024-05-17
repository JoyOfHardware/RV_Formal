{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module RegFiles(GPR) where

import Clash.Prelude

type GPR = Vec 32 (Unsigned 64) -- General Purpose Registers page 10