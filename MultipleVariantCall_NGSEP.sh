#! /bin/bash
##Script for running NGSEP##
#Maximum amount of memory to use
#PBS -l mem=4gb
#PBS -l walltime=240:00:00

#Set number of cores
#PBS -l nodes=1:ppn=3

#Set the name of the job, to replace
#PBS -N runMultisampleVariantsDetector

#Mail alert at start, end and abortion of execution
#PBS -m bea

#Send mail reports to this address
#PBS -M cp.ulloa530@uniandes.edu.co

#Print standard output and standard error
#PBS -k oe

#Input parameters
REFERENCE=/hpcfs/home/cp.ulloa530/TesisBCOM/reference/GCF_000008525.1_ASM852v1_genomic_26695.fna
ENZYME1=complete

module load jdk/1.8.0_121
JAVA=java
NGSEP=/hpcfs/home/cp.ulloa530/TesisBCOM/software/NGSEPcore_3.2.0.jar
DIR=/hpcfs/home/cp.ulloa530/TesisBCOM/bam/complete


## --------------------------------------
## Calling variants over multiple samples
## --------------------------------------
${JAVA} -jar ${NGSEP} MultisampleVariantsDetector -h 0 -ploidy 1 -r ${REFERENCE} -o ${DIR}/Hpylori_variants-${ENZYME1}.vcf ${DIR}/26695_bwa_sorted.bam ${DIR}/J99_bwa_sorted.bam ${DIR}/F16_bwa_sorted.bam ${DIR}/F30_bwa_sorted.bam ${DIR}/F32_bwa_sorted.bam ${DIR}/F57_bwa_sorted.bam ${DIR}/OK113_bwa_sorted.bam ${DIR}/OK310_bwa_sorted.bam ${DIR}/26695-12_bwa_sorted.bam ${DIR}/26695-1CH_bwa_sorted.bam ${DIR}/26695-1CL_bwa_sorted.bam ${DIR}/NY40_bwa_sorted.bam ${DIR}/ML1_bwa_sorted.bam ${DIR}/ML2_bwa_sorted.bam ${DIR}/ML3_bwa_sorted.bam ${DIR}/51_bwa_sorted.bam ${DIR}/HPAG1_bwa_sorted.bam ${DIR}/Shi470_bwa_sorted.bam ${DIR}/G27_bwa_sorted.bam ${DIR}/P12_bwa_sorted.bam ${DIR}/v225d_bwa_sorted.bam ${DIR}/52_bwa_sorted.bam ${DIR}/Sat464_bwa_sorted.bam ${DIR}/SJM180_bwa_sorted.bam ${DIR}/PeCan4_bwa_sorted.bam ${DIR}/Cuz20_bwa_sorted.bam ${DIR}/35A_bwa_sorted.bam ${DIR}/908_bwa_sorted.bam ${DIR}/India7_bwa_sorted.bam ${DIR}/Gambia94_24_bwa_sorted.bam ${DIR}/Lithuania75_bwa_sorted.bam ${DIR}/SouthAfrica7_bwa_sorted.bam ${DIR}/2017_bwa_sorted.bam ${DIR}/2018_bwa_sorted.bam ${DIR}/83_bwa_sorted.bam ${DIR}/ELS37_bwa_sorted.bam ${DIR}/Puno120_bwa_sorted.bam ${DIR}/Puno135_bwa_sorted.bam ${DIR}/Santal49_bwa_sorted.bam ${DIR}/XZ274_bwa_sorted.bam ${DIR}/Shi417_bwa_sorted.bam ${DIR}/Shi169_bwa_sorted.bam ${DIR}/Shi112_bwa_sorted.bam ${DIR}/PeCan18_bwa_sorted.bam ${DIR}/Aklavik86_bwa_sorted.bam ${DIR}/Aklavik117_bwa_sorted.bam ${DIR}/HUP-B14_bwa_sorted.bam ${DIR}/26695-13_bwa_sorted.bam ${DIR}/Rif1_bwa_sorted.bam ${DIR}/Rif2_bwa_sorted.bam ${DIR}/UM032_bwa_sorted.bam ${DIR}/UM299_bwa_sorted.bam ${DIR}/UM037_bwa_sorted.bam ${DIR}/UM066_bwa_sorted.bam ${DIR}/UM298_bwa_sorted.bam ${DIR}/SouthAfrica20_bwa_sorted.bam ${DIR}/oki102_bwa_sorted.bam ${DIR}/oki112_bwa_sorted.bam ${DIR}/oki128_bwa_sorted.bam ${DIR}/oki154_bwa_sorted.bam ${DIR}/oki422_bwa_sorted.bam ${DIR}/oki673_bwa_sorted.bam ${DIR}/oki828_bwa_sorted.bam ${DIR}/oki898_bwa_sorted.bam ${DIR}/BM012A_bwa_sorted.bam ${DIR}/BM012S_bwa_sorted.bam ${DIR}/J166_bwa_sorted.bam ${DIR}/BM013A_bwa_sorted.bam ${DIR}/BM012B_bwa_sorted.bam ${DIR}/BM013B_bwa_sorted.bam ${DIR}/SS1_bwa_sorted.bam ${DIR}/Hp238_bwa_sorted.bam ${DIR}/26695-1_bwa_sorted.bam ${DIR}/26695-1MET_bwa_sorted.bam ${DIR}/J99-2_bwa_sorted.bam ${DIR}/L7_bwa_sorted.bam ${DIR}/DU15_bwa_sorted.bam ${DIR}/CC33C_bwa_sorted.bam ${DIR}/ausabrJ05_bwa_sorted.bam ${DIR}/K26A1_bwa_sorted.bam ${DIR}/PNG84A_bwa_sorted.bam ${DIR}/7C_bwa_sorted.bam ${DIR}/29CaP_bwa_sorted.bam ${DIR}/PMSS1_bwa_sorted.bam ${DIR}/B128_1_bwa_sorted.bam ${DIR}/G272_bwa_sorted.bam ${DIR}/HPJP26_bwa_sorted.bam ${DIR}/7_13_D1a_bwa_sorted.bam ${DIR}/7_13_D1b_bwa_sorted.bam ${DIR}/7_13_D1c_bwa_sorted.bam ${DIR}/7_13_D3a_bwa_sorted.bam ${DIR}/7_13_D3b_bwa_sorted.bam ${DIR}/7_13_D3c_bwa_sorted.bam ${DIR}/7_13_R1a_bwa_sorted.bam ${DIR}/7_13_R1b_bwa_sorted.bam ${DIR}/7_13_R1c_bwa_sorted.bam ${DIR}/7_13_R2a_bwa_sorted.bam ${DIR}/7_13_R2b_bwa_sorted.bam ${DIR}/7_13_R2c_bwa_sorted.bam ${DIR}/7_13_R3a_bwa_sorted.bam ${DIR}/7_13_R3b_bwa_sorted.bam ${DIR}/7_13_R3c_bwa_sorted.bam ${DIR}/26695-dRdM1dM2_bwa_sorted.bam ${DIR}/26695-dRdM2_bwa_sorted.bam ${DIR}/dRdM1_bwa_sorted.bam ${DIR}/26695-dR_bwa_sorted.bam ${DIR}/dRdM2addM2_bwa_sorted.bam ${DIR}/FDAARGOS_300_bwa_sorted.bam ${DIR}/FDAARGOS_298_bwa_sorted.bam ${DIR}/B38_bwa_sorted.bam ${DIR}/B8_bwa_sorted.bam ${DIR}/NCTC11637_bwa_sorted.bam ${DIR}/HE101_09_bwa_sorted.bam ${DIR}/HE143_09_bwa_sorted.bam ${DIR}/HE132_09_bwa_sorted.bam ${DIR}/HE178_09_bwa_sorted.bam ${DIR}/HE141_09_bwa_sorted.bam ${DIR}/HE170_09_bwa_sorted.bam ${DIR}/HE136_09_bwa_sorted.bam ${DIR}/HE171_09_bwa_sorted.bam ${DIR}/HE134_09_bwa_sorted.bam ${DIR}/HE147_09_bwa_sorted.bam ${DIR}/HE142_09_bwa_sorted.bam ${DIR}/BCM-300_bwa_sorted.bam ${DIR}/HE93_10_v1_bwa_sorted.bam > ${DIR}/Hpylori-${ENZYME1}-VCF.log 
##Summary stats vcf
${JAVA} -jar ${NGSEP} SummaryStats ${DIR}/Hpylori_variants-${ENZYME1}.vcf > ${DIR}/sumstats_Hpylori_variants-${ENZYME1}.txt

##Filter for SNP in at least 100 individuals
##${JAVA} -jar ${NGSEP} FilterVCF -minI 100 Hpylori_variants-${ENZYME1}.vcf > Hpylori_variants-${ENZYME1}_Ind100.vcf
