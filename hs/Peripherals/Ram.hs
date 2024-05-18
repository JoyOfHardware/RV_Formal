{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Peripherals.Ram() where

import Clash.Prelude
import qualified Prelude as P
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get
import Data.Int (Int32)
import qualified Clash.Sized.Vector as Vec

-- vector depth has to be known statically at compile time
#ifndef _RAM_DEPTH
#define _RAM_DEPTH 1024
#endif

-- TODO : replace Unsigned 32 with BusVal types later...
type Ram = Vec _RAM_DEPTH (Unsigned 32)

initRamFromFile :: FilePath -> IO (Maybe Ram)
initRamFromFile filePath = 
    let
      initRam = Vec.replicate (SNat :: SNat _RAM_DEPTH) 0
    in
      do
      bs <- readFileIntoByteString filePath
      let ints = getInts bs
      pure $ populateVectorFromInt32 ints initRam

readFileIntoByteString :: FilePath -> IO BL.ByteString
readFileIntoByteString filePath = BL.readFile filePath

-- Define a function to read a ByteString and convert to [Int32]
getInts :: BL.ByteString -> [Int32]
getInts bs = runGet listOfInts bs
  where
    listOfInts = do
      empty <- isEmpty
      if empty
        then pure []
      else do
        i <- getInt32le    -- Parse a single Int32 from the stream
        rest <- listOfInts -- Recursively parse the rest
        pure (i : rest)

-- Adjusts the length of a list of integers by either truncating or padding with zeros
populateVectorFromInt32 :: 
    KnownNat n =>
    [Int32] -> 
    Vec n (Unsigned 32) -> 
    Maybe (Vec n (Unsigned 32))
populateVectorFromInt32 ls v = Vec.fromList adjustedLs
  where
    vecLen = length v
    adjustedLs = fromIntegral <$> adjustLength vecLen ls
    adjustLength :: Int -> [Int32] -> [Int32]
    adjustLength n xs = P.take n (xs P.++ P.repeat 0)



-- Function to increment each element of a Clash vector
-- prepareVector :: KnownNat n => [Int32] -> Vec n (Unsigned 32)
-- prepareVector xs = let
--   unsigneds = map (fromIntegral :: Int32 -> Unsigned 32) xs  -- Step 1: Convert Int32 to Unsigned 32
--   len = length unsigneds
--   in case compare len (snatToNum (SNat @n)) of  -- Step 2: Adjust the length of the list
--       LT -> takeI unsigneds ++ repeat 0  -- Pad with zeros if the list is shorter
--       GT -> takeI unsigneds  -- Truncate if the list is longer
--       EQ -> takeI unsigneds  -- No padding or truncation needed

-- Function to load firmware
-- loadFirmware :: KnownNat n => [Int32] -> Vec n (Unsigned 32)
-- loadFirmware (x:xs) = vecHead ++ vecTail
--     where
--         vecHead = singleton (fromIntegral x)
--         vecTail = loadFirmware xs
-- loadFirmware [] = takeI $ repeat 0

-- loadFirmware xs = v 
--     where 
--         mapped :: [Unsigned 32] = Clash.Prelude.fromIntegral <$> xs
--         c = takeI (mapped ++ repeat 0)
--         v = takeI $ (mapped ++ repeat 0)

-- -- Example usage
-- someList :: [Int32]
-- someList = [1, 2, 3, 4, 5]

-- mem :: Vec 16 (Unsigned 32)
-- mem = loadFirmware someList