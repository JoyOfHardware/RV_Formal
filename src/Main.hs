{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Main where

import Clash.Prelude
import qualified Prelude as P
import Types(Pc)

import Util(powerIndex32, powerIndex64)
import OpcodeToForm(opcodeToForm)


getRsSlice insn = slice (powerIndex32 @0) (powerIndex32 @5) insn
val32 = 0x1C_34_56_78 :: Unsigned 32

testValSlice :: Unsigned 6
testValSlice = unpack $ getRsSlice val32


-- currently memory is only 8 words deep
memInit :: [Unsigned 32]
memInit = [
  0x1,
  2,
  3,
  4,
  5]

type GPR = Vec 32 (Unsigned 64) -- General Purpose Registers page 10
type Mem n = Vec n (Unsigned 32)


data POWER_CPU = POWER_CPU
  { pc :: Pc,
    gpr :: GPR
  } deriving (Show)

data Machine = Machine 
  { cpu :: POWER_CPU,
    mem :: Mem 1024
  } deriving (Show)

-- Placeholder function that currently just increments
-- the first entry in memory by 1
machine' :: Machine -> Machine
machine' machine@(Machine { cpu = POWER_CPU { pc = pc }, mem = mem }) =
  let
    -- get current instruction
    instruction :: Unsigned 32
    instruction = mem !! fromIntegral pc
  in
    machine { mem = replace (0 :: Integer) (head mem + 1) mem }


main :: IO ()
main = do
  putStrLn final_msg
  where
    msg :: String = "Hello from Main!"
    strVal :: String = show testValSlice
    final_msg :: String = msg P.++ strVal