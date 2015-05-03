#!/bin/bash

# Note: paths should be absolute
dockerConfPath=/home/yoda/git/APP-HD-pattern-runner/configs/level_2/fragments_tm_and_extracellular_40-70.props
dockerProtGitPath=/home/yoda/git/ProteinPatternSearch
dockerKClust=/home/yoda/kclust/kClust
thisDir=$(dirname $0) || false

errMsg1a="Sample usage 1 (if in docker environment: no params):"
errMsg1b=" ./clustering.sh"
errMsg2a="Sample usage 2 (three params are needed):"
errMsg2b=" ./clustering.sh <absolute path to kClus binary> <absolute path to ProteinPatternSearch repo> <absolute path to properties file>"

# Branching on number of params: default values are for the docker image
if [[ $# -eq 0 ]] ; then
  protkaDir=$dockerProtGitPath
  confFile=$dockerConfPath
  kClustBinary=$dockerKClust
fi

if [[ $# -eq 1 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

if [[ $# -eq 2 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

if [[ $# -eq 3 ]] ; then
  kClustBinary=$1
  protkaDir=$2
  confFile=$3
fi

if [[ $# -gt 3 ]] ; then
  echo ${errMsg1a} && echo ${errMsg1b} && echo ${errMsg2a} && echo ${errMsg2b}
  exit 2;
fi

# get kclust out path from confFile to use as an input param when running kClust
kClustResultDir=`cat ${confFile} | grep "inputKClustResultDir" | cut -d'=' -f2`
# get fasta input from confFile to use as an input param when running kClust
inputFastaFile=`cat ${confFile} | grep "inputFastaFile" | cut -d'=' -f2`

if [[ -d ${kClustResultDir} ]] ; then 

  if [ "$(ls -A ${kClustResultDir})" ]; then
      echo "${kClustResultDir} is not empty! Do you want to overwrite its contents? (y/n)\n"
      read answer
      if [[ ${answer} == *y* ]] ; then
        rm -rf ${kClustResultDir}
        mkdir -p ${kClustResultDir}
      fi
  else
      echo "${kClustResultDir} is OK."
  fi
else
  mkdir -p ${kClustResultDir}
fi 

# Running kClust
bash ${kClustBinary} -i ${inputFastaFile} -d ${kClustResultDir} --filter-k 4 --filter-T 2 

if (($? > 0)); then
  echo "Some error happened while trying to run kClust!"
  exit 1
fi

pushd ${protkaDir} > /dev/null

  java -jar java/build/libs/PPsearch.jar SPLIT_FASTA_TO_CLUSTERS ${confFile}

popd > /dev/null
