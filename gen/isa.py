import pandas as pd
import re
from pathlib import Path

script_path = Path(__file__).resolve().parent
script_dir = script_path.parent


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

def is_consecutive(l):
    # makes sure all elements in list are consecutive integers
    diff = [(lhs - rhs) == 1 for lhs,rhs in zip(l[1:],l[:-1])]
    for el in diff:
        if not el:
            return False
    
    return True


def convert_to_forms_with_fields(instruction_forms_df):
    forms_v_fields = {}
    forms_with_split_fields = []
    for index, form in enumerate(instruction_forms_df.Format):
        forms_v_fields[form]={}
        
        for field in instruction_forms_df.iloc[index, 1:].unique():
            
            # skip 'dots', 'PO' which is the opcode field, or 'XO' 
            # which is extended opcode
            if field in {'.', 'PO'}:
                continue

            bit_list = (instruction_forms_df.columns[instruction_forms_df.iloc[index, :] == field]).tolist()
            if is_consecutive(bit_list):
                forms_v_fields[form][field] = (bit_list[0], bit_list[-1])
            
            else:
                forms_with_split_fields += [form]
    
    return forms_v_fields


def canonicalize_bitpat(bitpat):
    return bitpat.replace(' ', '').replace('/', '.')

isa_packed_filename = script_path/'tables/isa.csv'
instruction_forms_filename = script_path/'tables/instruction_forms.xlsx'

instruction_forms_df = pd.read_excel(
    instruction_forms_filename,
    sheet_name='instruction_forms'
    ).fillna(method='ffill', axis=1)
forms_v_fields = convert_to_forms_with_fields(instruction_forms_df)
isa_packed_df = pd.read_csv(isa_packed_filename)

# canonicalize names so that we can generate valid and
# clean Haskell identifiers
isa_packed_df['Mnemonic'] = isa_packed_df['Mnemonic'].apply(canonicalize_mnemonic)
isa_packed_df['bitpat']   = isa_packed_df['bitpat'].apply(canonicalize_bitpat)