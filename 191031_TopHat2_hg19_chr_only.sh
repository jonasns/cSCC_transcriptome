#!/bin/bash
#Made by Jonas N. Søndergaard
#Made on 191031
#Exiqon/Qiagen's Tophat settings with hg19 and normal chromosomes only
          
#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 20
#SBATCH -t 16:00:00
#SBATCH -J 191031_TopHat2_hg19_chr_only
#SBATCH --output=191031_TopHat2_hg19_chr_only.out
#SBATCH --error=191031_TopHat2_hg19_chr_only.err

#modules
module load bioinfo-tools
module load tophat/2.1.1
module load samtools/1.5
module load bowtie2/2.3.2 

FQ_PATH=/proj/FQfiles
OUTPUT_PATH=/proj/TopHat2_Exiqon
REF_PATH=/proj/ref_genomes

#TopHat2
tophat2 \
        -p 20 \
        --output-dir ${OUTPUT_PATH}/4989_015.dir \
	--GTF gencode.v19.annotation.gtf \
        --library-type fr-firststrand \
        --mate-inner-dist -22 \
        --mate-std-dev 30 \
        --min-anchor-length 8 \
        --splice-mismatches 0 \
        --min-intron-length 70 \
        --max-intron-length 500000 \
        --max-insertion-length 3 \
        --max-deletion-length 3 \
        --max-multihits 20 \
        --segment-mismatches 2 \
        --segment-length 25 \
        --min-segment-intron 50 \
        --max-segment-intron 500000 \
        --min-coverage-intron 50 \
        --max-coverage-intron 20000 \
        --read-mismatches 2 \
        --read-gap-length 2 \
        --read-edit-dist 2 \
        --read-realign-edit-dist 3 \
        --no-coverage-search \
	--transcriptome-index gencode.v19.transcriptome \
        ${REF_PATH}/GRCh37.p13.genome.onlyChr \
        ${FQ_PATH}/4989-015.R1.fastq.gz \
        ${FQ_PATH}/4989-015.R2.fastq.gz \
	--paired \
        >> ${OUTPUT_PATH}/4989_015.dir/4989-015_hg38align_stdout.stderr.txt 2>&1

