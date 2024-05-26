{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module FetchResp(fetchInstructionResp) where

import Clash.Prelude
import Types(Mem, Insn, Addr)
import MachineMode(Endian(..), getEndian)
import RegFiles(MSR)
import Util(endianSwap)
import IOTransactionTypes(Request(..), Resp(..))

fetchInstructionResp :: Resp -> MSR -> Insn
fetchInstructionResp busResponse msr = insn
  where
    insn =  case busResponse of
              RespFullWord word -> word
              _                 -> undefined