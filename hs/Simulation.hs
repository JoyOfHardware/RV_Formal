{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Simulation(Simulation(..), Args(..), simulation) where

import Peripherals.Setup(setupPeripherals, InitializedPeripherals(..))
import Peripherals.Teardown(teardownPeripherals)
import Text.Printf (printf)
import Clash.Prelude
import qualified Prelude as P
import Machine(
  Machine(..),
  Peripherals(..),
  POWER_CPU(..),
  machineInit)
import Fetch(fetchInstruction)
import Peripherals.UartCFFI(writeCharToTerminal)
import Decode.BitpatsToOpcodes(bitpatToOpcode)
import Control.Concurrent (threadDelay)
import Util(showHex128)

import Debug.Trace

data Args = Args {
    firmware :: FilePath
    } deriving (Show)

data Simulation 
  = Success [Machine]
  | Failure String
  deriving (Show)

-- machine :: Machine
-- machine = machineInit

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

simulationLoop :: Int -> Machine -> IO [Machine]
simulationLoop 0 state = return [state]
simulationLoop n state = do
  let newState = machine' state
  rest <- simulationLoop (n - 1) newState
  return (state : rest)

simulation :: Args -> IO Simulation
simulation args = do
  initializedPeripherals <- setupPeripherals (firmware args)
  case initializedPeripherals of
    InitializationError e -> return $ Failure e
    InitializedPeripherals ram -> do

      let initState = machineInit $ Machine.Peripherals ram
      sim <- simulationLoop 5 initState
      teardownPeripherals
      return $ Success sim