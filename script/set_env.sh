#!/bin/bash -login

#### start of configuration

####### Adjust values for these parameters ########
#       
#       
#       
#       
###################################################

## THIS SECTION MUST BE MODIFIED FOR YOUR FILE SYSTEM. MUST BE ABSOLUTE PATH
FASTA_FILE_POS=/mnt/gs18/scratch/users/yannisun/AMY/Preprocess/L8_dataset1/L8_dataset1.fa 
BASEDIR=/mnt/gs18/scratch/users/yannisun/AMY/TarGene
WORKDIR=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data 
REFERENCE_DATABASE=/mnt/gs18/scratch/users/yannisun/AMY/TarGene/test_data/hao_database.fa 




## THIS SECTION MUST BE MODIFIED BASED ON THE INPUT DATASETS
THREAD_NUM=8 # number of threads you want to use

## Recruit Reference Program Parameters
RRP_FLAG=false  # Whether you want to run RRP or not(1 for YES, 0 for NO)
NUM_RECRUIT=200  # Number of threads that you want to use
STRIDE=1  # Strides for creating reads from the dataset
LENGTH=100

## TarGene Parameters
SAM_FILE=result.sam # Name of the sam file (output of bowtie2)
REF_DIR=Ref # Name of the reference_idx floder
INDEX_DIR=Idx # Name of the data_idx floder
K=8 # Number of partitions for DATASET Index
OVERLAP=50 # Overlap cutoff for TarGene


## SPAdes Parameters
K_MERS=21,33,55,77,111   # K-mers number 
MAXIMUN_MEM=200  # Maximum memory will be used in SPAdes 
OUTPUT_FOLDER=SPAdes.output



#### end of configuration
