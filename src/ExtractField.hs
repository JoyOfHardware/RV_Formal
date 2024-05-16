{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}


module ExtractField() where

import Clash.Prelude
import Fields(UnpopulatedField(..), PopulatedField(..))
import Util(powerIndex32)
import Types(Insn)

getFieldFrt_1 :: Insn -> Unsigned 5
getFieldFrt_1 insn = unpack $ slice (powerIndex32 @6) (powerIndex32 @10) insn


populateField :: UnpopulatedField -> Insn -> PopulatedField
populateField Unpopulated_Frt_1 insn = Populated_Frt_1 $ getFieldFrt_1 insn