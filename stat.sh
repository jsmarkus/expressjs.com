#!/bin/sh

STM=`find stm -type f -name "*.stm"`



GREEN="\033[0;32m"
RED="\033[0;31m"
LIGHT_GRAY="\033[0;37m"
(for S in $STM; do
	EXCL=`grep "^!" $S | wc --lines`
	TOTAL=`grep "^@" $S | wc --lines`
	if [ "$EXCL" -ge "$TOTAL" ]; then
		COLOR=$RED
	else
		COLOR=$GREEN
	fi

	printf "$COLOR%03d/%03d\t%s$LIGHT_GRAY\n" "$EXCL" "$TOTAL" "$S"
done) | sort -u