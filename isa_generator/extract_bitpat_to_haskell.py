# We have a CSV spreadsheet of the POWER PC ISA with the folloing first three columns:
# Number, Mnemonic,	opcode
# Column 18 is page number that the mnemonic is defined on.

# First, lets open the CSV file, which is the first argument
import sys
import csv
import re

with open(sys.argv[1]) as f:
    reader = csv.reader(f)

    opcode_bitpatterns = []
    mnemonics = []
    pages = []
    for row in reader:
        # Next, lets collect all the opcodes bitpatterns
        # as well as mnemonics
        opcode_bitpatterns.append(row[2])
        mnemonics.append(row[1])
        # collects page numbers
        pages.append(row[18])

    # the first entry in opcode_bitpatterns is simply 'opcode'
    # we will remove it
    opcode_bitpatterns.pop(0)
    mnemonics.pop(0)
    pages.pop(0)

# we need to:
# 1. remove any spaces in the opcode_bitpatterns
# 2. replace all '/' characters with '.'
for i in range(len(opcode_bitpatterns)):
    opcode_bitpatterns[i] = opcode_bitpatterns[i].replace(' ', '')
    opcode_bitpatterns[i] = opcode_bitpatterns[i].replace('/', '.')

# Now the first two entries in opcode_bitpatterns might look like:
# ['111111....................11101.', '111011....................11101.']

# Now let's go ahead and prep all the mnemonics

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

# We want our final haskell file to look something like
# the following:
# {-# LANGUAGE RecordWildCards #-}
# {-# LANGUAGE DataKinds #-}
# {-# LANGUAGE NumericUnderscores #-}
# 
# module Decode(decode) where
# 
# import Clash.Prelude
# import Opcodes(Opcode(..))
# 
# decode :: Unsigned 32 -> Maybe Opcode
# decode $(bitPattern "111111....................11101.") = Just FmaddDot
# -- rest of our decode patterns to match inserted here
# decode _ = Nothing

prelude = \
'''{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE NumericUnderscores #-}

module Decode(decode) where

import Clash.Prelude
import Opcodes(Opcode(..))

'''

# Let's create an write out Haskell file to the second argument
with open(sys.argv[2], 'w') as f:
    f.write(prelude)
    f.write(f"decode :: Unsigned 32 -> Maybe Opcode\n")
    for opcode_bitpattern, mnemonic in zip(opcode_bitpatterns, mnemonics):
        f.write(f"decode $(bitPattern \"{opcode_bitpattern}\") = Just {mnemonic}\n")
    f.write(f"decode _ = Nothing\n\n")