#!/bin/bash
address=`awk -v myvar="$5" '$3 == myvar {print $2}' $1/$2.sym`
echo $5: $address:
curl -s http://$3/v1/machine:readmem?address=$address\&length=$6 -H "X-Password:$4" | xxd -g 8
echo ""
