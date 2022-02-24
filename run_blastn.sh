#!/bin/bash

query_fastas="OG0004107 OG0006395 OG0009254 OG0011465 OG0011581 OG0011634 OG0011851 OG0011900 OG0012127"

#/mnt/bluster/toolbox/BLAST/ncbi-blast-2.10.1+/bin/makeblastdb -in GCF_004799145.1_ASM479914v1_genomic.fna -dbtype nucl

for query_fasta in ${query_fastas}; do
    echo ${query_fasta}
    /mnt/bluster/toolbox/BLAST/ncbi-blast-2.10.1+/bin/blastn  -db GCF_004799145.1_ASM479914v1_genomic.fna -query ${query_fasta}.fasta -out ${query_fasta}.out -num_threads 8 
done

