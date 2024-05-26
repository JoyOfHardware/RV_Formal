{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module FetchResp(fetchInstructionResp) where

import Clash.Prelude
import Types(Mem, Insn, Addr)
import MachineMode(Endian(..), getEndian)
import Util(endianSwap)
import IOTransactionTypes(Request(..), Resp(..))

fetchInstructionResp :: Resp -> Insn
fetchInstructionResp busResponse = insn
  where
    insn =  case busResponse of
              RespFullWord word -> word
              _                 -> undefined