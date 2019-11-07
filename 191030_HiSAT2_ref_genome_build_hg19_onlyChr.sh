#!/bin/bash
#script to build reference genome for HiSAT2 
#Made by Jonas N. Søndergaard
#Made on 191030

#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number 
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 3:00:00
#SBATCH -J 191030_HiSAT2_ref_genome_build_hg19_onlyChr
#SBATCH --output=191030_HiSAT2_ref_genome_build_hg19_onlyChr.out
#SBATCH --error=191030_HiSAT2_ref_genome_build_hg19_onlyChr.err

#load packages. bioinfo-tools is loaded on uppmax in order to load all other packages used.
module load bioinfo-tools
module load HISAT2/2.1.0 

#use HiSAT2 to build reference genome
hisat2-build \
	-p 8 \
	-f  GRCh37.p13.genome_onlyChromosomes.fa \
	GRCh37.p13.genome.onlyChr
