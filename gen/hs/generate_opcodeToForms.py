import sys
import isa

mnemonic_form_pairs = list(zip(isa.isa_packed_df.Mnemonic, isa.isa_packed_df.FORMAT))
opcodes = []

for mnemonic, form in mnemonic_form_pairs:
    opcodes += [f"opcodeToForm {mnemonic:<23} = {form} Unpopulated"]

generated_hs = \
f'''{{-# LANGUAGE DataKinds #-}}
{{-# LANGUAGE NumericUnderscores #-}}

module OpcodeToForm(opcodeToForm) where
import Clash.Prelude
import Opcodes(Opcode(..))
import Forms(
    Form(..),
    FormState (Unpopulated))
import Util(powerIndex32, powerIndex64)

{'\n'.join(opcodes)}
'''

with open(sys.argv[1], 'w') as f:
    f.write(generated_hs)