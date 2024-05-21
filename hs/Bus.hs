module Bus(Request(..), Resp(..)) where

import Clash.Prelude
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)

data Error
    = UnMapped
    | UnAligned
    deriving (Generic, Show, Eq, NFDataX)

data Request 
    = ReqByte Addr
    | ReqHalfWord Addr
    | ReqWord Addr
    | ReqDoubleWord Addr
    | ReqQuadWord Addr
    deriving (Generic, Show, Eq, NFDataX)

data Resp
    = RespByte Byte
    | RespHalfWord HalfWord
    | RespWord FullWord
    | RespDoubleWord DoubleWord
    | RespQuadWord QuadWord
    | RespError Error
    deriving (Generic, Show, Eq, NFDataX)