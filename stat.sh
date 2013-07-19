#!/bin/bash

STM=`find stm -type f -name "*.stm"`



GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
LIGHT_GRAY="\033[0;37m"
(for S in $STM; do
	EXCL=`grep "^!" $S | wc --lines`
	TOTAL=`grep "^@" $S | wc --lines`
	let "TRANS = $TOTAL - $EXCL"
	if [ "$EXCL" -ge "$TOTAL" ]; then
		COLOR=$RED
	elif [ "$EXCL" -eq "0" ]; then
		COLOR=$GREEN
	else
		COLOR=$YELLOW
	fi

	printf "$COLOR%03d/%03d\t%s$LIGHT_GRAY\n" "$TRANS" "$TOTAL" "$S"
done) | sort -u