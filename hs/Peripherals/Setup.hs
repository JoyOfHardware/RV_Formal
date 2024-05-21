module Peripherals.Setup (setupPeripherals, InitializedPeripherals) where

import Prelude
import Peripherals.UartCFFI (initTerminal)
import Peripherals.Ram (initRamFromFile, Ram)
import Control.Exception (try, IOException, throwIO)
import System.IO.Error (ioeGetErrorString)

type FirmwareFilePath = FilePath

data InitializedPeripherals 
    = InitializedPeripherals Ram
    | InitializationError String
    deriving (Show)

setupPeripherals :: FirmwareFilePath -> IO InitializedPeripherals
setupPeripherals firmwareFilePath = do
    -- initTerminal
    result <- try (initRamFromFile firmwareFilePath)
    
    return $ case result of
      Right (Just ram) -> InitializedPeripherals ram
      Right Nothing -> InitializationError $ firmwareFilePath ++ failure ++ suggestion
      Left e -> InitializationError $ firmwareFilePath ++ failure ++ suggestion ++ " Error: " ++ ioeGetErrorString e
  where
    failure    = ": Failed to initialize RAM from file!"
    suggestion = " Is the file 4-byte aligned?"