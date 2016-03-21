#! /bin/bash
RESULT=$(curl --head --silent --show-error localhost:80)
SUCCESS=$(echo "$RESULT" | head -1 | grep "200 OK")

#echo ${#SUCCES}

if [ -n "$SUCCESS" ]; then
	#echo "$SUCCESS"
	exit 0
else
	echo "$RESULT"
	exit 1
fi
