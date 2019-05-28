# TarGene
Metagenomic data provides an opportunity to discover microbial communities and their characteristics. However, many researchers are only interested in some specific species and don’t need to analyze the whole datasets. 

We developed a novel pipeline named TarGene for assembling genome of interest. In this method, the functional genes are provided as reference, TarGene will then recruit more reads that belong to the same genome as the reference genes. Finally, a de Bruijn graph will be built on these recruited reads to assemble the genome sequences. We tested our pipeline using several real metagenomic datasets. 

To use TarGene, you need to have two types of data. (1) read set, such as metagenomic data containing reads. (2) reference gene, which can be a gene or a related gene database. If you are using a gene database as reference, we recommand you to run our tools named Recruit Reference Program first. It will help you save a large bunch of time. 

We provide two methods for installing TarGene. You can directly install these tools following the instructions below. In addition, we also provide packaged TarGene via Anaconda, which makes the installation more straightforward. 


## Installing via conda (recommended if you want to install both TAR-VIR and PEHaplo)
Noted that all the packages can be found on anaconda.cloud, which means you can easily install them by using conda. You can follow the [Guidance](https://github.com/KennthShang/TarGene/edit/master/README.md) to install step by step. 

## Installation without using conda
If you would like to install all the programs without using conda, please still take a look at the [Guaidance](https://github.com/chjiao/TAR-VIR/blob/master/Guidance%20for%20Installing%20PEHaplo%20and%20TAR-VIR.md), which contains a running example.

To download the source code:   
git clone https://github.com/KennthShang/TarGene.git

1. Install Overlap extension module   
This program requries the supports of C++11.   
cd TarGene
make    

## Preprocessing


## Usage   

