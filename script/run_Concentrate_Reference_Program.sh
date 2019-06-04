#!/bin/bash -login

## this script run Recruit Reference Program
## this is a tool that can recruit a small number of genes as representation for the original dataset

set -x

#### start of configuration, xander_setenv.sh or qsub_xander_setenv.sh
source $1
#### end of configuration

cd ${WORKDIR}/${NAME}
mkdir -p ${WORKDIR}/${NAME}/RRP || { echo "mkdir -p ${WORKDIR}/RRP failed"; exit 1;}
cd ${WORKDIR}/${NAME}/RRP

## build bloom filter
if [ -f "concentrate_ref.fa" ]; then
   echo "File recruit_ref.fa exists, SKIPPING RRP (manually delete if you want to rerun)" 
else
   python3 ${BASEDIR}/tools/recruit_ref.py -n $NUM_RECRUIT -s $STRIDE -l $LENGTH -f $REFERENCE_DATABASE -t $THREAD_NUM || { echo "Recruit Reference Program failed"; exit 1;}
   if [ -f "data_remain.fa" ]; then
      cat data_remain.fa concentrate_reference/* > concentrate_ref.fa 
   else
      cat concentrate_reference/* > concentrate_ref.fa 
   fi
   echo "Concentrate Reference Program complete!"
fi
