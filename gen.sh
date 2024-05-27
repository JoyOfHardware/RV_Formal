set -ex

# dependencies
# TODO : re-enable the following
# python3 -m venv .env
# source .env/bin/activate
# pushd hs_gen
# pip3 install -r requirements.txt
# popd

# generate
rm -rf out
mkdir -p out
python3 -m py.gen_json.gen_forms_and_field_mappings_json out
python3 -m py.gen_hs.extract_opcodes_to_haskell ./hs/Decode/Opcodes.hs
python3 -m py.gen_hs.extract_bitpat_to_haskell ./hs/Decode/BitpatsToOpcodes.hs
python3 -m py.gen_hs.generate_forms ./out/forms_v_fields.json  ./hs/Decode/Forms.hs
python3 -m py.gen_hs.generate_fields ./out/field_v_slice.json  ./hs/Decode/Fields.hs
python3 -m py.gen_hs.generate_opcodeToForms ./hs/Decode/OpcodeToForm.hs
python3 -m py.gen_hs.extract_fields ./out/field_v_slice.json ./hs/Decode/ExtractField.hs
python3 -m py.gen_hs.generate_form_to_fields ./out/forms_v_fields.json hs/Decode/FormToField.hs