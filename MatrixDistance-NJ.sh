#!/bin/bash
#Caluclate Distance MAtrix and Neighbor Joining (NJ) Tree for filtered vcf file

JAVA=java
NGSEP=/Users/wendy_5819/Desktop/Tesis_BCOM/Results/NGSEP/NGSEPcore_3.2.1.jar

ENZYME1=HindIII
ENZYME2=AccB2I
readlen=150
SEQ=PE

#FilterVCF <10% missing data
${JAVA} -jar ${NGSEP} FilterVCF -minI 101 Hpylori_variants-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}.vcf > Hpylori_variants-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}_FiltInd.vcf

# -------------------------------------------------------
# Calculation of genetic distance matrices from VCF files
# -------------------------------------------------------

# Generates a distance matrix from a variants file in VCF format. The matrix is
# calculated using the basic IBS (Identity by state) algorithm. However, four
# options to infer the genotype call information are implemented. In particular,
# users can choose predicted allele dosages of CNVs or direct estimations of
# allele dosage per site per individual based on relative allele-specific read
# counts. The latter option is useful to improve distance estimations in
# polyploids. It writes to standard output the matrix of genetic distances in a
# generic format.

# USAGE:

# java -jar NGSEPcore.jar VCFDistanceMatrixCalculator <OPTIONS> <VCF_FILE>

# OPTIONS:

# 	-t INT	: Matrix output format, 0 is full matrix, 1 lower-left matrix
# 		  and 2 is upper right matrix. Default: 0
# 	-s INT	: Source of information in the VCF file to calculate distances.
# 		  0 for simple genotype calls (GT format field), 1 for allele
# 		  copy number (ACN format field), 2 for total copy number
# 		  (total of ACN format field), and 3 for raw allele depth (ADP
# 		  or BSDP format fields). Default: 0
# 	-p INT	: Default ploidy of the samples. Used if the distance source
# 		  (-s option) is the raw allele depths to recalculate allele
# 		  dosage based on these counts. Default: 2

${JAVA} -jar ${NGSEP} VCFDistanceMatrixCalculator -p 1 Hpylori_variants-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}_FiltInd.vcf > Hpylori-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}_FiltInd-matrix.txt 

# --------------------------------------------------------
# Building dendograms using the Neighbor-Joining algorithm
# --------------------------------------------------------

# Given a distance matrix file, this command builds a dendogram for graphical
# display of genetic distances using the Neighbor Joining algorithm. The distance
# matrix can be provided as an upper, lower or full matrix. The dendogram is
# written to standard output in Newick format.

# USAGE:

# java -jar NGSEPcore.jar NeighborJoining <MATRIX_FILE>

${JAVA} -jar ${NGSEP} NeighborJoining Hpylori-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}_FiltInd-matrix.txt > Hpylori-${ENZYME1}-${ENZYME2}_${SEQ}_${readlen}_FiltInd.nwk 

