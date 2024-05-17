{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Types(Pc, Insn, BusVal(..), Mem, FullWord, Addr) where

import Clash.Prelude

type Byte       = Unsigned 8
type HalfWord   = Unsigned 16
type FullWord       = Unsigned 32
type DoubleWord = Unsigned 64
type QuadWord   = Unsigned 128

data BusVal 
    = BusByte Byte
    | BusHalfWord HalfWord
    | BusWord FullWord
    | BusDoubleWord DoubleWord
    | BusQuadWord QuadWord
    deriving (Generic, Show, Eq, NFDataX)

type Pc   = DoubleWord
type Addr = DoubleWord
type Insn = FullWord
type Mem n = Vec n (Unsigned 32)