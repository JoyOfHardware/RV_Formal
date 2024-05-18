module Peripherals.Setup (setupPeripherals) where

import Prelude
import Peripherals.UartCFFI(initTerminal)

setupPeripherals :: IO ()
setupPeripherals = do
    initTerminal