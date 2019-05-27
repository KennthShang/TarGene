#!/usr/bin/env python3
import os
# Input Hint
filename = input("Input filename: ")
k = int(input("how many files you want to split to: "))


def main(filename, k):
    # Load the original file
    f = open(filename)
    with open("new_data.fa") as f:
        file = f.readlines()
        f.close()

    length = len(file)                   # Total length of the file
    length_seq = length//2               # Total number of seq(reads)
    length_seq_num = length_seq//int(k)  # Number of reads in each splitted file

    # Splitting the file
    for i in range(k-1):
        temp = file[i*length_seq_num*2:i*length_seq_num*2+length_seq_num*2]
        os.system("mkdir splitted"+str(i+1))
        with open("splitted"+str(i+1)+"/splitted"+".fa", 'w') as f:
            for L in temp:
                f.write(L)
            f.close()
        print("sub file: " + str(i+1) +" complete !")

    # For the Last splitted file, save all the remained reads
    os.system("mkdir splitted"+str(k))
    temp = file[(k-1)*length_seq_num:]
    with open("splitted"+str(k)+"/splitted"+".fa", 'w') as f:
        for L in temp:
            f.write(L)
        f.close()
    print("sub file: " + str(k) +" complete !")
    

Help_message = """

========================  USAGE  =========================
   
  python3 split.py [options] -n <file_name> -k <number_of_files>
   
======================== PARAMETERS ==========================
   
  -h   print out usage information
  -n   the name of the file that you want to split
  -k   number of files you want to splitted into
   
======================== EXAMPLE =========================
   
  python3 split.py -n dataset.fa -k 10

"""

if __name__ == "__main__":
    params = sys.argv
    if len(params) == 1:
        print(Help_message)
        print("Error: Missing parameter!")
        return 0
    elif params[1] == '-h':
        print(Help_message)
        return 0
    elif len(params) < 2:
        print(Help_message)
        print("Error: Missing parameter!")
        return 0
    elif len(params) > 2:
        print(Help_message)
        print("Error: Too many parameters!")
    else:
        for i in range(1, len(params), 2):
            if params[i] == '-n':
                file_name = params[i+1]
            
            elif params[i] == '-k':
                k = int(params[i+1])
    main(file_name, k)
    print("Program complete!")
