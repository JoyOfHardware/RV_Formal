{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module FetchReq(fetchInstructionReq) where

import Clash.Prelude
import Types(Mem, Insn, Pc, Addr)
import MachineMode(Endian(..), getEndian)
import RegFiles(MSR)
import Util(endianSwap)
import IOTransactionTypes(Request(..), Resp(..))

fetchInstructionReq :: Pc -> MSR -> Request Addr
fetchInstructionReq programCounter msr =
  ReqFullWord programCounter endian
  where 
    endian = getEndian msr