#!/bin/bash

# Usage: $0 <some_text.txt
filename="$1"
regex="atat\snon$"

while read line
do
	if [[ "$line" =~ ^"quis" || "$line" =~ $regex ]]; then
		echo "$line"
		# echo -n "$line" # -n вывод без new line. В одну строку
	fi
done < "$filename"
exit 0
