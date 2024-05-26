module Bus(Bus.read, write) where

import Clash.Prelude

import IOTransactionTypes(Request(..), Resp(..), Error(..))
import Peripherals.Ram(Ram, read, numBytesInRam)
import VirtualToReal(virtualToReal)
import MachineMode(Endian(..))
import Machine(Peripherals(..))
import Types(Addr)

read :: Request Addr -> Peripherals -> Resp
read req peripherals
  | (realAddr > 0) && (realAddr < numBytesInRam) =  Peripherals.Ram.read 
                                                (resize <$> req)
                                                endian
                                                (ram peripherals)
  | otherwise                            =  RespError UnMapped
  where
    realAddr = virtualToReal addr
    (addr, endian) = case req of
      ReqHalfWord   a endian  -> (a, endian)
      ReqFullWord   a endian  -> (a, endian)
      ReqDoubleWord a endian  -> (a, endian)
      ReqQuadWord   a endian  -> (a, endian)
    val = 3

write = 4