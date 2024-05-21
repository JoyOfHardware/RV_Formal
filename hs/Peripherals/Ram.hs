{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module Peripherals.Ram(
  Ram,
  ramDepth,
  initRamFromFile,
) where

import Clash.Prelude
import qualified Prelude as P
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get
import Data.Int (Int32)
import qualified Clash.Sized.Vector as Vec
import Bus(Request(..), Resp(..))
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)

-- vector depth has to be known statically at compile time
#ifndef _RAM_DEPTH
#define _RAM_DEPTH 1024
#endif

-- TODO : replace Unsigned 32 with BusVal types later...
type Ram = Vec _RAM_DEPTH (Unsigned 32)

ramDepth :: Int
ramDepth = _RAM_DEPTH

ramWidth :: Int
ramWidth = 32

-- read :: Request -> Ram -> Resp
-- read request ram = 
--   case request of
--     ReqByte addr -> RespByte $ ram Vec.!! (fromIntegral addr)
--     ReqHalfWord addr -> RespHalfWord $ ram Vec.!! (fromIntegral addr)
--     ReqWord addr -> RespWord $ ram Vec.!! (fromIntegral addr)

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
