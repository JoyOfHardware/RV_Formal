module Peripherals.Teardown(teardownPeripherals) where

import Prelude
import Peripherals.UartCFFI(restoreTerminal)

teardownPeripherals :: IO ()
teardownPeripherals = do
    restoreTerminal