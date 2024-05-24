module Bus(Bus.read, write) where

import Clash.Prelude

import IOTransactionTypes(Request(..), Resp(..), Error(..))
import Peripherals.Ram(Ram, read, numBytesInRam)
import VirtualToReal(virtualToReal)
import Machine(Endian(..))
import Types(Addr)

data Peripherals = Peripherals 
  {
      ram :: Ram
  }

read :: Request Addr -> Endian -> Peripherals -> Resp
read req endian peripherals
  | (addr > 0) && (addr < numBytesInRam) =  Peripherals.Ram.read 
                                                (resize <$> req)
                                                endian
                                                (ram peripherals)
  | otherwise                            =  RespError UnMapped
  where
    addr = virtualToReal $ case req of
      ReqHalfWord   a  -> a
      ReqFullWord   a  -> a
      ReqDoubleWord a  -> a
      ReqQuadWord   a  -> a
    val = 3

write = 4