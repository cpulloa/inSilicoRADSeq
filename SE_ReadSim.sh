#! /bin/bash
#Simulates Single End (SE) sequencing reads for restriction fragments
clear

ENZYME1=HindIII
ENZYME2=AccB2I
READLen=150


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

numGenomes=${#fFasta[@]}
#echo $numGenomes

#debugging print
#echo "${fFasta[0]}"
#Return to were the script is saved
cd ..

# WGS Single End (SE) simulatior 0 errors
for (( j=0; j<numGenomes; j++))
do
#move to fasta fragment files

cd /Users/wendy_5819/Desktop/Tesis_BCOM/Results/ddRADseqTools-master/Package/output/"${fFasta[$j]}"

#echo "${fFasta[$j]}"
#generate reads with 0 sequencing erros in fastq format

#awk -v var='$READLen' '{if(NR%2==0 && length($0)>=var){print "@read_" NR;print substr($0,1,var);print "+";
#for (i=1;i<=var;i++)printf("a");print "";print "@read_" NR+1;print substr($0,length($0)-var,length($0));
#print "+";for (i=1;i<=var;i++)printf("a");print ""}}' "${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta" 
#> "${fFasta[$j]}-${ENZYME1}-${ENZYME2}_reads.fastq"

awk -v var="$READLen" '{if(NR%2==0 && length($0)>=var){print "@read_" NR;print substr($0,1,var);print "+";
for (i=1;i<=var;i++)printf("a");print "";print "@read_" NR+1;print substr($0,length($0)-var+1,length($0));
print "+";for (i=1;i<=var;i++)printf("a");print ""}}' "${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta" > "${fFasta[$j]}-${ENZYME1}-${ENZYME2}_reads.fastq"


#cd ..

done

cd ..

# WGS Single End (SE) simulatior 0 errors
for (( j=0; j<numGenomes; j++))
do
#move to fasta fragment files

cd /Users/wendy_5819/Desktop/Tesis_BCOM/Results/ddRADseqTools-master/Package/output/"${fFasta[$j]}"

#echo "${fFasta[$j]}"
#generate reads with 0 sequencing erros in fastq format
mv *.fastq /Users/wendy_5819/Desktop/Tesis_BCOM/Results/SeqSimulationsReads/SE_150/HindIII-AccB2I/
#cd ..

done

