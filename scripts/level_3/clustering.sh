#!/bin/bash -eu

# Note: paths should be absolute

# If you are not using Docker, update paths here!
dockerClusConfPath=/home/yoda/git/APP-HD-pattern-runner/configs/level_3/clustering.props

dockerProtGitPath=/home/yoda/git/ProteinPatternSearch
thisDir=$(dirname $0) || false
thisAbsDir=$(readlink -f "$thisDir")

errMsg1a="Sample usage 1 (if in docker environment: no params):"
errMsg1b=" ./clustering.sh"
errMsg2a="Sample usage 2 (two params are needed, plus don't forget to update config path variables within this script!):"
errMsg2b=" ./clustering.sh <absolute path to ProteinPatternSearch repo> <absolute path to WekaClusComp repo>"

# Branching on number of params: default values are for the docker image
if [[ $# -eq 0 ]] ; then
  protkaDir=${dockerProtGitPath}
  confClustering=${dockerClusConfPath}
fi

if [[ $# -eq 1 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

if [[ $# -eq 2 ]] ; then
  protkaDir=$1
  confClustering=$2
fi

if [[ $# -gt 2 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

# create arff file with attributes/features of protein fragments' amino acid stats
pushd ${protkaDir} > /dev/null

  java -jar java/build/libs/PPsearch.jar STATS_ARFF_FOR_WEKA ${confClustering}
  java -jar java/build/libs/PPsearch.jar WEKA_CLUSTERING ${confClustering}
  java -jar java/build/libs/PPsearch.jar SPLIT_FASTA_TO_CLUSTERS_WEKA ${confClustering}

popd > /dev/null
  

## example run (not in docker):
## ./level_3/clustering.sh /home/adri/ghub/ProteinPatternSearch /home/adri/ghub/APP-HD-pattern-runner/configs/level_3/cluster_fragments_a.props 

