#!/bin/bash

# Note: paths should be absolute

# checking number of params
if [[ $# -ne 2 ]] ; then
  echo "Sample usage : ./filter_dat_rows.sh <absolute path to ProteinPatternSearch repo> <abs. path to properties file>"
  exit 2;
fi

thisDir=$(dirname $0) || false
protkaDir=$1
confFile=$2

pushd ${protkaDir} > /dev/null

  java -jar java/build/libs/PPsearch.jar FILTER_ROWS $confFile

popd > /dev/null