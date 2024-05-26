{-# LANGUAGE DeriveFunctor #-}

module IOTransactionTypes(Request(..), Resp(..), Error(..)) where

import Clash.Prelude

import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)
import MachineMode(Endian(..))

data Error
    = UnMapped
    | UnAligned
    deriving (Generic, Show, Eq, NFDataX)

data Request addr
    = ReqByte        addr  Endian
    | ReqHalfWord    addr  Endian
    | ReqFullWord    addr  Endian
    | ReqDoubleWord  addr  Endian
    | ReqQuadWord    addr  Endian
    deriving (Generic, Show, Eq, NFDataX, Functor)

data Resp
    = RespByte Byte
    | RespHalfWord HalfWord
    | RespFullWord FullWord
    | RespDoubleWord DoubleWord
    | RespQuadWord QuadWord
    | RespError Error
    deriving (Generic, Show, Eq, NFDataX)