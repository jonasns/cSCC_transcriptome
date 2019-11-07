#!/bin/bash
#Made by Jonas N. Søndergaard
#Made on 191103
#Special script trying to as good as possible to replicate Exiqon/Qiagen's Tophat settings with HiSAT2

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 20
#SBATCH -t 24:00:00
#SBATCH -J 191103_HiSAT2_alignment
#SBATCH --output=191103_HiSAT2_alignment.out
#SBATCH --error=191103_HiSAT2_alignment.err

#modules
module load bioinfo-tools
module load HISAT2/2.1.0 

FQ_PATH=/proj/FQfiles
OUTPUT_PATH=/proj/HiSAT_ExiTophat_settings
REF_PATH=/proj/ref_genomes

#generate known splicesite file (only done once)
extract_splice_sites.py gencode.v19.annotation.gtf > gencode.v19.annotation.splicesites.txt

#HiSAT2
for i in {1..19}; do \
	FILE_NAME=`sed "${i}q;d" Name.list`
	
	date
	echo $i,$FILE_NAME

	hisat2 \
		-p 20 \
		-S ${OUTPUT_PATH}/${FILE_NAME}.sam \
		--known-splicesite-infile gencode.v19.annotation.splicesites.txt \
		--rna-strandness RF \
		--min-intronlen 70 \
		--max-intronlen 500000 \
		-k 20 \
		-x ${REF_PATH}/GRCh37.p13.genome.onlyChr \
		-1 ${FQ_PATH}/${FILE_NAME}.R1.fastq.gz \
		-2 ${FQ_PATH}/${FILE_NAME}.R2.fastq.gz \
		--summary-file ${OUTPUT_PATH}/${FILE_NAME}_alignStats.txt \
		>> ${OUTPUT_PATH}/${FILE_NAME}_hg19align_stdout.stderr.txt 2>&1
		
		gzip ${OUTPUT_PATH}/*.sam
	date
done

#Readme:
#-p: specifies the number of computational cores/threads that will be used by the program
#-S: name of the result file that will be created
#--known-splicesite-infile: use an annotated genome (gtf) file to guide spliced alignments
#--rna-strandness: strand-specific information. Needs to be RF if using Illumina Truseq library preparation.
#--min-intronlen: define minimum intron length
#--max-intronlen: define maximum intron length
#-k: number of accepted multi mappings.
#--summary-file: Print alignment summary to this file
#-x: path to the pre-built genome index. Note that the index consists of multiple files ending in .ht2 , and only the shared part of the filename should be indicated (e.g. genome if the files are called genome.1.ht2 , genome.2.ht2 , etc).
#-1: the first-read mate FASTQ file
#-2: the second-read mate FASTQ file
#--summary-file: Print alignment summary to this file
#>> send all messages from HISAT2 (including errors and warnings) into the specified file

