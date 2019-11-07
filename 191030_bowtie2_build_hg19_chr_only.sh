#!/bin/bash
#Made by Jonas N. Søndergaard
#Made on 191030
          
#UPPMAX commands (Uppsala Multidisciplinary Center for Advanced Computational Science)
#SBATCH -A uppmax_proj_number
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 2:00:00
#SBATCH -J 191030_bowtie2_build_hg19_chr_only
#SBATCH --output=191030_bowtie2_build_hg19_chr_only.out
#SBATCH --error=191030_bowtie2_build_hg19_chr_only.err

#modules
module load bioinfo-tools
module load bowtie2/2.3.2
   

bowtie2-build \
	GRCh37.p13.genome_onlyChromosomes.fa \
	GRCh37.p13.genome.onlyChr
