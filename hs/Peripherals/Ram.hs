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
import Data.Int (Int32, Int8)
import qualified Clash.Sized.Vector as Vec
import Bus(Request(..), Resp(..))
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)
import Util(fullWordsToQuadWords)
import Data.Binary (Word8)

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
      zeroedRamVec8 = Vec.replicate (SNat :: SNat (_RAM_DEPTH * 16)) (0 :: Unsigned 8)
    in
      do
        bs <- readFileIntoByteString filePath
        let int8List = zeroPadMkLengthMultipleOf16 $ byteStringToInt8List bs
        let initRamVec8 = populateVectorFromInt8s int8List zeroedRamVec8
        pure $ case initRamVec8 of
          Just vec8 -> Just $ bitCoerce vec8
          Nothing -> Nothing

readFileIntoByteString :: FilePath -> IO BL.ByteString
readFileIntoByteString filePath = BL.readFile filePath

byteStringToInt8List :: BL.ByteString -> [Int8]
byteStringToInt8List bs = P.map (fromIntegral :: Word8 -> Int8) (BL.unpack bs)

populateVectorFromInt8s :: 
    KnownNat n =>
    [Int8] -> 
    Vec n (Unsigned 8) -> 
    Maybe (Vec n (Unsigned 8))
populateVectorFromInt8s ls v = Vec.fromList adjustedLs
  where
    vecLen = length v
    adjustedLs = fromIntegral <$> adjustLength vecLen ls
    adjustLength :: Int -> [Int8] -> [Int8]
    adjustLength n xs = P.take n (xs P.++ P.repeat 0)

zeroPadMkLengthMultipleOf16 :: [Int8] -> [Int8]
zeroPadMkLengthMultipleOf16 xs = xs P.++ (P.replicate padding 0)
  where
    len = P.length xs
    padding = if multipleOf16 then 0 else 16 - remainder
    remainder = len `mod` 16
    multipleOf16 = remainder == 0