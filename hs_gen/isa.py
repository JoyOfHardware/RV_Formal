import pandas as pd
import re

def canonicalize_mnemonic(mnemonic):
    replacements = {
        r'\[\.\]': 'Dot',
        r'\[o\]': 'FlagO',
        r'\[l\]': 'FlagLink',
        r'\[a\]': 'FlagAbsolute',
        r'\[x\]': 'FlagInExact',
        r'\.': 'Dot'
    }

    for pattern, replacement in replacements.items():
        mnemonic = re.sub(pattern, replacement, mnemonic)

    mnemonic = mnemonic[0].upper() + mnemonic[1:]
    return mnemonic

def canonicalize_bitpat(bitpat):
    return bitpat.replace(' ', '').replace('/', '.')

isa_packed_filename = 'isa.csv'
instruction_forms_filename = 'instruction_forms.xlsx'

instruction_forms_df = pd.read_excel(
    instruction_forms_filename,
    sheet_name='instruction_forms'
    ).fillna(method='ffill', axis=1)
isa_packed_df = pd.read_csv(isa_packed_filename)

# canonicalize names so that we can generate valid and
# clean Haskell identifiers
isa_packed_df['Mnemonic'] = isa_packed_df['Mnemonic'].apply(canonicalize_mnemonic)
isa_packed_df['bitpat']   = isa_packed_df['bitpat'].apply(canonicalize_bitpat)