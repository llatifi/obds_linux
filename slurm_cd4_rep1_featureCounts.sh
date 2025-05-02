#!/bin/bash
##########################################################################
## A script template for submitting batch jobs. To submit a batch job, 
## please type
##
##    sbatch script_name.sh
##
## Please note that anything after the characters "#SBATCH" on a line
## will be treated as a Slurm option.
##########################################################################

## Specify a partition. Check available partitions using sinfo Slurm command.
#SBATCH --partition=cpu

## The following line will send an email notification to your registered email
## address when the job ends or fails.
#SBATCH --mail-type=END,FAIL

## Specify the amount of memory that your job needs. This is for the whole job.
## Asking for much more memory than needed will mean that it takes longer to
## start when the cluster is busy.
#SBATCH --mem=10G

## Specify the number of CPU cores that your job can use. This is only relevant for
## jobs which are able to take advantage of additional CPU cores. Asking for more
## cores than your job can use will mean that it takes longer to start when the
## cluster is busy.
#SBATCH --ntasks=8

## Specify the maximum amount of time that your job will need to run. Asking for
## the correct amount of time can help to get your job to start quicker. Time is
## specified as DAYS-HOURS:MINUTES:SECONDS. This example is one hour.
#SBATCH --time=0-01:00:00

## Provide file name (files will be saved in directory where job was ran) or path
## to capture the terminal output and save any error messages. This is very useful
## if you have problems and need to ask for help.
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err

## ################### CODE TO RUN ##########################
# Load modules (if required - e.g. when not using conda) 
# module load R-base/4.3.0

# Execute these commands 

# https://subread.sourceforge.net/featureCounts.html
# Summarize a BAM format dataset:
# featureCounts -t exon -g gene_id -a annotation.gtf -o counts.txt mapping_results_SE.bam

# featureCounts -t exon -g gene_id -a <annotation.gtf> -o counts.txt \
# <library1.bam> <library2.bam> <library3.bam> 


# Below failed
# /project/hert7274/1_linux/2_rnaseq/3_analysis/mapping_qc/failed_jobs/217_slurm_cd4_rep1_featureCounts.sh.err
# "ERROR: Paired-end reads were detected in single-end read library"
#featureCounts -t exon -g gene_id -a /project/hert7274/1_linux/2_rnaseq/2_genome/Mus_musculus.GRCm39.113.chr.gtf.gz -o counts.txt \
#/project/hert7274/1_linux/2_rnaseq/3_analysis/mapping_qc/cd4_rep1_sorted.bam


# Second attempt
# Perform strand-specific read counting (use '-s 2' if reversely stranded):
# featureCounts -s 1 -t exon -g gene_id -a annotation.gtf -o counts.txt mapping_results_SE.bam

# featureCounts -s 2 -t exon -g gene_id -a /project/hert7274/1_linux/2_rnaseq/2_genome/Mus_musculus.GRCm39.113.chr.gtf.gz -o counts.txt \
# /project/hert7274/1_linux/2_rnaseq/3_analysis/mapping_qc/cd4_rep1_sorted.bam

# Error again
# " ERROR: Paired-end reads were detected in single-end read library"


# Third attempt
#featureCounts -p --countReadPairs -s 2 -t exon -g gene_id -a /project/hert7274/1_linux/2_rnaseq/2_genome/Mus_musculus.GRCm39.113.chr.gtf.gz -o counts.txt \
#/project/hert7274/1_linux/2_rnaseq/3_analysis/mapping_qc/cd4_rep1_sorted.bam

# Third attempt worked, but instructors realised that gene and genome were not from the same vesion (mm10 needs GRCm38, not GRCm39
# Downloaded GRCm38 from Ensembl
# Rerun featureCounts with new .gtf and allow overwriting output
# Multiqc should look more normal

featureCounts -p --countReadPairs -s 2 -t exon -g gene_id -a /project/hert7274/1_linux/2_rnaseq/2_genome/Mus_musculus.GRCm38.102.chr.gtf.gz -o counts.txt \
/project/hert7274/1_linux/2_rnaseq/3_analysis/mapping_qc/cd4_rep1_sorted.bam
