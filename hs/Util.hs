{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Util(
  powerIndex32,
  powerIndex64,
  endianSwapWord,
  unsigned128ToBytes,
  unsigned128ToWords,
  unsigned128ToDoubleWords,
  fullWordsToQuadWords) where

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

unsigned128ToBytes :: Unsigned 128 -> Vec 16 (Unsigned 8)
unsigned128ToBytes = bitCoerce

unsigned128ToHalfWords :: Unsigned 128 -> Vec 8 (Unsigned 16)
unsigned128ToHalfWords = bitCoerce

unsigned128ToWords :: Unsigned 128 -> Vec 4 (Unsigned 32)
unsigned128ToWords = bitCoerce

unsigned128ToDoubleWords :: Unsigned 128 -> Vec 2 (Unsigned 64)
unsigned128ToDoubleWords = bitCoerce

fullWordsToQuadWords :: KnownNat n => Vec (n * 4) (Unsigned 32) -> Vec n (Unsigned 128)
fullWordsToQuadWords = bitCoerce

printHex128 :: Unsigned 128 -> String
printHex128 x = printf "0x%032x" (toInteger x)

printHex64 :: Unsigned 64 -> String
printHex64 x = printf "0x%016x" (toInteger x)

printHex32 :: Unsigned 32 -> String
printHex32 x = printf "0x%08x" (toInteger x)

printHex16 :: Unsigned 16 -> String
printHex16 x = printf "0x%04x" (toInteger x)

printHex8 :: Unsigned 8 -> String
printHex8 x = printf "0x%02x" (toInteger x)