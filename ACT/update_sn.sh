#!/bin/bash

# Input file
YAML_FILE="hca-cvaas-topology-no-ztp.yml"

# Counter for server numbering
counter=1

# Read through each matching line and replace in-place
while IFS= read -r line; do
  if [[ "$line" =~ ^[[:space:]]*serial_number: ]]; then
    # Extract existing value (strip leading spaces before key)
    existing_value=$(echo "$line" | sed 's/^[[:space:]]*serial_number:[[:space:]]*//')

    # Build the new prefix (SERVER001, SERVER002, etc.)
    prefix=$(printf "SERVER%03d" "$counter")

    # Escape any special characters in the existing value for use in sed
    escaped_value=$(printf '%s\n' "$existing_value" | sed 's/[[\.*^$()+?{|]/\\&/g')

    # Replace the value in the file, preserving leading whitespace
    sed -i '' "s/^\([[:space:]]*serial_number:[[:space:]]*\)${escaped_value}/\1${prefix}_${escaped_value}/" "$YAML_FILE"

    ((counter++))
  fi
done <"$YAML_FILE"
