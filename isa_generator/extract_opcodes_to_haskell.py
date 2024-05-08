# We have a CSV spreadsheet of the POWER PC ISA with the folloing first three columns:
# Number, Mnemonic,	opcode
# Column 18 is page number that the mnemonic is defined on.

# First, lets open the CSV file, which is the first argument
import sys
import csv
import re

with open(sys.argv[1]) as f:
    reader = csv.reader(f)

    mnemonics = []
    pages = []
    for row in reader:
        # Next, lets collect all the mnemonics
        mnemonics.append(row[1])
        # collects page numbers
        pages.append(row[18])

    # the first entry in mnemonics is simply 'Mnemonic', so
    # we will remove it
    mnemonics.pop(0)
    pages.pop(0)

# the first two entries in mnemonics might look like:
# ['fmadd[.]', 'fmadds[.]']

# Lets replace all instances of '[.]' with 'Dot'
# Also, let's capitalize the first letter of each mnemonic
# since haskell data variants must start with an uppercase letter.
for i in range(len(mnemonics)):
    curr_mnemonic = mnemonics[i]
    curr_mnemonic = re.sub(r'\[\.\]', 'Dot', curr_mnemonic)
    curr_mnemonic = re.sub(r'\[o\]', 'FlagO', curr_mnemonic)
    curr_mnemonic = re.sub(r'\[l\]', 'FlagLink', curr_mnemonic)
    curr_mnemonic = re.sub(r'\[a\]', 'FlagAbosolute', curr_mnemonic)
    curr_mnemonic = re.sub(r'\[x\]', 'FlagInExact', curr_mnemonic)
    curr_mnemonic = re.sub(r'\.', 'Dot', curr_mnemonic)
    curr_mnemonic = curr_mnemonic[0].upper() + curr_mnemonic[1:]
    mnemonics[i] = curr_mnemonic

# Now the first two entries in mnemonics might look like:
# ['fmaddDot', 'fmaddsDot']

# Now lets write out the haskell data variants to a haskell file.
# The content of the haskell file might look like:
# data Opcode 
#   = OpFmadddot 
#   | OpFmaddsdot 
#   | OpFmsubdot

clash_specific_headers = '''{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Opcodes(Opcode(..)) where
import Clash.Prelude

'''

with open(sys.argv[2], 'w') as f:
    f.write(clash_specific_headers)
    f.write("data Opcode \n")
    # Write the first mnemonic with right-aligned page numbers using string padding
    f.write(f"  = {mnemonics[0]:<23} -- page {pages[0]}\n")
    # Iterate through the rest of mnemonics
    for i, mnemonic in enumerate(mnemonics[1:], start=1):
        f.write(f"  | {mnemonic:<23} -- page {pages[i]}\n")
    f.write('  deriving (Generic, Show, Eq, NFDataX)')