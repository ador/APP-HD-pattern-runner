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
  echo "Running clustal omega for subtree file $i"
  fileName=`readlink -f "$i" | awk -v FS="/" '{print $NF}'`
  ${clustal} -i $i --outfile=${outDir}/aligned_${fileName}
done

## example:
# realign_subtree_seqs.sh /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_5/weka_c50_min8_40 /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_6
