#!/bin/bash

#To run script: ./extract_first_100tys_seq.sh /home/szymont/kaczy-11/file_of_groups.txt /home/szymont/kaczy-11/trimmed
#Usage: ./extract_first_100tys_seq.sh path_to_file_of_groups path_to_trimmed_directory

#Script exctracts first 400000 lines in fq.gz file to create smaller files for mapping test

#SAMPLES=$(</home/szymont/kaczy-11/file_of_groups.txt )
SAMPLES=$(<$1)
PATH_TO_SAMPLES="$2"
echo "$SAMPLES"


for sample in $SAMPLES; do
    zcat ${PATH_TO_SAMPLES}/${sample}_trimmed.fq.gz | head -n 400000 > ${sample}_100tys_seq.fq

done
