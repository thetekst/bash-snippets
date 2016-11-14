#!/bin/bash

# Usage: $0 <some_text.txt

while read line
do
	echo "$line"
	len=${#line}

	echo $len
done
exit 0
