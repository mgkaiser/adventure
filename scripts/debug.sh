#!/bin/bash
address=`cat $1/$2.sym | sort | uniq | awk -v myvar="$5" '$3 == myvar {print $2}'`
echo $5: $address:
curl -s http://$3/v1/machine:readmem?address=$address\&length=$6 -H "X-Password:$4" | xxd -g 1
echo ""
