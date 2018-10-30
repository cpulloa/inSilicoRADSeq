#!/bin/bash
#Align reads SE to reference genome H. pylori with BWA

p=$1; #entry file to run ./runBWA_SE.sh nameStrain e.g. ./runBWA_SE.sh 26695

ez_name1=AflII #name first enzyme
ez_name2=AseI #name second enzyme
exten=fastq #desired extension name
readLen=150

#Directory with SE sequencing reads
f=./reads/"${p}-${ez_name1}-${ez_name2}_reads.${exten}"
#Directory to reference genome
REFERENCE=./reference/GCF_000008525.1_ASM852v1_genomic_26695.fna

#Load java 
module load bwa/0.7.12
BWA_MEM="bwa mem"
module load jdk/1.8.0_121
JAVA=java
module load samtools/1.8
SAMTOOLS=samtools
PICARD=./software/picard_2.12.1.jar
NGSEP=./software/NGSEPcore_3.2.0.jar

#To align SE with BWA-MEM execute:
${BWA_MEM} -M -R "@RG\tID:${p}\tSM:${p}\tPL:ILLUMINA" ${REFERENCE} ${f} > ${p}_bwa.sam 2> ${p}_bwa.log

mkdir ${p}_tmp
#create bam file
${JAVA} -Xmx4g -jar ${PICARD} SortSam SO=coordinate CREATE_INDEX=true TMP_DIR=${p}_tmp I=${p}_bwa.sam O=${p}_bwa_sorted.bam >& ${p}_bwa_sort.log
rm -rf ${p}_tmp
rm ${p}_bwa.sam

 # calculate statistics from the alignments file
${JAVA} -Xmx3g -jar ${NGSEP} QualStats ${REFERENCE} ${p}_bwa_sorted.bam >& ${p}_bwa_readpos.stats
${JAVA} -Xmx3g -jar ${NGSEP} CoverageStats ${p}_bwa_sorted.bam ${p}_bwa_coverage.stats >& /dev/null
${SAMTOOLS} view -F 268 ${p}_bwa_sorted.bam | awk '{l=$9;if(l>=0){i=sprintf("%d",l/25)+1;if(i<100)a[i]++;else aM++}}END{for(i=1;i<100;i++)print (i-1)*25,a[i];print "More",aM}' >> ${p}_bwa_insertLength.stats;
${SAMTOOLS} stats ${p}_bwa_sorted.bam >& ${p}_bwa_samtools.stats

mv *.log ./log/SE/"${readLen}/${ez_name1}-${ez_name2}"/
mv *.stats ./stats/SE/"${readLen}/${ez_name1}-${ez_name2}"/
mv *sorted.bam ./bam/SE/"${readLen}/${ez_name1}-${ez_name2}"/
mv *sorted.bai ./bam/SE/"${readLen}/${ez_name1}-${ez_name2}"/
