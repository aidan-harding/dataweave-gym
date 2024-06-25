import json
import random
import sys
import os
from datetime import datetime

def is_email(value):
    """Check if the value is an email address."""
    return '@' in value and '.' in value

def is_date(value):
    """Check if the value is a date in yyyy-mm-dd format."""
    try:
        datetime.strptime(value, "%Y-%m-%d")
        return True
    except ValueError:
        return False

def modify_value(value, null_probability):
    """Modify the value based on the null probability."""
    if random.random() < null_probability:
        return None

    if value is None or value == '':
        return value

    if is_email(value):
        local, domain = value.split('@')
        local = ''.join(random.choices(local, k=len(local)))
        return f"{local}@{domain}"
    elif is_date(value):
        return datetime.strftime(datetime.fromordinal(random.randint(1, datetime.now().toordinal())), "%Y-%m-%d")
    else:
        return ''.join(random.choices(value, k=len(value)))

def modify_json(input_file, output_file, row_probability, field_probability, null_probability):
    """Read the input JSON file, modify it, and write to the output JSON file."""
    with open(input_file, 'r', encoding='utf-8') as infile:
        data = json.load(infile)

    modified_data = []
    for row in data:
        if random.random() < row_probability:
            new_row = {key: modify_value(value, null_probability) if random.random() < field_probability else value for key, value in row.items()}
        else:
            new_row = row
        modified_data.append(new_row)

    with open(output_file, 'w', encoding='utf-8') as outfile:
        json.dump(modified_data, outfile, ensure_ascii=False, indent=4)

if __name__ == "__main__":
    if len(sys.argv) != 6:
        print("Usage: python modify_json.py <input_file> <output_file> <row_probability> <field_probability> <null_probability>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    row_probability = float(sys.argv[3])
    field_probability = float(sys.argv[4])
    null_probability = float(sys.argv[5])

    if not os.path.isfile(input_file):
        print(f"Error: Input file '{input_file}' does not exist.")
        sys.exit(1)

    modify_json(input_file, output_file, row_probability, field_probability, null_probability)
