#!/bin/bash

#make input directory file path
input="/work/binf8165/lml38336/final_proj/raw_data"

#make output directory file path for trimmed reads
output="/work/binf8165/lml38336/final_proj/trimmed"

#if output directory doesn't exist, create it
if [ ! -d $output ]
then
    mkdir -p $output
fi 

cd $SLURM_SUBMIT_DIR

# Load necessary modules
module load Java/13.0.2
module load Trimmomatic

# ======== CONFIGURATION ========
ADAPTERS="/work/binf8165/instructor_data/workDir/scripts/adapters.fa"
THREADS=1
MINLEN=50  # Minimum read length to keep
LEADING_QUAL=3
TRAILING_QUAL=3
SLIDINGWINDOW="4:15"

# ======== RUN TRIMMOMATIC ========
for i in {1,3,5,8,15,24,29,41,50,60}
do 
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar \
  PE -threads $THREADS -phred33 \
  $input/$i\_In_R1.fastq.gz $input/$i\_In_R2.fastq.gz \
  $output/$i\_In_R1_paired.fastq.gz $output/$i\_In_R1_unpaired.fastq.gz \
  $output/$i\_In_R2_paired.fastq.gz $output/$i\_In_R2_unpaired.fastq.gz \
  ILLUMINACLIP:$ADAPTERS:2:30:10 \
  LEADING:$LEADING_QUAL TRAILING:$TRAILING_QUAL \
  SLIDINGWINDOW:$SLIDINGWINDOW \
  MINLEN:$MINLEN
  done


java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.39.jar \
  PE -threads $THREADS -phred33 \
  $input/60_In_R1.fastq.gz $input/60_In_R2.fastq.gz \
  $output/60_In_R1_paired.fastq.gz $output/60_In_R1_unpaired.fastq.gz \
  $output/60_In_R2_paired.fastq.gz $output/60_In_R2_unpaired.fastq.gz \
  ILLUMINACLIP:$ADAPTERS:2:30:10 \
  LEADING:$LEADING_QUAL TRAILING:$TRAILING_QUAL \
  SLIDINGWINDOW:$SLIDINGWINDOW \
  MINLEN:$MINLEN
