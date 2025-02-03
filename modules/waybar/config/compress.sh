#!/bin/sh
max=50

while IFS= read -r line; do
  # Extract the "text" field from the JSON input.
  text=$(echo "$line" | jq -r '.text')
  
  # If text length is within limit, keep it unchanged.
  if [ ${#text} -le "$max" ]; then
    newtext="$text"
  else
    # Preserve the suffix (assumed to be enclosed in parentheses).
    suffix="(${text##*(}"
    suffix_len=${#suffix}
    
    # Compute how many characters from the beginning can be kept,
    # accounting for the ellipsis ("...") and the suffix.
    head_len=$(( max - suffix_len - 3 ))
    
    # Extract the head portion.
    head_part="${text:0:head_len}"
    
    # Form the new compressed text.
    newtext="${head_part}...${suffix}"
  fi
  
  # Remove any trailing spaces from the new text.
  newtext="$(echo "$newtext" | sed 's/[[:space:]]\+$//')"

  # Update the JSON by replacing the "text" field with the new text.
  # All other fields remain intact.
  echo "$line" | jq -c --arg nt "$newtext" '.text = $nt'
done
