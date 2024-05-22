module Bus(Request(..), Resp(..)) where

import Clash.Prelude
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)

data Error
    = UnMapped
    | UnAligned
    deriving (Generic, Show, Eq, NFDataX)

data Request a
    = ReqByte a
    | ReqHalfWord a
    | ReqWord a
    | ReqDoubleWord a
    | ReqQuadWord a
    deriving (Generic, Show, Eq, NFDataX)

data Resp
    = RespByte Byte
    | RespHalfWord HalfWord
    | RespWord FullWord
    | RespDoubleWord DoubleWord
    | RespQuadWord QuadWord
    | RespError Error
    deriving (Generic, Show, Eq, NFDataX)