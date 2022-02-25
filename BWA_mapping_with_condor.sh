#!/bin/bash

SAMPLES="10 13 21 22 25 26 27 28-d 3 7-d"


run_bwa_index(){
    /mnt/bluster/toolbox/genom_pipeline_hg38/bwa.kit/bwa index /home/szymont/kaczy-11/test_mapping_Medicago_truncatula/referencyjny_genom_Medicago_truncatula/Medicago_truncatula.MedtrA17_4.0.dna.toplevel.fa


}



run_bwa_mapping_raw_files(){
    mkdir bwa_output
    mkdir logs
    condor_submit bwa_mapping.txt
    #/mnt/bluster/toolbox/genom_pipeline_hg38/bwa.kit/bwa mem /home/szymont/kaczy-11/test_mapping_Medicago_truncatula/referencyjny_genom_Medicago_truncatula/Medicago_truncatula.MedtrA17_4.0.dna.toplevel.fa -t 4 /home/szymont/kaczy-11/test_mapping_prosopis_alba_genome/10_1_100tys_seq.fq /home/szymont/kaczy-11/test_mapping_prosopis_alba_genome/10_2_100tys_seq.fq

}





sam_to_bam(){ # $1 = output folder of mapping
    for sample in ${SAMPLES}; do
        podman run -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools view -@ 4 -bS  /data/${sample}_bwa.sam  -o /data/${sample}.bam

    done


    for sample in ${SAMPLES}; do
        podman run -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools sort -@ 4 /data/${sample}.bam  -o /data/${sample}_sorted.bam

    done


    for sample in ${SAMPLES}; do
        podman run  -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools index -@ 4 /data/${sample}_sorted.bam

    done

    for sample in ${SAMPLES}; do
        podman run  -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools idxstats -@ 4 /data/${sample}_sorted.bam > ${sample}_idxstats.txt

    done

    mv *.txt $1

    for sample in ${SAMPLES}; do
        podman run -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools stats -@ 4 /data/${sample}_sorted.bam > ${sample}_stats.txt

    done

    mv *.txt $1


    for sample in ${SAMPLES}; do
        podman run  -it --rm -v $(pwd)/$1:/data staphb/samtools:1.13 samtools flagstat -@ 4 /data/${sample}_sorted.bam > ${sample}_flagstat.txt

    done

    mv *.txt $1

}





run_main(){
    #run_bwa_index
    #run_bwa_mapping_raw_files
    sam_to_bam bwa_output

}

run_main
