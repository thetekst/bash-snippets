#!/bin/bash

# Usage: $0 some_text.txt

# match time '10:12:34:723 '
regex="^[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{3}\s"
counter=0

while read line
do
	if [[ "$line" =~ $regex ]]; then
		echo "$line"
		counter=$[$counter+1]
		# echo -n "$line" # -n вывод без new line. В одну строку
	fi
done < "$1"

echo $counter
exit 0