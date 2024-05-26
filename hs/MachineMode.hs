module MachineMode(Endian(..), getEndian) where

import Clash.Prelude
import RegFiles(MSR)

data Endian = Big | Little
  deriving (Generic, Show, Eq, NFDataX)

-- | Defined on page 946 of POWER 3.0 ISA
getEndian :: MSR -> Endian
getEndian msrVal = 
  let
    endianBit = pack msrVal ! 0
  in
    if endianBit == 1 then Little else Big