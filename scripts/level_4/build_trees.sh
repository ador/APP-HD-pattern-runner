#!/bin/bash

thisDir=$(dirname $0) || false
thisAbsDir=$(readlink -f "$thisDir")
clustalOmega=${thisAbsDir}/../../tools/clustalo

if [[ $# -lt 2 ]] ; then
  echo "Expecting 2 parameters: <directory_of_clusters> <output_dir>\n"
  echo "Or, alternatively, use the \"docker auto\" parameter pair if you use Docker to run the pipeline and did not change the config files.\n"
  exit 2;
fi

if [[ $1="docker" && $2="auto" ]]; then
  # we'll look for .fasta files here:
  clustersDir=/home/yoda/git/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_3/
  # and write results here:
  outDir=/home/yoda/git/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_4/
else 
  # we'll look for .fasta files here:
  clustersDir=$1
  # and write results here:
  outDir=$2
fi

mkdir -p ${outDir}

# download clustalOmega if its not here yet
if [ ! -f ${clustalOmega} ] ; then 
  bash ${thisAbsDir}/../../tools/get_clustalOmega.sh ${thisAbsDir}/../../tools
fi

for i in $(ls ${clustersDir}/*.fasta) ; do
  echo "Running clustal omega for cluster: $i"
  fileName=`readlink -f "$i" | awk -v FS="/" '{print $NF}'`
  ${clustalOmega} -i $i --iter=5 --threads=1 --guidetree-out=${outDir}/tree_${fileName}.nwk --outfile=${outDir}/clus_${fileName}.align
done

## example:
#build_trees.sh /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_3/clusters_fasta /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_4
