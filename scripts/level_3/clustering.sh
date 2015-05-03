#!/bin/bash

## Prerequisite: if you are not runing this inside a pre-set docker container,
## then you need to get a kClust binary (http://www.ncbi.nlm.nih.gov/pubmed/23945046):
## either run "tools/get_kClust.sh <tools dir>"
## or download manually from ftp://toolkit.lmb.uni-muenchen.de/pub/kClust/
## and then place it inside the project root's "tools" directory

# Note: paths should be absolute
dockerConfPath=/home/yoda/git/APP-HD-pattern-runner/configs/level_2/fragments_tm_and_extracellular_40-70.props
dockerProtGitPath=/home/yoda/git/ProteinPatternSearch
thisDir=$(dirname $0) || false
thisAbsDir=$(readlink -f "$thisDir")
kClustBinary=${thisAbsDir}/../../tools/kClust

errMsg1a="Sample usage 1 (if in docker environment: no params):"
errMsg1b=" ./clustering.sh"
errMsg2a="Sample usage 2 (two params are needed):"
errMsg2b=" ./clustering.sh <absolute path to ProteinPatternSearch repo> <absolute path to properties file>"

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

# download kClust if its not here yet
if [ ! -f ${kClustBinary} ] ; then 
  bash ${thisAbsDir}/../../tools/get_kClust.sh ${thisAbsDir}/../../tools
fi

# get kclust out path from confFile to use as an input param when running kClust
kClustResultDir=`cat ${confFile} | grep "inputKClustResultDir" | cut -d'=' -f2`
# get fasta input from confFile to use as an input param when running kClust
inputFastaFile=`cat ${confFile} | grep "inputFastaFile" | cut -d'=' -f2`

mkdir -p ${kClustResultDir}

# Running kClust
${kClustBinary} -i ${inputFastaFile} -d ${kClustResultDir} # --filter-k 4 --filter-T 2 

if (($? > 0)); then
  echo "Some error happened while trying to run kClust!"
  exit 1
fi

pushd ${protkaDir} > /dev/null

  java -jar java/build/libs/PPsearch.jar SPLIT_FASTA_TO_CLUSTERS ${confFile}

popd > /dev/null

## example run (not in docker):
## ./level_3/clustering.sh /home/adri/ghub/ProteinPatternSearch /home/adri/ghub/APP-HD-pattern-runner/configs/level_3/cluster_fragments_a.props 

