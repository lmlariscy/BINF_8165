#!/bin/bash
#SBATCH --job-name=run_metaphlan  		              # Job name
#SBATCH --partition=batch		                        # Partition (queue) name
#SBATCH --ntasks=1			                            # Single task job/single CPU
#SBATCH --cpus-per-task=8		                        # Number of cores per task - match this to the num_threads used by BLAST
#SBATCH --mem=32gb			                            # Total memory for job
#SBATCH --time=2:00:00  		                        # Time limit hrs:min:sec
#SBATCH --output=/work/binf8165/lml38336/log.%j			# Location of standard output and error log files (replace lml38336 with your myid)
#SBATCH --mail-user=lml38336@uga.edu                # Where to send mail (replace lml38336 with your myid)
#SBATCH --mail-type=ALL                             # Mail events (BEGIN, END, FAIL, ALL)

#make input directory file path
input="/work/binf8165/lml38336/final_proj/trimmed"

#make output directory file path
output="/work/binf8165/lml38336/final_proj/metaphlan_output"

#if output directory doesn't exist, create it
if [ ! -d $output ]
then
    mkdir -p $output
fi 

#make metaphlan database file path
db="/apps/eb/MetaPhlAn/4.1.1-foss-2022a/lib/python3.10/site-packages/metaphlan/metaphlan_databases"

cd $SLURM_SUBMIT_DIR

#load required modules
module load MetaPhlAn/4.1.1-foss-2022a

#run metaphlan
for i in {1,3,5,8,15,24,29,41,50,60}
do
metaphlan \
  $input/$i\_In_R1_paired.fastq.gz $input/$i\_In_R2_paired.fastq.gz \
  --input_type fastq \
  --bowtie2db $db \
  --nproc 8 \
  --bowtie2out $output/$i\_In_bowtie2.bz2 \
  --output_file $output/$i\_In__profile.txt
done
