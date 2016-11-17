#!/bin/bash

# Usage: $0 some_text.txt

# match time '10:12:34:723 '
regex="^[[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}.[[:digit:]]{3}\s"
counter=0
prev=""

while read line
do
	if [[ "$line" =~ $regex ]]; then
		prev="$line"
		echo "$prev"
		prev=""
		counter=$[$counter+1]
	else
		prev="$prev$line"
	fi
done < "$1"

echo $counter
exit 0