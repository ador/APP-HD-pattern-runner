#!/bin/bash -eu

coloralignsDir=$(readlink -f "$1")
caAbsDir=$(readlink -f "$coloralignsDir")
export PYTHONPATH="$caAbsDir:${PYTHONPATH:-}"


# we'll look for .fasta files here
alignmentsDir=$(readlink -f "$2")
# results will be generated here 
outDir=$3

linelen=35
namelen=20

mkdir -p ${outDir}

pushd "$coloralignsDir" > /dev/null

  for i in $(ls ${alignmentsDir}/*.fasta) ; do
    echo "Running coloraligns for subtree file $i"
    fileName=`readlink -f "$i" | awk -v FS="/" '{print $NF}'`
    fullFilePath=`readlink -f "$i"`
    python3 coloraligns/apply_colors.py -i ${fullFilePath} -c sampledata/colordef.txt -l ${linelen} -n ${namelen} -s footnotesize -o ${outDir}/${fileName}_generated.tex
    pushd "$outDir" > /dev/null
      pdflatex ${fileName}_generated.tex
    popd > /dev/null
  done

popd > /dev/null

# example usage:
# ./scripts/level_6/visualize_alignments.sh /home/adri/ghub/colorLatexAlignments/ /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_5/weka_c50_min8_40/ /home/adri/ghub/APP-HD-pattern-runner/data/uniprot-rel_2015_04/level_6/pdfs
