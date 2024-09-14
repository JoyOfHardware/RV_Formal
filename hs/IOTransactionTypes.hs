{-# LANGUAGE DeriveFunctor #-}

module IOTransactionTypes(Request(..), Response(..), Error(..)) where

import Clash.Prelude

import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord, DataSize)
import MachineMode(Endian(..))

data Error
    = UnMapped
    | UnAligned
    deriving (Generic, Show, Eq, NFDataX)

data Request = Request DataSize Addr Endian
    deriving (Generic, Show, Eq, NFDataX)

data ReadResponse 
    = ResponseByte        Byte
    | ResponseHalfWord    HalfWord
    | ResponseFullWord    FullWord
    | ResponseDoubleWord  DoubleWord
    | ResponseQuadWord    QuadWord
    | RespError Error
    deriving (Generic, Show, Eq, NFDataX)

data WriteResponse
    = WriteSuccess
    | WriteError Error
    deriving (Generic, Show, Eq, NFDataX)