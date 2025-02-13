{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Simulation(Args(..), simulation) where

import Peripherals.Setup(setupPeripherals)
import Peripherals.Teardown(teardownPeripherals)
import Text.Printf (printf)
import Clash.Prelude
import Machine(
  Machine(..),
  RISCVCPU(..),
  machineInit, RISCVCPU (RISCVCPU))
import Fetch(fetchInstruction)
import Peripherals.UartCFFI(writeCharToTerminal)
import Control.Concurrent (threadDelay)

import Debug.Trace

data Args = Args {
    firmware :: FilePath
    } deriving (Show)

machine :: Machine
machine = machineInit

machine' :: Machine -> Machine
machine' machine =
  let
    -- instruction =
    --   traceShow
    --     (printf "0x%X" (toInteger v) :: String)
    --     v
    --   where v = fetchInstruction mem msr pc
    -- instruction = traceShow (bitpatToOpcode v) v
    --   where v = fetchInstruction machineMem machinePC
    machineMem  = mem machine
    machineCPU  = cpu machine
    machinePC   = pc machineCPU
    instruction = fetchInstruction machineMem machinePC
    addr = 0 :: Integer
    -- execute would go here, but right now, we simply
    mem' = replace addr (3) machineMem
    cpu' = machineCPU { pc = machinePC + 4 }
  in
    machine { cpu = cpu', mem = mem' }

machineSignal :: HiddenClockResetEnable dom => Signal dom Machine
machineSignal = register machine (machine' <$> machineSignal)

simulationLoop :: Int -> Machine -> IO [Machine]
simulationLoop 0 state = return [state]
simulationLoop n state = do
  let newState = machine' state
  rest <- simulationLoop (n - 1) newState
  return (state : rest)

simulation :: Args -> IO [Machine]
simulation args = do
  setupPeripherals

  -- quick smoketest that UART works - remove later
  writeCharToTerminal 'a'
  threadDelay 1000000  -- Delay for 1 second (1,000,000 microseconds)

  let initState = machine
  sim <- simulationLoop 5 initState
  teardownPeripherals
  return sim
