#!/bin/bash
function error_exit {
    echo "$1" >&2
    exit 1
}
function validate_input {
    local input="$1"
    local options=("$@")
    for option in "${options[@]:1}"; do
        if [[ "$input" == "$option" ]]; then
            return 0
        fi
    done
    return 1
}
read -p "Enter Component Name [INGESTOR/JOINER/WRANGLER/VALIDATOR]: " component
validate_input "$component" "INGESTOR" "JOINER" "WRANGLER" "VALIDATOR" || error_exit "Invalid Component Name."
read -p "Enter Scale [MID/HIGH/LOW]: " scale
validate_input "$scale" "MID" "HIGH" "LOW" || error_exit "Invalid Scale."
read -p "Enter View [Auction/Bid]: " view
validate_input "$view" "Auction" "Bid" || error_exit "Invalid View."
read -p "Enter Count [single digit number]: " count
if ! [[ "$count" =~ ^[0-9]$ ]]; then
    error_exit "Invalid Count. Please enter a single digit number."
fi
if [[ "$view" == "Auction" ]]; then
    view_value="vdopiasample"
else
    view_value="vdopiasample-bid"
fi
new_line="$view_value ; $scale ; $component ; ETL ; vdopia-etl= $count"
conf_file="sig.conf"
echo "Contents of $conf_file:"
cat "$conf_file"
match_pattern="^$view_value ; $scale ; .* ; ETL ; vdopia-etl= [0-9]$"
echo "Searching for pattern: $match_pattern"
if ! grep -qE "$match_pattern" "$conf_file"; then
    error_exit "No matching line found to replace in $conf_file."
fi
sed -i "0,/$match_pattern/s/.*/$new_line/" "$conf_file"
echo "Updated $conf_file successfully."
