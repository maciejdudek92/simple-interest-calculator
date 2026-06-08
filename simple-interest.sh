bash_script_content = """#!/bin/bash

# -------------------------------------------------------------------------
# Script Name: simple-interest.sh
# Description: A simple interest calculator that takes Principal, Rate of 
#              Interest, and Time Period from user input.
# -------------------------------------------------------------------------

echo "========================================"
echo "       Simple Interest Calculator       "
echo "========================================"

# Prompt user for the Principal Amount
read -p "Enter the Principal amount (P): " principal

# Prompt user for the Rate of Interest
read -p "Enter the annual Rate of Interest in % (R): " rate

# Prompt user for the Time Period in years
read -p "Enter the Time Period in years (T): " time

# Validate inputs are not empty
if [[ -z "$principal" || -z "$rate" || -z "$time" ]]; then
    echo "Error: All fields are required. Please run the script again."
    exit 1
fi

# Calculate Simple Interest using 'bc' for floating-point arithmetic
# Formula: SI = (P * R * T) / 100
simple_interest=$(echo "scale=2; ($principal * $rate * $time) / 100" | bc -l 2>/dev/null)

# Fallback to 'awk' if 'bc' is not installed on the system
if [ $? -ne 0 ] || [ -z "$simple_interest" ]; then
    simple_interest=$(awk "BEGIN {printf \"%.2f\", ($principal * $rate * $time) / 100}")
fi

# Calculate Total Amount (Principal + Interest)
total_amount=$(echo "scale=2; $principal + $simple_interest" | bc -l 2>/dev/null)
if [ $? -ne 0 ] || [ -z "$total_amount" ]; then
    total_amount=$(awk "BEGIN {printf \"%.2f\", $principal + $simple_interest}")
fi

# Output the results
echo "----------------------------------------"
echo "Calculation Summary:"
echo "----------------------------------------"
echo "Principal Amount  : $principal"
echo "Rate of Interest  : $rate%"
echo "Time Period       : $time year(s)"
echo "----------------------------------------"
echo "Simple Interest   : $simple_interest"
echo "Total Amount Due  : $total_amount"
echo "========================================"
"""

with open("simple-interest.sh", "w", encoding="utf-8") as f:
    f.write(bash_script_content)

print("File 'simple-interest.sh' created successfully.")
