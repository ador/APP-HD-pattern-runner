#!/bin/bash 

thisDir=$(dirname $0) || false
thisAbsDir=$(readlink -f "$thisDir")

targetDir=${thisAbsDir}/tools

if [[ $# -gt 0 ]] ; then
  targetDir="$1"
fi

mkdir -p ${targetDir}
wget http://www.clustal.org/omega/clustalo-1.2.0-Ubuntu-x86_64 -O ${targetDir}/clustalo
chmod a+x ${targetDir}/clustalo
