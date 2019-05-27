#!/bin/bash -login

#### start of configuration

####### Adjust values for these parameters ########
#       
#       
#       
#       
###################################################

## THIS SECTION MUST BE MODIFIED FOR YOUR FILE SYSTEM. MUST BE ABSOLUTE PATH
FASTA_FILE_POS=L8_dataset1.fa
BASEDIR=TarGene
WORKDIR=
REF_POS=amo.fa




## THIS SECTION MUST BE MODIFIED BASED ON THE INPUT DATASETS

## Recruit Reference Program Parameters
RRP_FLAG=1  # Whether you want to run RRP or not(1 for YES, 0 for NO)
REFERENCE_DATABASE=amo_database.fa
NUM_RECRUIT=200  # Number of threads that you want to use
STRIDE=1  # Strides for creating reads from the dataset
LENGTH=100

## TarGene Parameters
SAM_FILE= # Name of the sam file (output of bowtie2)
REF_DIR=
INDEX_DIR= 
K = # Number of partitions for DATASET Index
OVERLAP= # Overlap cutoff for TarGene


## SPAdes Parameters
K_MERS=11,17,33  # 
MAXIMUN_MEM=200  # 
OUTPUT_FOLDER=SPAdes.output



#### end of configuration