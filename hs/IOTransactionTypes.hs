{-# LANGUAGE DeriveFunctor #-}

module IOTransactionTypes(Request(..), Resp(..), Error(..)) where

import Clash.Prelude

import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)

data Error
    = UnMapped
    | UnAligned
    deriving (Generic, Show, Eq, NFDataX)

data Request a
    = ReqByte a
    | ReqHalfWord a
    | ReqFullWord a
    | ReqDoubleWord a
    | ReqQuadWord a
    deriving (Generic, Show, Eq, NFDataX, Functor)

data Resp
    = RespByte Byte
    | RespHalfWord HalfWord
    | RespFullWord FullWord
    | RespDoubleWord DoubleWord
    | RespQuadWord QuadWord
    | RespError Error
    deriving (Generic, Show, Eq, NFDataX)