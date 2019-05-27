#!/bin/bash -login

## this script run SPAdes
## this step takes time and requires large memory for large dataset, see Readme for instructions


set -x

#### start of configuration, xander_setenv.sh
source $1
#### end of configuration
if [ -f "recruit.fa" ]; then
   perl $BASEDIR/tools/fasta_to_fastq.pl recruit.fa >recruit.fq { echo "convert fasta to fastq failed"; exit 1;}
   spades.py -s recruit.fq -k $K_MERS -m $MAXIMUN_MEM --phred-offset 33 -t $THREAD_NUM -o $OUTPUT_FOLDER || { echo "SPAdes failed"; exit 1;}
   
else
   echo "Please run TarGene first!"
fi
## 
