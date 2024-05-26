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
import FetchReq(fetchInstructionReq)
import FetchResp(fetchInstructionResp)
import Peripherals.UartCFFI(writeCharToTerminal)
import Decode.BitpatsToOpcodes(bitpatToOpcode)
import Decode.OpcodeToForm(opcodeToForm)
import Decode.Opcodes(Opcode(..))
import Decode.Forms(Form(..))
import Data.Maybe(fromMaybe)
import Control.Concurrent (threadDelay)
import Util(showHex128)
import Bus(read)

import Debug.Trace

import System.IO.Unsafe (unsafePerformIO)

forceTraceShowUnsafe :: Show a => a -> b -> b
forceTraceShowUnsafe x y = unsafePerformIO $ do
    traceShow x (return y)

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
                 gpr = gpr 
               }),
    peripherals = peripherals
          }) =
  let
    stage1 = fetchInstructionReq
    stage2 = fetchInstructionResp

    fetchReq          = stage1 msr pc
    executedFetchReq  = Bus.read fetchReq peripherals
    insn              = stage2 executedFetchReq

    opcode :: Opcode
    opcode = fromMaybe undefined $ bitpatToOpcode insn

    form :: Form
    form =  opcodeToForm opcode

    pc'   = pc + 4
    cpu'  = powerCPU { pc = pc' }
    peripherals' = peripherals
  in
    machine { cpu = cpu', peripherals = peripherals' }

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