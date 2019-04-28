# inSilicoRADSeq
Repository of the Masters thesis project in computational biology titled: "In silico RAD-Seq as a possible tool for ancestry determination: an application in Helicobacter pylori"
1. Simulation reads of the reference genome: simread_WholeGenome_wgsim.sh
2. Restriction enzymes fragment generations for RAD-Seq and ddRAD-Seq simulations: ddRADseqTools_Hpylori_Frags.sh
3. Form the Fragments .fasta files in step 2 to generate illumina simulations of Pared End (PE_ReadSim.sh) and Single End (SE_ReadSim.sh). 
To run this illumina simulations the script needs the java project SimpleReadsSim.zip. 
4. From the illumina .fastq files in step 3 reads are mapped to the reference genome of the PE and SE reads: runBWA_PE.sh and runBWA_SE.sh
5. Finding SNPS form the .bam files in step 4. :MultipleVariantCall_NGSEP.sh
To run correctly this script need the .bai files form step 4, even though they are not used explicity called in the script.
6. Build distance matrix from the .vcf files in step 5 and calculate the Neighbor joining dendrograms: MatrixDistance-NJ.sh
7. Run structure analysis with StrAuto pipeline (http://strauto.popgen.org) from STR file: runStrAuto.sh
To run this file convert the vcf file in step 5 to str with software PGDSpider_2.1.1.5 (http://www.cmpg.unibe.ch/software/PGDSpider/)
8. Plot structure analysis: structurePlot.m.
To run this file use only the probability of each population (columns) of each sample (rows) once the best k has been chosen. 
