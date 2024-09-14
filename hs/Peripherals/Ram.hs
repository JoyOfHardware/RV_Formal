module Peripherals.Ram(
  Ram,
  numBytesInRam,
  initRamFromFile,
  Peripherals.Ram.read
) where

import Clash.Prelude
import qualified Prelude as P
import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get ( getInt32le, runGet, isEmpty )
import Data.Int (Int32, Int8)
import qualified Clash.Sized.Vector as Vec

import IOTransactionTypes(Request(..), Response(..), Error (..))
import Types(Addr, Byte, HalfWord, FullWord, DoubleWord, QuadWord)
import Util(fullWordsToQuadWords,
            unsigned128ToBytes,
            unsigned128ToHalfWords,
            unsigned128ToFullWords,
            unsigned128ToDoubleWords,
            mkLittleEndian
            )
import Data.Binary (Word8)
import Data.Data (Proxy(..))
import Peripherals.RamConfig( RAMAddrWidth,
                              BytesPerRAMLine,
                              LineAddrWidth,
                              NumLinesInRAM,
                              NumBytesInRAM,
                              RAMLine,
                              RAMAddr
                            )

type Ram = Vec NumLinesInRAM RAMLine


numBytesInRam :: Unsigned 64
numBytesInRam = fromIntegral $ natVal (Proxy @NumBytesInRAM)

ramDepth :: Int
ramDepth = fromIntegral $ natVal (Proxy @NumLinesInRAM)

lineAddrWidth :: Int
lineAddrWidth = fromIntegral $ natVal (Proxy @LineAddrWidth)

readRamLine :: RAMAddr -> Ram -> RAMLine
readRamLine addr ram = ramLine
  where
    ramLineAddr = addr `shiftR` lineAddrWidth
    ramLine = ram !! ramLineAddr

read :: Request RAMAddr -> Ram -> Resp
read req ram =
  if aligned then 
    case respVal of
      RespByte byte             -> RespByte       $ mkLittleEndian byte
      RespHalfWord halfWord     -> RespHalfWord   $ mkLittleEndian halfWord
      RespFullWord fullWord     -> RespFullWord   $ mkLittleEndian fullWord
      RespDoubleWord doubleWord -> RespDoubleWord $ mkLittleEndian doubleWord
      RespQuadWord quadWord     -> RespQuadWord   $ mkLittleEndian quadWord
      RespError _               -> respVal
  else 
    RespError UnAligned
  where
    (respVal, aligned, endian) = case req of
      ReqByte addr endian -> (RespByte byteVal, aligned, endian)
        where
          ramLine         = readRamLine addr ram
          aligned         = True
          byteIndexInLine = slice d3 d0 addr
          byteVal         = unsigned128ToBytes ramLine !! byteIndexInLine

      ReqHalfWord addr endian -> (RespHalfWord halfWordVal, aligned, endian)
        where
          ramLine             = readRamLine addr ram
          aligned             = slice d0 d0 addr == 0
          halfWordIndexInLine = slice d3 d1 addr
          halfWordVal         =
            unsigned128ToHalfWords ramLine !! halfWordIndexInLine

      ReqFullWord addr endian -> (RespFullWord fullWordVal, aligned, endian)
        where
          ramLine             = readRamLine addr ram
          aligned             = slice d1 d0 addr == 0
          fullWordIndexInLine = slice d3 d2 addr
          fullWordVal         =
            unsigned128ToFullWords ramLine !! fullWordIndexInLine

      ReqDoubleWord addr endian -> (RespDoubleWord doubleWordVal, aligned, endian)
        where
          ramLine               = readRamLine addr ram
          aligned               = slice d2 d0 addr == 0
          doubleWordIndexInLine = slice d2 d2 addr
          doubleWordVal         =
            unsigned128ToDoubleWords ramLine !! doubleWordIndexInLine

      ReqQuadWord addr endian -> (RespQuadWord $ readRamLine addr ram, aligned, endian)
        where
          aligned = slice d3 d0 addr == 0

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