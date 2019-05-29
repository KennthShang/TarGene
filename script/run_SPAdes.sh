#!/bin/bash -login

## this script run SPAdes
## this step takes time and requires large memory for large dataset, see Readme for instructions


set -x

#### start of configuration, xander_setenv.sh
source $1
#### end of configuration
cd ${WORKDIR}/${NAME}

if [ -f "recruit_reads/recruit.fa" ]; then
   perl $BASEDIR/tools/fasta_to_fastq.pl recruit_reads/recruit.fa >recruit_reads/recruit.fq || { echo "convert fasta to fastq failed"; exit 1;}
   spades.py -s recruit_reads/recruit.fq -k $K_MERS -m $MAXIMUN_MEM --phred-offset 33 -t $THREAD_NUM -o $OUTPUT_FOLDER || { echo "SPAdes failed"; exit 1;}
   
else
   echo "Please run TarGene first!"
fi
## 
