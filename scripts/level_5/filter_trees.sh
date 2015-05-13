#!/bin/bash

# filtering trees: looking for subtrees that contain the given pattern at least in some percentage of the leaves

# Note: paths should be absolute
dockerConfPath=/home/yoda/git/APP-HD-pattern-runner/configs/level_5/tree_filter.props
dockerPhyTreePath=/home/yoda/git/PhyTreeSearch
thisDir=$(dirname $0) || false

errMsg1a="Sample usage 1 (if in docker environment: no params):"
errMsg1b=" ./filter_trees.sh"
errMsg2a="Sample usage 2 (two params are needed):"
errMsg2b=" ./filter_trees.sh <absolute path to PhyTreeSearch repo> <absolute path to properties file>"

# Branching on number of params: default values are for the docker image
if [[ $# -eq 0 ]] ; then
  phyDir=$dockerPhyTreePath
  confFile=$dockerConfPath
fi

if [[ $# -eq 1 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi


if [[ $# -eq 2 ]] ; then
  phyDir=$1
  confFile=$2
fi

if [[ $# -gt 2 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

# Running
pushd ${phyDir} > /dev/null

  java -jar build/libs/phyTreeSearcher.jar ${confFile}

popd > /dev/null

# example:
# ./scripts/level_5/filter_trees.sh /home/adri/ghub/PhyTreeSearch/ /home/adri/ghub/APP-HD-pattern-runner/configs/level_5/tree_filter_a.props

