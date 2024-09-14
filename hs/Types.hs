{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Types(
    Pc,
    Insn,
    Mem,
    Addr,
    Byte,
    HalfWord,
    FullWord,
    DoubleWord,
    DataSize,
    QuadWord) where

import Clash.Prelude

type Byte       = Unsigned 8
type HalfWord   = Unsigned 16
type FullWord   = Unsigned 32
type DoubleWord = Unsigned 64
type QuadWord   = Unsigned 128

data DataSize
    = Byte
    | HalfWord
    | FullWord
    | DoubleWord
    | QuadWord
    deriving (Generic, Show, Eq, NFDataX)

type Pc   = DoubleWord
type Addr = DoubleWord
type Insn = FullWord

-- TODO remove Mem and replace with Bus later
type Mem n = Vec n (Unsigned 32)