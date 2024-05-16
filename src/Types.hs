{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Types(Pc, Insn, BusVal(..)) where

import Clash.Prelude

type Byte       = Unsigned 8
type HalfWord   = Unsigned 16
type Word       = Unsigned 32
type DoubleWord = Unsigned 64
type QuadWord   = Unsigned 128

data BusVal 
    = Byte 
    | HalfWord 
    | Word 
    | DoubleWord 
    | QuadWord
    deriving (Generic, Show, Eq, NFDataX)

type Pc   = Unsigned 64
type Insn = Unsigned 32