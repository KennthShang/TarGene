#!/usr/bin/env python3
import os 
import sys
from collections import Counter

def create_reads(stride_of_reads, length_of_reads):
    with open("new_data.fa") as file:
        database = file.readlines()
        file.close()
        Gene = []
        Title = []
        for line in database:
            if line[0] == '>':
                Title.append(line[:-1])
           
            else:
                Gene.append(line[:-1])

        read_len = length_of_reads
        stride = stride_of_reads

        reads_seq = []
        reads_title = []
        for i in range(len(Gene)):
            title = Title[i]
            gene = Gene[i]
            counter = 0
            for j in range(0, len(gene), stride):
                if j+read_len > len(gene):
                    break

                reads_seq.append(gene[j:j+read_len])
                reads_title.append(title+'-'+str(counter))
                counter+=1

            reads_seq.append(gene[-read_len:])
            reads_title.append(title+'-'+str(counter))

    with open("reads.fa", 'w') as file:
        for i in range(len(reads_seq)):
            file.write(reads_title[i]+'\n')
            file.write(reads_seq[i]+'\n')
        file.close()

def remove():
    file_name = "mapped.sam"
    with open(file_name) as file:
        filter_data = []
        for line in file.readlines():
            if line[0] == '@':
                filter_data.append(line)
            else:
                temp = line.split('\t')

                read_name = temp[0]
                gene_name = temp[2]
                if read_name.split('-')[0] == gene_name:
                    continue
                filter_data.append(line)

        file.close()
        
    with open("filter.sam", 'w') as file:
        for line in filter_data:
                file.write(line)
        file.close()

def capture():
    with open("filter.sam") as file:
        database = []
        for line in file.readlines():
            if line[0] == '@':
                continue
            else:
                temp = line.split('\t')

                read_name = temp[0]
                gene_name = temp[2]
                database.append(read_name+" "+gene_name+'\n')

        file.close()
    
    with open("read_gene", 'w') as file:
        for line in database:
            file.write(line)
        file.close()
    
def find_most():
    with open('read_gene') as file:
        database = file.readlines()
        file.close()


        title = []
        for i in range(0, 120365):
            title.append(str(i))
        gene_mapped_num = dict.fromkeys(title, 0)

        
        for line in database:
            tmp = line.split(" ")
            gene = tmp[1]
            gene = gene[:-1]

            gene_mapped_num[gene]+=1


        tmp = Counter(gene_mapped_num)
        common = tmp.most_common()
        
        ref_name = common[0][0]
        print("****NOTE****")
        print("The most valuable reference in this loop is: ", ref_name)
        print("The number of related reads is: ", common[0][1])
        pos = (int(ref_name)+1)*2-2
        
        with open('new_data.fa') as R:
            database = R.readlines()
            R.close()
            
            ref = database[pos]+database[pos+1]
            return ref, pos
            
            
        
    

def create_new_database(ref_title):
    with open("mapped.sam") as file:
        samfile = file.readlines()
        file.close()

        similar_ref = []
        similar_ref.append(str(ref_title))
        for line in samfile:
            tmp = line.split('\t')
            read_name = tmp[0]
            read_belong = read_name.split('-')[0]

            similar_ref.append(read_belong)
        similar_ref = list(set(similar_ref))


    with open("new_data.fa") as file:
        database = file.readlines()
        file.close()

        new_database_ref = []
        new_database_dna = []
        for i in range(0, len(database), 2):
            ref_name = database[i]


            if ref_name[1:-1] in similar_ref:
                continue
            new_database_ref.append(database[i])
            new_database_dna.append(database[i+1])
            
    with open("temp.fa", 'w') as file:
        for i in range(len(new_database_ref)):
            file.write(new_database_ref[i])
            file.write(new_database_dna[i])
        file.close()
        
    os.system("rm new_data.fa")
    os.system("mv temp.fa new_data.fa")

def create_reads_first(filename, stride_of_reads, length_of_reads):
    with open(filename) as file:
        database = file.readlines()
        file.close()
        text = ""
        Gene = []
        Title = []
        for line in database:
            if line[0] == '>':
                Title.append(line[:-1])
           
            else:
                Gene.append(line[:-1])
        read_len = length_of_reads
        stride = stride_of_reads

        reads_seq = []
        reads_title = []
        for i in range(len(Gene)):
            title = Title[i]
            gene = Gene[i]
            counter = 0
            for j in range(0, len(gene), stride):
                if j+read_len > len(gene):
                    break

                reads_seq.append(gene[j:j+read_len])
                reads_title.append(title+'-'+str(counter))
                counter+=1

            reads_seq.append(gene[-read_len:])
            reads_title.append(title+'-'+str(counter))
    
    print("Number of reads created:", len(reads_seq))
    
    with open("reads.fa", 'w') as file:
        for i in range(len(reads_seq)):
            file.write(reads_title[i]+'\n')
            file.write(reads_seq[i]+'\n')
        file.close()
    
    
def reference_remain():
    with open("new_data.fa") as file:
        number = len(file.readlines())//2
        print("Total gene remained in the dataset is: ", number)
        return number

def rename(filename):
    with open(filename) as file:
        database = file.readlines()
        file.close()
        text = ""
        counter = 0
        Gene = []
        Title = []
        for line in database:
            if line[0] == '>':
                Title.append(">"+str(counter))
                counter+=1
                if text != "":
                    Gene.append(text)
                    text=""
            else:
                text = text + line[:-1]
                
        Gene.append(text)
        
    with open("dataset.fa", 'w') as file:
        for i in range(len(Title)):
            file.write(Title[i]+'\n')
            file.write(Gene[i]+'\n')
        file.close()
    
Program_name = """

   =========================  RRP  ==========================
                    Recruit Refernece Program
                            V1.1.0
          Contact: Kenneth Shang <kenneth.shang@foxmail.com>
   ----------------------------------------------------------

"""

Help_message = """

========================  USAGE  =========================
   
  python3 recruit_ref.py [options] -n <reference number> -s <strides> -l <length>
   
======================== PARAMETERS ======================
   
  -h   print out usage information
  -n   total number of reference you want to recruit from the dataset 
  -s   strides for creating reads from the dataset
  -l   length of the reads that you want to use to creat reads from the dataset
  -t   number of threads that you want to use
   
======================== OUTPUT ===========================

   The output of RRP are as follow:
       data_remain.fa              references that remained.
       recruited_reference    folder of references recruited.

======================== EXAMPLE ==========================
   
  python3 recruit_ref.py -n 10 -s 10 -l 100 -f amo_database.fa

"""

def main():
    params = sys.argv
    num = 1
    stride_of_reads = 10
    length_of_reads = 100
    threads = '16'
    
    if len(params) == 1:
        print(Help_message)
        print("Error: Missing parameter!")
        return 0
    elif params[1] == '-h':
        print(Help_message)
        return 0
    elif len(params) < 9:
        print(Help_message)
        print("Error: Missing parameter!")
        return 0
    else:
        for i in range(1, len(params), 2):
            if params[i] == '-n':
                num = int(params[i+1])
            
            elif params[i] == '-s':
                stride_of_reads = int(params[i+1])
            
            elif params[i] == '-l':
                length_of_reads = int(params[i+1])
            
            elif params[i] == '-t':
                threads = params[i+1]
                
            elif params[i] == '-f':
                filename = params[i+1]
                
            else:
                print(Help_message)
                print("Error: Wrong parameters!")
                return 0
    
    rename(filename)
    print("Creating reads...")
    create_reads_first("dataset.fa", stride_of_reads, length_of_reads)
    os.system("mkdir Idx | mkdir Ref | mkdir recruited_reference | cp dataset.fa new_data.fa")
    
    for i in range(num):
        print("Finding the " + str(i+1) + "th reference.")
        print("====================== Reads mapping =======================")
        print("Log will save in LogFile")
        os.system("bowtie2-build --threads "+ threads +" -f new_data.fa Idx/IDX >LogFile")
        
        if i != 0:
            print("Creating reads...")
            create_reads(stride_of_reads, length_of_reads)
        
        os.system("bowtie2 -x Idx/IDX -p "+ threads +" -f reads.fa -S result.sam")
        os.system("samtools view -F 4 result.sam >mapped.sam")
        os.system("rm Idx/* | rm result.sam")
        print("Reads mapping complete!")
        
        
        print("================== Recruiting reference ====================")
        remove()
        os.system("rm mapped.sam")
        
        capture()
        os.system("rm filter.sam")
        
        reference, ref_title = find_most()
        os.system("rm read_gene")
        file_name = "reference"+str(i+1)+".fa"
        with open("recruited_reference/"+file_name, 'w') as file:
            file.write(reference)
            print("new reference gene saved!")
            file.close()
            
        print("================== Creating new sub-dataset ================")
        os.system("rm LogFile")
        os.system("bowtie2-build -f recruited_reference/"+ file_name +" Ref/IDX >LogFile" )
        os.system("bowtie2 -x Ref/IDX -p "+ threads +" -f reads.fa -S result.sam")
        os.system("samtools view -F 4 result.sam >mapped.sam")
        os.system("rm Ref/* | rm result.sam | rm reads.fa")
        create_new_database(ref_title)
        os.system("rm mapped.sam")
        print("new sub-dataset created!")
        os.system("rm LogFile")
        print("****NOTE****")
        remain = reference_remain()
        if remain == 0:
            print("***NOTE***")
            print("ALL genes in the dataset have been recruited")
            os.system("rm -rf Ref/ Idx/ | mv new_data.fa data_remain.fa")
            return 0
    os.system("rm -rf Ref/ Idx/ | mv new_data.fa data_remain.fa")
        


if __name__ == "__main__":
    print(Program_name)
    main()
    
        
