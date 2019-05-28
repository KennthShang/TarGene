# TarGene
Metagenomic data provides an opportunity to discover microbial communities and their characteristics. However, many researchers are only interested in some specific species and don’t need to analyze the whole datasets. 

We developed a novel pipeline named TarGene for assembling genome of interest. In this method, the functional genes are provided as reference, TarGene will then recruit more reads that belong to the same genome as the reference genes. Finally, a de Bruijn graph will be built on these recruited reads to assemble the genome sequences. We tested our pipeline using several real metagenomic datasets. 

To use TarGene, you need to have two types of data. (1) read set, such as metagenomic data containing reads. (2) reference gene, which can be a gene or a related gene database. If you are using a gene database as reference, we recommand you to run our tools named Recruit Reference Program first. It will help you save a large bunch of time. 

We provide two methods for installing TarGene. You can directly install these tools following the instructions below. In addition, we also provide packaged TarGene via Anaconda, which makes the installation more straightforward. 


## Required Dependencies
1. [Samtools](http://samtools.sourceforge.net/)
2. [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
3. [SPAdes](http://cab.spbu.ru/software/spades/)


## Installing via conda 
Noted that all the packages can be found on anaconda.cloud, which means you can easily install them by using conda. You can follow the [Guidance](https://github.com/KennthShang/TarGene/edit/master/README.md) to install step by step. 

## Installation without using conda
If you would like to install all the programs without using conda, please still take a look at the [Guaidance](https://github.com/chjiao/TAR-VIR/blob/master/Guidance%20for%20Installing%20PEHaplo%20and%20TAR-VIR.md), which contains a running example.

To download the source code:   
git clone https://github.com/KennthShang/TarGene.git

1. Install TarGene module   
This program requries the supports of C++11.   
```
  cd TarGene
  make    
```

## Quickstart using shell script
Use testdata as an example. Make a copy of bin/xander_setenv.sh and change path variables to be the absolute paths in your system. For your samples, you may also need to adjust the Parameters used in TarGene

The following example commands will attempt to run all the three steps "rrp", "TarGene" and "SPAdes" for the genes Hydroxylamine oxidoreductase (hao) and Ammonia monooxygenase subunit A (amoA) specified in the input param. It creates an assembly output directory "recruit50" for overlap cutoff of 50. It saves all the output in the output directory.

```
bash
cd testdata
cp ../script/set_env.sh my_env.sh
# edit the parameters in my_env.sh 
../bin/main.sh my_env.sh "rrp TarGene SPAdes"
```

You can also run the three steps separately, or choose the program you want to run.
```

../bin/main.sh my_env.sh "rrp"
../bin/main.sh my_env.sh "TarGene"
../bin/main.sh my_env.sh "SPAdes"

```
Note if you want to rerun the program, you need to manually delete the corresponding files in the output directory. 
