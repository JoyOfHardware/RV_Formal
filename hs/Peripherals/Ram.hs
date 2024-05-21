{-# LANGUAGE CPP #-}

module Peripherals.Ram(
  Ram,
  ramDepth,
  initRamFromFile,
) where

import Clash.Prelude
import qualified Prelude as P
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get ( getInt32le, runGet, isEmpty )
import Data.Int (Int32)
import qualified Clash.Sized.Vector as Vec
import Bus(Request(..), Resp(..))
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)
import Util(fullWordsToQuadWords)

#ifndef _RAM_DEPTH
#define _RAM_DEPTH 1024
#endif

-- TODO : replace Unsigned 32 with BusVal types later...
type Ram = Vec _RAM_DEPTH (Unsigned 128)

ramDepth :: Int
ramDepth = _RAM_DEPTH

ramWidth :: Int
ramWidth = 128

initRamFromFile :: FilePath -> IO (Maybe Ram)
initRamFromFile filePath = 
    let
      zeroedRamVec32 = Vec.replicate (SNat :: SNat (_RAM_DEPTH * 4)) 0
    in
      do
        bs <- readFileIntoByteString filePath
        let int32s = zeroPadMkLengthMultipleOfFour $ byteStringToInt32s bs
        let initRamVec32 = populateVectorFromInt32s int32s zeroedRamVec32
        pure $ case initRamVec32 of
          Just vec32 -> Just (fullWordsToQuadWords vec32)
          Nothing -> Nothing

readFileIntoByteString :: FilePath -> IO BL.ByteString
readFileIntoByteString filePath = BL.readFile filePath

byteStringToInt32s :: BL.ByteString -> [Int32]
byteStringToInt32s bs = runGet listOfInts bs
  where
    listOfInts = do
      empty <- isEmpty
      if empty
        then pure []
      else do
        i <- getInt32le    -- Parse a single Int32 from the stream
        rest <- listOfInts -- Recursively parse the rest
        pure (i : rest)

populateVectorFromInt32s :: 
    KnownNat n =>
    [Int32] -> 
    Vec n (Unsigned 32) -> 
    Maybe (Vec n (Unsigned 32))
populateVectorFromInt32s ls v = Vec.fromList adjustedLs
  where
    vecLen = length v
    adjustedLs = fromIntegral <$> adjustLength vecLen ls
    adjustLength :: Int -> [Int32] -> [Int32]
    adjustLength n xs = P.take n (xs P.++ P.repeat 0)

zeroPadMkLengthMultipleOfFour :: [Int32] -> [Int32]
zeroPadMkLengthMultipleOfFour xs = xs P.++ (P.replicate padding 0)
  where
    len = P.length xs
    padding = (4 - (len `mod` 4)) `mod` 4