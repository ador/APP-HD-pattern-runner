#!/bin/bash

# ? note: propfile paths are relative to the project root (APP-HD-pattern-runner) directory

# checking number of params
if [[ $# -ne 2 ]] ; then
  echo "Sample usage : ./filter_dat_rows.sh <path to ProteinPatternSearch repo> <properties file>"
  exit 2;
fi

thisDir=$(dirname $0) || false
protkaDir=$1

pushd ${thisDir} > /dev/null
  expected="/"
  conf=$2
  if [ $expected = ${conf:0:1} ]; then
    propfile=$conf
  else
    propfile=$(pwd)/$conf
  fi
  echo "Using settings from:  $propfile"

  pushd ${protkaDir} > /dev/null

    java -jar java/build/libs/PPsearch.jar FILTER_ROWS $propfile

  popd > /dev/null
popd > /dev/null