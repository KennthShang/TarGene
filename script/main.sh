#!/bin/bash -login

## This is the main script to run TarGene

if [ $# -ne 3 ]; then
        echo "Requires two inputs : /path/xander_setenv.sh tasks"
        echo "  xander_setenv.sh is a file containing the parameter settings, requires absolute path. See example RDPTools/Xander_assembler/bin/xander_setenv.sh"
        echo '  tasks should contain one or more of the following processing steps with quotes around: build find search"'
        echo '  genes should contain one or more genes to process with quotes around'
        echo 'Example command: /path/xander_setenv.sh "build find search" "nifH nirK rplB"'
        exit 1
fi

#### start of configuration
ENVFILE=$1
tasks=$2
source $ENVFILE
#### end of configuration   

mkdir -p ${WORKDIR}/${NAME} || { echo "mkdir -p ${WORKDIR}/${NAME} failed"; exit 1;}
cd ${WORKDIR}/${NAME}

## build bloom filter, this step takes time, not multithreaded yet, wait for future improvement
## only once for each dataset at given kmer length
if [[ " ${tasks[*]} " == *"rrp"* ]]; then
    $BASEDIR/run_Recruit_Reference_Program.sh $ENVFILE || { exit 1; }
fi

## find starting kmers, multiple genes should be run together to save time, has multithread option
if [[ " ${tasks[*]} " == *"TarGene"* ]]; then
    $BASEDIR/run_TarGene.sh $ENVFILE || { exit 1; }
fi

## search contigs and post-assembly processing
## can run in parallel 

if [[ " ${tasks[*]} " == *"SPAdes"* ]]; then
    $BASEDIR/run_SPAdes.sh || { exit 1; }
fi
