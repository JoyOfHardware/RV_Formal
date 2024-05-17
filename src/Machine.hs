{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Machine(Machine(..), POWER_CPU(..)) where

import Clash.Prelude
import Types(Pc, Mem)
import RegFiles(GPR)

data POWER_CPU = POWER_CPU
  { pc :: Pc,
    gpr :: GPR
  } deriving (Show)

data Machine = Machine 
  { cpu :: POWER_CPU,
    mem :: Mem 1024
  } deriving (Show)
