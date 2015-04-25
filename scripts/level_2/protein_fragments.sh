#!/bin/bash

# Note: paths should be absolute
dockerConfPath=/home/yoda/git/APP-HD-pattern-runner/configs/level_2/fragments_tm_and_extracellular_40-70.props
dockerProtGitPath=/home/yoda/git/ProteinPatternSearch
thisDir=$(dirname $0) || false

errMsg1a="Sample usage 1 (if in docker environment: no params):"
errMsg1b=" ./protein_fragments.sh"
errMsg2a="Sample usage 2 (two params are needed):"
errMsg2b=" ./protein_fragments.sh <absolute path to ProteinPatternSearch repo> <absolute path to properties file>"

# Branching on number of params: default values are for the docker image
if [[ $# -eq 0 ]] ; then
  protkaDir=$dockerProtGitPath
  confFile=$dockerConfPath
fi

if [[ $# -eq 1 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi


if [[ $# -eq 2 ]] ; then
  protkaDir=$1
  confFile=$2
fi

if [[ $# -gt 2 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

# Running
pushd ${protkaDir} > /dev/null

  java -jar java/build/libs/PPsearch.jar TM_EXT_FRAGMENTS $confFile

popd > /dev/null