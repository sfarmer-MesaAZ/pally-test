#!/bin/bash

# Replace 'your_csv_file.csv' with the actual path
csv_file="siteurls.csv"
delimiter=","
output_dir="../tests"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through each line in the CSV file
counter=0
while IFS=$delimiter read -r url; do
  # Skip null or empty lines
  if [[ -z "$url" ]]; then
    continue
  fi
 # Skip URLs ending in .pdf (case-insensitive)
  if [[ "${url: -3}" = "pdf" || "${url: -3}" = "PDF" ]]; then
    continue
  fi

  # Extract URI components
  uri=$(echo "$url" | tr -d '\r')  # Remove potential carriage return

  # Extract last segment of path for filename
  last_segment=$(echo "$uri" | sed 's/^.*\///')

  # Construct filename with counter
  filename="$last_segment"_"$((counter++))"".js"

  # Construct full output path
  output_path="$output_dir/$filename"

  # Create JS file content
  # content="module.exports = {
  #   url: '"$(echo "$url")"',
  #   actions: []
  # };"
  content="module.exports = {
  url: '"$(echo "$uri")"',  
  actions: []
  };"


  # Write content to JS file in the output directory
  echo "$content" > "$output_path"
done < "$csv_file"

echo "Successfully created JS files in the tests directory!"