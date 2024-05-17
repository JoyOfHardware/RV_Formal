{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Main where

import Clash.Prelude
import Machine(Machine(..),POWER_CPU(..))
-- import qualified Prelude as P



-- currently memory is only 8 words deep
memInit :: [Unsigned 32]
memInit = [
  0x0000a03c,
  0x3000a5e8,
  0x1a002038,
  0x18002598,
  0x10002588,
  0x01002170,
  0xf8ff8141,
  0x08002588,
  0x01002138,
  0x00002598,
  0xe8ffff4b,
  0x00000060,
  0x002000c0,
  0x00000000
  ]



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
  putStrLn msg
  where
    msg :: String = "Hello from Main!"
    -- strVal :: String = show testValSlice
    -- final_msg :: String = msg P.++ strVal