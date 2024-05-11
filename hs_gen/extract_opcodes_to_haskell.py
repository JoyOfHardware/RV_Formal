import sys
import isa

mnemonic_page_pairs = list(zip(isa.isa_packed_df.Mnemonic, isa.isa_packed_df.PAGE))
zipped_mnemonic_page_iterator = zip(isa.isa_packed_df.Mnemonic, isa.isa_packed_df.PAGE)
opcodes = []

for index, (mnemonic, page_no) in enumerate(zipped_mnemonic_page_iterator):
    if index == 0:
        opcodes += [f"  = {mnemonic:<23} -- page {page_no}"]
    else:
        opcodes += [f"  | {mnemonic:<23} -- page {page_no}"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module Opcodes(Opcode(..)) where
import Clash.Prelude

data Opcode
{'\n'.join(opcodes)}
  deriving (Generic, Show, Eq, NFDataX)
'''

with open(sys.argv[1], 'w') as f:
    f.write(generated_hs)