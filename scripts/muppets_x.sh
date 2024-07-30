#!/bin/bash

# Install required package (assuming you don't have libreoffice calc installed)
sudo apt install libreoffice-calc

# Replace 'your_excel_file.xlsx' with the actual path
excel_file="siteurls.xlsx"
sheet_number=1  # Assuming data is in the first sheet (index starts from 1)

# Use libreoffice calc in headless mode to open the spreadsheet
output=$(libreoffice --headless --calc "$excel_file" --convert-to csv:text:unix,LF --outdir /tmp)

# Check if conversion was successful
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to convert Excel file to CSV"
  exit 1
fi

# Temporary CSV file path
csv_file="/tmp/$(basename "$excel_file" .xlsx).csv"

# Process data from CSV file
while IFS=, read -r url; do
  # Skip null or empty lines
  if [[ -z "$url" ]]; then
    continue
  fi

  # Extract URI components
  uri=$(echo "$url" | tr -d '\r')  # Remove potential carriage return
  base_url=$(echo "$uri" | sed 's/\/[^/]*$//')
  first_segment=$(echo "$uri" | cut -d '/' -f 2)

  # Construct filename
  filename="$base_url"_"$first_segment.js"

  # Create JS file content
  content="module.exports = {
    url: '$url',
    actions: []
  };"

  # Write content to JS file
  echo "$content" > "$filename"
done < "$csv_file"

# Clean up temporary file
rm "$csv_file"

echo "Successfully created JS files for extracted URLs!"
