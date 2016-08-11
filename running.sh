#!/bin/bash

while : ; do cat output.log | sort | awk '{ count[$0]++ }\
END { printf("%-14s %s\n","curtime","Count");\
for(ind in count)\
{ printf("%-14s %d\n",ind,count[ind]); } }' | sort ; sleep 1 ; done
