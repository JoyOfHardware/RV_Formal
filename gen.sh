set -ex

# dependencies
# python3 -m venv .env
# source .env/bin/activate
# pushd hs_gen
# pip3 install -r requirements.txt
# popd

# generate
rm -rf isa_json
mkdir -p isa_json
python3 -m gen.json.gen_forms_and_field_mappings_json isa_json
python3 -m gen.hs.extract_opcodes_to_haskell ./src/Decode/Opcodes.hs
python3 -m gen.hs.extract_bitpat_to_haskell ./src/Decode/BitpatsToOpcodes.hs
python3 -m gen.hs.generate_forms ./isa_json/forms_v_fields.json  ./src/Decode/Forms.hs
python3 -m gen.hs.generate_fields ./isa_json/field_v_slice.json  ./src/Decode/Fields.hs
python3 -m gen.hs.generate_opcodeToForms ./src/Decode/OpcodeToForm.hs
python3 -m gen.hs.extract_fields ./isa_json/field_v_slice.json ./src/Decode/ExtractField.hs