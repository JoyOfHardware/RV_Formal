{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Main where

import Clash.Prelude
    ( Num((+)),
      Integer,
      IO,
      (<$>),
      register,
      sampleN,
      replace,
      HiddenClockResetEnable,
      Signal,
      System )
import Prelude
import Machine(
  Machine(..),
  POWER_CPU(..),
  machineInit)
import Fetch(fetchInstruction)
import Text.Show.Pretty (ppShow)
import Text.Printf (printf)
-- import qualified Prelude as P
import BitpatsToOpcodes(bitpatToOpcode)

import Debug.Trace

machine :: Machine
machine = machineInit

-- Placeholder function that currently just increments
-- the first entry in memory by 1
machine' :: Machine -> Machine
machine' machine@(
  Machine { 
    cpu = powerCPU@(
      POWER_CPU{ pc = pc ,
                 msr = msr ,
                 gpr = gpr }),
    mem = mem }) =
  let
    -- get current instruction
    -- instruction = 
    --   traceShow 
    --     (printf "0x%X" (toInteger v) :: String) 
    --     v
    --   where v = fetchInstruction mem msr pc
    instruction = traceShow (bitpatToOpcode v) v
      where v = fetchInstruction mem msr pc
    addr = 0 :: Integer
    mem' = replace addr (instruction + 1) mem
    pc' = pc + 4
    cpu' = powerCPU { pc = pc' }
  in
    machine { cpu = cpu', mem = mem' }

machineSignal :: HiddenClockResetEnable dom => Signal dom Machine
machineSignal = register machine (machine' <$> machineSignal)

-- Simulate the first 5 states
simResults :: [Machine]
simResults = sampleN @System 5 machineSignal


main :: IO ()
main = do
  putStrLn "Simulating Machine"
  -- mapM_ (putStrLn . ppShow) simResults
  -- putStrLn $ ppShow $ P.last simResults
  putStrLn $ "executed for " ++ show (length simResults) ++ " cycles"
  putStrLn "Simulation complete"