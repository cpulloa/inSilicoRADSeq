#! /bin/bash
#Simulation RAD-Seq or ddRAD-Seq with ddRADSeqTools v0.45 
#Software package for in silico simulation and testing of double digest RADseq experiments
clear

#Move to the directory with all the genomes
cd genomes
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

#debugging print
#echo "${fFasta[0]}"
#Return to were the script is saved
cd ..
cd output
#create new folder with the name of the files
 mkdir "${fFasta[@]}"

size=0
for dir in */; 
do
 	mkdir -- "$dir/stats"
done

cd .. 

# Control parameters

if [ -n "$*" ]; then echo 'This script has not parameters.'; exit 1; fi

#-------------------------------------------------------------------------------

numGenomes=${#fFasta[@]}
#echo $numGenomes

# Set run environment
for (( j=0; j<numGenomes; j++))
do
GENOME=/genomes/"${fFasta[$j]}.fasta" #file
DDRADSEQTOOLSDDIR="$PWD"  # doutput/{fFasta[1]}Tools programs directory
GENOMESDIR=/genomes    						# genomes file directory
FRAGSDIR=/output/${fFasta[$j]}  		                    # fragments directory
READSDIR=/output/${fFasta[$j]}                           # reads directory
STATSDIR=/output/${fFasta[$j]}/stats                     # statistics directory

# echo "$GENOME"
# echo "$DDRADSEQTOOLSDDIR"
# echo "$FRAGSDIR"
# echo "$READSDIR"
# echo "$STATSDIR"
# echo "$GENOMESDIR"

ENZYME1=NlaIII # id of 1st restriction enzyme used in rsfile or its restriction site sequence
ENZYME2=AccB2I # id of 2nd restriction enzyme used in rsfile or its restriction site sequence
TECHNIQUE=IND1_IND2_DBR # IND1 (only index1), IND1_DBR (index1 + DBR), IND1_IND2 (index1 + index2) or IND1_IND2_DBR (index1 + index2 + DBR)
FORMAT=FASTQ # FASTA or FASTQ (format of fragments file)
READTYPE=PE  # SE (single-end) or PE (pair-end)
INDEX1LEN=6 # index sequence length in the adapter 1
INDEX2LEN=6 # index sequence length in the adapter 2 (it must be 0 when technique is IND1)
DBRLEN=4 # DBR sequence length (it must be 0 when technique is IND1 or IND1_IND2)
WEND=end91 # code used in endsfile corresponding to the end where the adapter 1 is
CEND=end92 # code used in endsfile corresponding to the end where the adapter 2 is
INDIVIDUALSFILE=individuals.txt  # path of individuals file

if [ `ulimit -n` -lt 1024 ]; then ulimit -n 1024; fi

#-------------------------------------------------------------------------------

# Generate genome fragments and get statistics

echo '**************************************************'
echo 'GENOME FRAGMENTS ARE BEING GENERATED FROM GENOME ...'
# genfile=./genomes/genome.fasta              # file of the reference genome in fasta format
# fragsfile=./results/fragments.fasta         # path of the fragments file
# rsfile=./restrictionsites.txt               # path of the restriction sites file
# enzyme1=EcoRI                               # id of 1st restriction enzyme used in rsfile or its restriction site sequence
# enzyme2=MseI                                # id of 2nd restriction enzyme used in rsfile or its restriction site sequence
# minfragsize=201                             # lower boundary of loci fragment's size
# maxfragsize=300                             # upper boundary of loci fragment's size
# fragstfile=./results/fragments-stats.txt    # path of the output statistics file
# fragstinterval=25                           # interval length of fragment size
# plot=YES                                    # statistical graphs: YES or NO
# verbose=YES                                 # additional job status info during the run: YES or NO
# trace=NO                                    # additional info useful to the developer team: YES or NO

/usr/bin/time \
    .$DDRADSEQTOOLSDIR/rsitesearch.py \
        --genfile=.$GENOME \
        --fragsfile=.$FRAGSDIR/"${fFasta[$j]}-$ENZYME1-$ENZYME2-fragments.fasta" \
        --rsfile=.$DDRADSEQTOOLSDIR/restrictionsites.txt \
        --enzyme1=$ENZYME1 \
        --enzyme2=$ENZYME2 \
        --minfragsize=150 \
        --maxfragsize=700 \
        --fragstfile=.$STATSDIR/"${fFasta[$j]}--$ENZYME1-$ENZYME2-fragments-stats.txt" \
        --fragstinterval=25 \
        --plot=YES \
        --verbose=YES \
        --trace=NO
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
done
