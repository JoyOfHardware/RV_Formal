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

import Machine(Endian(..))
import Bus(Request(..), Resp(..))
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)
import Util(fullWordsToQuadWords, Log2,
            unsigned128ToBytes, 
            unsigned128ToHalfWords,
            unsigned128ToFullWords,
            unsigned128ToDoubleWords,
            endianSwap
            )
import Data.Binary (Word8)
import Bus(Request(..), Resp(..))
import Data.Data (Proxy(..))

#ifndef _RAM_ADDR_WIDTH
#define _RAM_ADDR_WIDTH 10
#endif

-- Define type-level constants
type RAMAddrWidth     = _RAM_ADDR_WIDTH
type BytesPerRAMLine  = 16
type LineAddrWidth    = Util.Log2 BytesPerRAMLine
type NumLinesInRAM    = 2 ^ RAMAddrWidth
type NumBytesInRAM    = NumLinesInRAM * 16
type RAMLine          = Unsigned (BytesPerRAMLine * 8)

type RAMAddr          = Unsigned RAMAddrWidth

type Ram = Vec NumLinesInRAM RAMLine

ramDepth :: Int
ramDepth = fromIntegral $ natVal (Proxy @NumLinesInRAM)

lineAddrWidth :: Int
lineAddrWidth = fromIntegral $ natVal (Proxy @LineAddrWidth)

ramWidth :: Int
ramWidth = 128

o :: Unsigned 32 = complement 0


readRamLine :: RAMAddr -> Ram -> RAMLine
readRamLine addr ram = ramLine
  where
    ramLineAddr = addr `shiftR` lineAddrWidth
    ramLine = ram !! ramLineAddr

read :: Request RAMAddr -> Endian -> Ram -> Resp
read req endian ram = 
  case endian of
    Big -> respVal
    Little -> case respVal of
      RespByte byte -> RespByte $ endianSwap byte
      RespHalfWord halfWord -> RespHalfWord $ endianSwap halfWord
      RespFullWord fullWord -> RespFullWord $ endianSwap fullWord
      RespDoubleWord doubleWord -> RespDoubleWord $ endianSwap doubleWord
  where
    respVal = case req of
      ReqByte addr -> 
          let
              shftAmt = 0
              ramLine = readRamLine addr ram
              byteMask :: Unsigned LineAddrWidth = complement 0
              byteIndexInLine :: Unsigned LineAddrWidth = 
                  resize ((addr `shiftR` shftAmt) .&. resize byteMask)
              byteVal = (unsigned128ToBytes ramLine) !! byteIndexInLine
          in
              RespByte byteVal
      ReqHalfWord addr ->
          let
              shftAmt = 1
              ramLine = readRamLine addr ram
              halfWordMask :: Unsigned (LineAddrWidth - 1) = complement 0
              halfWordIndexInLine :: Unsigned (LineAddrWidth - 1) = 
                  resize ((addr `shiftR` shftAmt) .&. resize halfWordMask)
              halfWordVal = (unsigned128ToHalfWords ramLine) !! halfWordIndexInLine
          in
              RespHalfWord halfWordVal
      ReqFullWord addr ->
          let
              shftAmt = 2
              ramLine = readRamLine addr ram
              fullWordMask :: Unsigned (LineAddrWidth - 2) = complement 0
              fullWordIndexInLine :: Unsigned (LineAddrWidth - 2) = 
                  resize ((addr `shiftR` shftAmt) .&. resize fullWordMask)
              fullWordVal = (unsigned128ToFullWords ramLine) !! fullWordIndexInLine
          in
              RespFullWord fullWordVal
      ReqDoubleWord addr ->
          let
              shftAmt = 3
              ramLine = readRamLine addr ram
              doubleWordMask :: Unsigned (LineAddrWidth - 3) = complement 0
              doubleWordIndexInLine :: Unsigned (LineAddrWidth - 3) = 
                  resize ((addr `shiftR` shftAmt) .&. resize doubleWordMask)
              doubleWordVal = (unsigned128ToDoubleWords ramLine) !! doubleWordIndexInLine
          in
              RespDoubleWord doubleWordVal

      -- ReqQuadWord addr ->
      --     let
      --         shftAmt = 4
      --         ramLine = readRamLine addr ram
      --         quadWordMask :: Unsigned (LineAddrWidth - 4) = complement 0
      --         quadWordIndexInLine :: Unsigned (LineAddrWidth - 4) = 
      --             resize ((addr `shiftR` shftAmt) .&. resize quadWordMask)
      --         quadWordVal = (unsigned128ToQuadWords ramLine) !! quadWordIndexInLine
      --     in
      --         RespQuadWord quadWordVal

initRamFromFile :: FilePath -> IO (Maybe Ram)
initRamFromFile filePath = 
    let
      zeroedRamVec8 = Vec.replicate (SNat :: SNat NumBytesInRAM) (0 :: Unsigned 8)
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