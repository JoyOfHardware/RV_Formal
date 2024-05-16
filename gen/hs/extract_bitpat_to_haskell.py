import sys
from .. import isa

decode = []
for bitpat, mnemonic in zip(isa.isa_packed_df.bitpat, isa.isa_packed_df.Mnemonic):
    decode += [f'decode $(bitPattern "{bitpat}") = Just {mnemonic}']

generated_hs = \
f'''{{-# LANGUAGE RecordWildCards #-}}
{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Decode(decode) where

import Clash.Prelude
import Opcodes(Opcode(..))

decode :: Unsigned 32 -> Maybe Opcode
{'\n'.join(decode)}
decode _ = Nothing
'''

# Let's create an write out Haskell file to the second argument
with open(sys.argv[1], 'w') as f:
    f.write(generated_hs)