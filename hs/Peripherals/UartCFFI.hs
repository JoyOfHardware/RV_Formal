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
import Data.Char (chr, ord)

-- Foreign imports directly corresponding to the C functions
foreign import ccall "init_terminal"            c_initTerminal :: IO ()
foreign import ccall "restore_terminal"         c_restoreTerminal :: IO ()
foreign import ccall "get_char_from_terminal"   c_getCharFromTerminal :: IO CChar
foreign import ccall "write_char_to_terminal"   c_writeCharToTerminal :: CChar -> IO ()
foreign import ccall "is_char_available"        c_isCharAvailable :: IO CInt
foreign import ccall "setup_sigint_handler"     c_setupSigintHandler :: IO ()
foreign import ccall "was_ctrl_c_received"      c_wasCtrlCReceived :: IO CInt

-- Haskell friendly wrappers
initTerminal :: IO ()
initTerminal = c_initTerminal

restoreTerminal :: IO ()
restoreTerminal = c_restoreTerminal

getCharFromTerminal :: IO Char
getCharFromTerminal = fmap (chr . fromEnum) c_getCharFromTerminal

writeCharToTerminal :: Char -> IO ()
writeCharToTerminal char = c_writeCharToTerminal (toEnum $ ord char)

isCharAvailable :: IO Int
isCharAvailable = fmap fromEnum c_isCharAvailable

setupSigintHandler :: IO ()
setupSigintHandler = c_setupSigintHandler

wasCtrlCReceived :: IO Int
wasCtrlCReceived = fmap fromEnum c_wasCtrlCReceived

-- Improved version of the ctrlCReceived to use the new wasCtrlCReceived signature
ctrlCReceived :: IO Bool
ctrlCReceived = fmap (/= 0) wasCtrlCReceived