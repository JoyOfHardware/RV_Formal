{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Decode(someMem) where

import Clash.Prelude
import Control.Monad.State

import Clash.Sized.Vector (Vec(..))
import Clash.Sized.BitVector (BitVector)

-- currently memory is only 8 words deep
someMem :: [Unsigned 32]
someMem = [
  0x1,
  2,
  3,
  4,
  5]
