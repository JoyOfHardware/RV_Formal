{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE ConstraintKinds #-}

module Util(
  powerIndex32,
  powerIndex64) where

import Clash.Prelude

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
