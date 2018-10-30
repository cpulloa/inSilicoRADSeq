#!/usr/bin/env bash
#StrAuto: Automation and Parallelization of STRUCTURE Analysis
#Version 1.0 http://strauto.popgen.org

#Maximum amount of memory to use
#PBS -l mem=30gb
#PBS -l walltime=194:00:00

#Set number of cores
#PBS -l nodes=1:ppn=24

#Set the name of the job, to replace
#PBS -N StrAuto

#Mail alert at start, end and abortion of execution
#PBS -m bea

#Send mail reports to this address
#PBS -M cp.ulloa530@uniandes.edu.co

##Loading required modules
module load anaconda/python2;
module load structure/2.3.4;

##Loading the virtual environment
source activate pythonenv;

##Software variables
STRUCTUREHARVESTER="/hpcfs/home/cp.ulloa530/TesisBCOM/software/structureHarvester";
STRAUTO="hpcfs/home/cp.ulloa530/TesisBCOM/software/strauto/strauto_1.py";
INPUT="hpcfs/home/cp.ulloa530/TesisBCOM/software/strauto/input.py"

##Adding structureHarvester to the execution path
export PATH=$STRUCTUREHARVESTER:$PATH;

#Entering the directory and running the analysis.
cd $PBS_O_WORKDIR;

##RUN THESE STEPS MANUALLY
#cp $INPUT .
#cp $STRAUTO . #Modify the files input.py of StrAuto for a particular vcf
#python strauto_1.py;
#StrAuto will generate the mainparams, extraparams and runstructure files to run parallel K pupulations in N runs each

#Running Structure Analysis
./runstructure > StrAuto_DArTseq.log;