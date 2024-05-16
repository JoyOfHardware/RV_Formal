import json
import sys
from .. import isa
from pathlib import Path

outdir = Path(sys.argv[1])

def process_ranges_with_mapping(input_dict):
    label_counters = {}
    output_dict = {}
    mapping_dict = {}

    for key, sub_dict in input_dict.items():
        output_dict[key] = []
        for label, range_tuple in sub_dict.items():
            if label not in label_counters:
                label_counters[label] = {}
            if range_tuple not in label_counters[label]:
                label_counters[label][range_tuple] = len(label_counters[label]) + 1
            numbered_label = f"{label}_{label_counters[label][range_tuple]}"
            output_dict[key].append(numbered_label)
            mapping_dict[numbered_label] = range_tuple
    
    return output_dict, mapping_dict

forms_v_fields, field_to_slice_mapping = process_ranges_with_mapping(isa.forms_v_fields)

def convert_tuple_to_list(data):
    if isinstance(data, dict):
        return {key: convert_tuple_to_list(value) for key, value in data.items()}
    elif isinstance(data, tuple):
        return list(data)
    else:
        return data

field_to_slice_mapping = convert_tuple_to_list(field_to_slice_mapping)

print(f"{len(forms_v_fields.items())} forms")
print(f"{len(field_to_slice_mapping.items())} fields")

with open(outdir/'forms_v_fields.json', 'w') as json_file:
    json.dump(forms_v_fields, json_file, indent=4)

with open(outdir/'field_v_slice.json', 'w') as json_file:
    json.dump(field_to_slice_mapping, json_file, indent=4)