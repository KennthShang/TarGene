#!/bin/bash -login

#### start of configuration

########## Adjust values for these parameters ###########
#  FASTA_FILE_POS, BASEDIR, WORKDIR, REFERENCE_DATABASE
#  REF_POS, THREAD_NUM, RRP_FLAG, STRIDE, LENGTH
#  K, OVERLAP, K_MERS, MAXIMUN_MEM
#  Note: k and THREAD_NUM should follow: k = n*THREAD_NUM
#        n = 1, 2, 3,...,N
#########################################################

## THIS SECTION MUST BE MODIFIED FOR YOUR FILE SYSTEM. MUST BE ABSOLUTE PATH
## CHOOSE REFERENCE_DATABASE if you want to run rrp else REF_POS
FASTA_FILE_POS=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data/reads.fa                # Reads file
BASEDIR=/mnt/gs18/scratch/users/yannisun/AMY/TarGene                                          # Pwd of the TarGene
WORKDIR=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data                                # Pwd of where you want to run TarGene
REFERENCE_DATABASE=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data/hao_database.fa     # reference database file
REF_POS=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data/hao_database.fa                # reference file



## THIS SECTION MUST BE MODIFIED BASED ON THE INPUT DATASETS
THREAD_NUM=8 # number of threads you want to use

## Recruit Reference Program Parameters
RRP_FLAG=false  # Whether you want to run RRP or not(1 for YES, 0 for NO)
NUM_RECRUIT=200  # Number of threads that you want to use
STRIDE=1  # Strides for creating reads from the dataset
LENGTH=100 # Length for creating reads from the dataset

## TarGene Parameters
SAM_FILE=result.sam # Name of the sam file (output of bowtie2)
REF_DIR=Ref # Name of the reference_idx floder
INDEX_DIR=Idx # Name of the data_idx floder
K=8 # Number of partitions for DATASET Index
OVERLAP=50 # Overlap cutoff for TarGene


## SPAdes Parameters
K_MERS=11,17,33   # K-mers number 
MAXIMUN_MEM=200  # Maximum memory will be used in SPAdes 
OUTPUT_FOLDER=SPAdes.output

NAME=TarGene_${OVERLAP}_overlap

#### end of configuration
