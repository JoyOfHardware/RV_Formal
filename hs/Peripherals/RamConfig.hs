{-# LANGUAGE CPP #-}

module Peripherals.RamConfig(
  RAMAddrWidth,
  BytesPerRAMLine,
  LineAddrWidth,
  NumLinesInRAM,
  NumBytesInRAM,
  RAMLine,
  RAMAddr
) where

import Clash.Prelude

import Util(Log2)

#ifndef _RAM_ADDR_WIDTH
#define _RAM_ADDR_WIDTH 10
#endif

type RAMAddrWidth     = _RAM_ADDR_WIDTH
type BytesPerRAMLine  = 16
type LineAddrWidth    = Util.Log2 BytesPerRAMLine
type NumLinesInRAM    = 2 ^ RAMAddrWidth
type NumBytesInRAM    = NumLinesInRAM * 16
type RAMLine          = Unsigned (BytesPerRAMLine * 8)
type RAMAddr          = Unsigned RAMAddrWidth