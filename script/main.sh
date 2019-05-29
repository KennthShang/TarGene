#!/bin/bash -login

## This is the main script to run TarGene

if [ $# -ne 2 ]; then
        echo "Requires two inputs : /path/set_env.sh tasks" 
        echo "  set_env.sh is a file containing the parameter settings, requires absolute path. See example TarGene/script/set_env.sh" 
        echo '  tasks should contain one or more of the following processing steps with quotes around: rrp, TarGene, SPAdes"'  
        echo 'Example command: bash ../script/main.sh set_env.sh "rrp, TarGene, SPAdes"' 
        exit 1
fi

#### start of configuration
ENVFILE=$1
tasks=$2
source $ENVFILE
#### end of configuration   

mkdir -p ${WORKDIR}/${NAME} || { echo "mkdir -p ${WORKDIR}/${NAME} failed"; exit 1;}

## Running RRP
if [[ " ${tasks[*]} " == *"rrp"* ]]; then
    bash $BASEDIR/script/run_Recruit_Reference_Program.sh $ENVFILE || { exit 1; }
fi

## Running TarGene
if [[ " ${tasks[*]} " == *"TarGene"* ]]; then
    bash $BASEDIR/script/run_TarGene.sh $ENVFILE || { exit 1; }
fi

## Running SPAdes 

if [[ " ${tasks[*]} " == *"SPAdes"* ]]; then
    bash $BASEDIR/script/run_SPAdes.sh $ENVFILE|| { exit 1; }
fi
