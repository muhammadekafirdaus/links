#!/bin/bash

LINK=`curl https://www.mpi-inf.mpg.de/departments/databases-and-information-systems/research/yago-naga/yago/downloads/ | egrep -o "http://resources.mpi-inf.mpg.de/yago-naga/yago([0-9]{1,}\.)+[0-9]{1,}/yagoDBpediaInstances.ttl.7z"`
curl -O  "$LINK"

7za e -so -bd yagoDBpediaInstances.ttl.7z 2>/dev/null | grep sameAs | awk -F " " '{  gsub( /\\\\/,"\\",$3) gsub( /\\u00/,"%",$3)  sub(/</,"<http://yago-knowledge.org/resource/",$1) gsub(/\\u00/,"%",$1); print $3 " <http://www.w3.org/2002/07/owl#sameAs> " $1 " ."}' | grep -v '\\' |sort -u >  "$1" 

rm yagoDBpediaInstances.ttl.7z


