#!/bin/bash -login

## this script run TarGene
## this step takes time and requires large memory for large dataset, see Readme for instructions


set -x

#### start of configuration, xander_setenv.sh or qsub_xander_setenv.sh
source $1
flag=$RRP_FLAG
#### end of configuration

mkdir ${WORKDIR}/${NAME}/recruit_reads || { echo "mkdir -p ${WORKDIR}/recruit_reads failed"; exit 1;}
cd ${WORKDIR}/${NAME}/recruit_reads

## Running TarGene
if [ -f "recruit.fa" ]; then
   echo "File recruit.fa exists, SKIPPING TarGene (manually delete if you want to rerun)"
else
   echo "### Build bloom filter"
   mkdir $REF_DIR || { echo "mkdir ${REF_DIR} failed"; exit 1;}
   if [[ " ${tasks[*]} " == *"true"* ]]; then
      bowtie2-build -f ${WORKDIR}/RRP/recruit_ref.fa ${REF_DIR}/IDX || { echo "Bowtie2-build failed"; exit 1;}
   else
      bowtie2-build -f $REF_POS ${REF_DIR}/IDX || { echo "Bowtie2-build failed"; exit 1;}
   fi
   
   bowtie2 -x ${REF_DIR}/IDX -f $FASTA_FILE_POS -p $THREAD_NUM -S $SAM_FILE || { echo "Bowtie2 failed"; exit 1;}
   samtools view -F 4 -h $SAM_FILE >mapped.sam || { echo "Samtools failed"; exit 1;}
   mkdir $INDEX_DIR || { echo "mkdir $INDEX_DIR failed"; exit 1;}
   $BASEDIR/build -f $FASTA_FILE_POS -o ${INDEX_DIR}/IDX || { echo "build function failed"; exit 1;}
   $BASEDIR/overlap -S mapped.sam -x ${INDEX_DIR}/IDX -f $FASTA_FILE_POS -c $OVERLAP -k $K -p $THREAD_NUM -o recruit.fa || { echo "overlap function failed"; exit 1;}
fi
