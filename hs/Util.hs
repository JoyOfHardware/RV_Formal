{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Util(
  powerIndex32,
  powerIndex64,
  endianSwapWord) where

import Clash.Prelude
import Types(FullWord)

data ValidIndex32 (n :: Nat) where
  ValidIndex32 :: (0 <= n, n <= 31) => SNat n -> ValidIndex32 n

mkValidIndex32 :: forall n. (KnownNat n, 0 <= n, n <= 31) => ValidIndex32 n
mkValidIndex32 = ValidIndex32 $ SNat @n

powerIndex32 :: forall n. (KnownNat n, 0 <= n, n <= 31) => SNat (31 - n)
powerIndex32 = case mkValidIndex32 @n of
  ValidIndex32 _ -> SNat @(31 - n)

data ValidIndex63 (n :: Nat) where
  ValidIndex63 :: (0 <= n, n <= 63) => SNat n -> ValidIndex63 n

mkValidIndex64 :: forall n. (KnownNat n, 0 <= n, n <= 63) => ValidIndex63 n
mkValidIndex64 = ValidIndex63 $ SNat @n

powerIndex64 :: forall n. (KnownNat n, 0 <= n, n <= 63) => SNat (63 - n)
powerIndex64 = case mkValidIndex64 @n of
  ValidIndex63 _ -> SNat @(63 - n)

endianSwapWord :: FullWord -> FullWord
endianSwapWord x = 
  (byte0 `shiftL` 24) .|.
  (byte1 `shiftL` 16) .|.
  (byte2 `shiftL` 8)  .|.
  byte3
  where
    byte0 = (x .&. 0x000000FF)
    byte1 = (x .&. 0x0000FF00) `shiftR` 8
    byte2 = (x .&. 0x00FF0000) `shiftR` 16
    byte3 = (x .&. 0xFF000000) `shiftR` 24