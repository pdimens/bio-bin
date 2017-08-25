#!/usr/bin/env python

# This script is used to take -hardy input from VCFtools, 
# calculate a Benjamini-Hochberg corrected alpha value, 
# and output a new file of contigs that are significant
# in >1 position 

#### basic argument housekeepting ####

import sys

if len(sys.argv)<2:
    print(" \n Taking -hardy input from VCFtools, and outputing a new file of contigs that are significant in >1 position after Benjamini-Hochberg alpha correction\n" )
    print("Usage: ", __file__ , " path/to/input/file","\n OPTIONAL: strict (default is empty)", "\n strict does BH corrections on only indiividuals with >50% heterozygosity\n")
    sys.exit()

else: 
    raw_array = open(sys.argv[1])
    structured_array=[]
    num_lines = sum(1 for line in open(sys.argv[1]))
   
    # create raw array
    for i in range(0,num_lines-1):
        structured_array.append(raw_array.readline().split())
    overall_loci=len(structured_array)-1
    print("total number of loci: ",overall_loci)

##### the 50% cutoff ######

if len(sys.argv)>2:
    structured_array.pop(0)
    for i in structured_array:
        del i[3:5]
        del i[4:6]
        i[-1]=float(i[-1])    #convert last column to floats
    heterozygosity_array=[]
    for i in structured_array:
        i[2]=i[2].rsplit('/')  #split hom/het columns
        for each in i[2]:
            i.append(int(each))
        if (i[-2]/(i[-1]+i[-2]+i[-3])) > 0.5:
            heterozygosity_array.append(i)
        else:
            continue
    for newitems in heterozygosity_array: #keep only the relevant stuff, i.e. contig, position, and P
        del newitems[2]
        del newitems[3:6]

    structured_array= heterozygosity_array     #rename it "structured_array" to reduce code redundancy

    print("number of loci with heterozygosity >50%: ", len(structured_array))

##### no cutoff #####

else:    
# clean up raw array by removing unneaded columns
    structured_array.pop(0)
    for i in structured_array:
        del i[2:5]
        del i[3:5] 
        i[-1]=float(i[-1])    #convert last column to floats
    
####### sorting by P value #######
total_loci=len(structured_array)    # get the number of total loci
structured_array.sort(key=lambda x:x[-1])    

##### adding a rank to each row #####
ranks= 1
for items in structured_array:
    items.append(ranks)
    ranks += 1
    
###### appending Benjamini-Hochberg corrected alpha ######
for i in structured_array:
    i.append(float(0.05/total_loci)*i[-1])
    
##### create new array from significant differneces ######
significant_array=[]
significant_contigs=[]
for i in structured_array:
    if i[-3] < i[-1]:
        significant_array.append(i[0:2])   #for the file output
        significant_contigs.append(i[0])   #for the next counting step
    else:
        continue  
print("loci significantly deviated after B-H correction: ",len(significant_contigs))              
   
#### write first output file of significant contig positions ####
with open ('sig_positions.txt','w') as sig_pos:
    sig_pos.writelines('\t'.join(i) + '\n' for i in significant_array)

#### count occurances of each contig #####
frequencytable={}
for contig in significant_contigs:
    if contig in frequencytable:
        frequencytable[contig] += 1
    else:
        frequencytable[contig] = 1
for every in frequencytable:
    with open("position_counts.txt", "a") as countfile:
        countfile.write(every + " " + str(frequencytable[every])+ '\n')
#### pull all contigs > 1 occurence into new list and output file ####
contigs_multipe_sign_positions=[]
for contigs in frequencytable:
    if frequencytable[contigs]>1:
        contigs_multipe_sign_positions.append(contigs)
        with open("sig_multiple_positions.txt", "a") as myfile:
            myfile.write(contigs+'\n')    
print("significant contigs occuring more than once: ",len(contigs_multipe_sign_positions)) 
print("\n outputs:", "\n 1. sig_positions.txt : significant loci (contigs and positions)", "\n 2. position_counts.txt: unique contigs x number of sig positions","\n 3. sig_multiple_positions.txt : contigs with sig positions > 1")