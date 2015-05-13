#!/bin/bash

thisDir=$(dirname $0) || false
thisAbsDir=$(readlink -f "$thisDir")
clustal=${thisAbsDir}/../../tools/clustalo

# we'll look for .fasta files here
clustersDir=$1
outDir=$2

mkdir -p ${outDir}

# download clustalOmega if its not here yet
if [ ! -f ${clustalOmega} ] ; then 
  bash ${thisAbsDir}/../../tools/get_clustalOmega.sh ${thisAbsDir}/../../tools
fi

for i in $(ls ${clustersDir}/*.fasta) ; do
  echo "Running clustal omega for cluster: $i"
  fileName=`readlink -f "$i" | awk -v FS="/" '{print $NF}'`
  ${clustal} -i $i --iter=5 --threads=1 --guidetree-out=${outDir}/tree_${fileName}.nwk --outfile=${outDir}/clus_${fileName}.align
done

## example:
#build_trees.sh /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_3/clusters_fasta /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_4
