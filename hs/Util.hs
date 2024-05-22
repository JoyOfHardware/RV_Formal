{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE UndecidableInstances #-}

module Util(
  Util.Log2,
  powerIndex32,
  powerIndex64,
  endianSwapWord,
  unsigned128ToBytes,
  unsigned128ToHalfWords,
  unsigned128ToFullWords,
  unsigned128ToDoubleWords,
  fullWordsToQuadWords,
  showHex128,
  showHex64,
  showHex32,
  showHex16,
  showHex8) where

import Clash.Prelude
import Types(FullWord)
import Text.Printf (printf)

data ValidIndex32Bit (n :: Nat) where
  ValidIndex32Bit :: (0 <= n, n <= 31) => SNat n -> ValidIndex32Bit n

mkValidIndex32 :: forall n. (KnownNat n, 0 <= n, n <= 31) => ValidIndex32Bit n
mkValidIndex32 = ValidIndex32Bit $ SNat @n

powerIndex32 :: forall n. (KnownNat n, 0 <= n, n <= 31) => SNat (31 - n)
powerIndex32 = case mkValidIndex32 @n of
  ValidIndex32Bit _ -> SNat @(31 - n)

data ValidIndex64Bit (n :: Nat) where
  ValidIndex64Bit :: (0 <= n, n <= 63) => SNat n -> ValidIndex64Bit n

mkValidIndex64 :: forall n. (KnownNat n, 0 <= n, n <= 63) => ValidIndex64Bit n
mkValidIndex64 = ValidIndex64Bit $ SNat @n

powerIndex64 :: forall n. (KnownNat n, 0 <= n, n <= 63) => SNat (63 - n)
powerIndex64 = case mkValidIndex64 @n of
  ValidIndex64Bit _ -> SNat @(63 - n)

endianSwapWord :: FullWord -> FullWord
endianSwapWord x = swappedWord
  where
    wordAsVecBytes = bitCoerce x :: Vec 4 (Unsigned 8)
    reversedVec = reverse wordAsVecBytes
    swappedWord = bitCoerce reversedVec :: FullWord

type family Log2 (n :: Nat) :: Nat where
  Util.Log2 1 = 0
  Util.Log2 2 = 1
  Util.Log2 n = 1 + Util.Log2 (Div n 2)

unsigned128ToBytes :: Unsigned 128 -> Vec 16 (Unsigned 8)
unsigned128ToBytes = bitCoerce

unsigned128ToHalfWords :: Unsigned 128 -> Vec 8 (Unsigned 16)
unsigned128ToHalfWords = bitCoerce

unsigned128ToFullWords :: Unsigned 128 -> Vec 4 (Unsigned 32)
unsigned128ToFullWords = bitCoerce

unsigned128ToDoubleWords :: Unsigned 128 -> Vec 2 (Unsigned 64)
unsigned128ToDoubleWords = bitCoerce

fullWordsToQuadWords :: KnownNat n => Vec (n * 4) (Unsigned 32) -> Vec n (Unsigned 128)
fullWordsToQuadWords = bitCoerce

showHex128 :: Unsigned 128 -> String
showHex128 x = printf "0x%032x" (toInteger x)

showHex64 :: Unsigned 64 -> String
showHex64 x = printf "0x%016x" (toInteger x)

showHex32 :: Unsigned 32 -> String
showHex32 x = printf "0x%08x" (toInteger x)

showHex16 :: Unsigned 16 -> String
showHex16 x = printf "0x%04x" (toInteger x)

showHex8 :: Unsigned 8 -> String
showHex8 x = printf "0x%02x" (toInteger x)