#! /bin/bash
#Generates simulation reads for the whole genome analysis with wgsim v1.0


# Wgsim is a small tool for simulating sequence reads from a reference genome.
# It is able to simulate diploid genomes with SNPs and insertion/deletion (INDEL)
# polymorphisms, and simulate reads with uniform substitution sequencing errors.
# It does not generate INDEL sequencing errors, but this can be partly
# compensated by simulating INDEL polymorphisms.

# Wgsim outputs the simulated polymorphisms, and writes the true read coordinates
# as well as the number of polymorphisms and sequencing errors in read names.
# One can evaluate the accuracy of a mapper or a SNP caller with wgsim_eval.pl
# that comes with the package.
#wgsim Options
#     -e FLOAT      base error rate [0.000]
   #       -d INT        outer distance between the two ends [500]
   #       -s INT        standard deviation [50]
   #       -N INT        number of read pairs [1000000]
   #       -1 INT        length of the first read [70]
   #       -2 INT        length of the second read [70]
   #       -r FLOAT      rate of mutations [0.0000]
   #       -R FLOAT      fraction of indels [0.00]
   #       -X FLOAT      probability an indel is extended [0.00]
   #       -S INT        seed for random generator [-1]
   #       -A FLOAT      disgard if the fraction of ambiguous bases higher than FLOAT [0.05]
   #       -h            haplotype mode
clear

   

readLen=250


#Move to the directory with all the genomes
GENOMESPATH=/Users/wendy_5819/Downloads/wgsim-master/genomes_test
PROGRAMPATH=/Users/wendy_5819/Downloads/wgsim-master
OUTPATH=/Users/wendy_5819/Downloads/wgsim-master/wgsim-output/



cd $GENOMESPATH
#create array with all genome files
files=( * )
#initializa counter for array
size=0
#declare array that contain file names
declare -a fFasta
#for to store all array names to array without file extension
for f in *.fasta; 
do
	fFasta[size++]=$(echo "$f" | cut -f 1 -d '.')
done

numGenomes=${#fFasta[@]}
#echo $numGenomes

cd $PROGRAMPATH
# WGS Single End (SE) simulatior 0 errors
for (( j=0; j<numGenomes; j++))
do
#move to fasta fragment files

NAMEINPUT="${fFasta[$j]}"".fasta"
NAMEOUTPUT1="${fFasta[$j]}"".read1.fastq" 
NAMEOUTPUT2="${fFasta[$j]}"".read2.fastq"

./wgsim -1250 -2250 -d500 -r0 -e0 -R0 -X0 $NAMEINPUT $NAMEOUTPUT1 $NAMEOUTPUT2
gzip *.fastq

done

mv *.gz "$OUTPATH"
rm *.fasta 