{-# LANGUAGE ForeignFunctionInterface #-}

module Peripherals.UartCFFI (
    initTerminal,
    restoreTerminal,
    getCharFromTerminal,
    writeCharToTerminal,
    isCharAvailable,
    setupSigintHandler,
    wasCtrlCReceived
) where

import Prelude
import Foreign.C.Types
import Foreign.C.String
import Foreign.Ptr

foreign import ccall "init_terminal"            initTerminal :: IO ()
foreign import ccall "restore_terminal"         restoreTerminal :: IO ()
foreign import ccall "get_char_from_terminal"   getCharFromTerminal :: IO CChar
foreign import ccall "write_char_to_terminal"   writeCharToTerminal :: CChar -> IO ()
foreign import ccall "is_char_available"        isCharAvailable :: IO CInt
foreign import ccall "setup_sigint_handler"     setupSigintHandler :: IO ()
foreign import ccall "was_ctrl_c_received"      wasCtrlCReceived :: IO CInt

-- Haskell wrappers to handle the CBool return type
ctrlCReceived :: IO Bool
ctrlCReceived = do
    result <- wasCtrlCReceived
    return (result /= 0)
