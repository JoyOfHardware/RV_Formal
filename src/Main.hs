{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Main where

import Clash.Prelude
import Forms(FormA2(..))

powerIndex32 :: forall n a . (KnownNat n, Num a) => 
  0 <= n => 
  n <= 31 => 
  a -> SNat (31 - n)
powerIndex32 n = SNat @(31 - n)


-- currently memory is only 8 words deep
memInit :: [Unsigned 32]
memInit = [
  0x1,
  2,
  3,
  4,
  5]

type PC = Unsigned 64
type GPR = Vec 32 (Unsigned 64) -- General Purpose Registers page 10
type Mem n = Vec n (Unsigned 32)


data POWER_CPU = POWER_CPU
  { pc :: PC,
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
  putStrLn "Hello from Main!"