#! /bin/bash
#Simulates Paired End (PE) sequencing reads for restriction fragments
#It requires java script project: SimpleReadsSim package: simulation class: PE_simulator and NGSEP v3.2.1.
clear

ENZYME1=HindIII
ENZYME2=AccB2I
PATHfrags=/Users/wendy_5819/Desktop/Tesis_BCOM/Results/ddRADseqTools-master/Package/output
javaPE_sim=/Users/wendy_5819/Documents/workspace/SimpleReadsSim

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
cd $PATHfrags/"${fFasta[$j]}"

#remove space form fragments file exam:>fragment: 1
sed -e 's/fragment: /fragment:/g' -i .bak "${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta"
	
#move to java project file
cd ~
cd $javaPE_sim/

#run simple PE simulator algorithm to change read length directly un eclipse
java -Xmx4g -cp lib/NGSEPcore_3.2.1.jar:bin simulation.PE_simulator $PATHfrags/"${fFasta[$j]}"/"${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta"

#move to fasta fragment files
cd ~
cd $PATHfrags/"${fFasta[$j]}"

#remove copy file without spaces
rm "${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta"
#rename *.bak files to just fasta
file="${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta.bak" 
name=$(echo "$file" | sed -e 's/\.[^.]*$//')
mv "${fFasta[$j]}-${ENZYME1}-${ENZYME2}-fragments.fasta.bak" $name

done

cd ..

# WGS Single End (SE) simulatior 0 errors
for (( j=0; j<numGenomes; j++))
do
#move to fasta fragment files

cd /Users/wendy_5819/Desktop/Tesis_BCOM/Results/ddRADseqTools-master/Package/output/"${fFasta[$j]}"

#echo "${fFasta[$j]}"
#generate reads with 0 sequencing erros in fastq format
mv *.fastq /Users/wendy_5819/Desktop/Tesis_BCOM/Results/SeqSimulationsReads/PE_150/HindIII-AccB2I/
#cd ..

done
