#!/bin/bash

# find out where we are
thisDir=$(dirname $0) || false

# create a directory for the dataset if it does not exist
mkdir -p ${thisDir}/../data/uniprot-latest
pushd ${thisDir}/../data/uniprot-latest > /dev/null
  echo "Starting download, might take a while ..."
  #  general url:
  # wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.dat.gz
  # wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
  #  from Europe:
  wget ftp://ftp.expasy.org/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.dat.gz
  wget ftp://ftp.expasy.org/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz

  echo "Swissprot dataset downloaded at $(date)" > last_download_when.txt
  echo "Extracting files ..."
  gunzip uniprot_sprot.dat.gz
  gunzip uniprot_sprot.fasta.gz
  echo "Done."
popd > /dev/null
