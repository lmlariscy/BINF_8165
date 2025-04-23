#make input directory file path
input="/work/binf8165/lml38336/final_proj/trimmed"

#make output directory file path for fastQC
output="/work/binf8165/lml38336/final_proj/fastQC_trimmed"

#if output directory doesn't exist, create it
if [ ! -d $output ]
then
    mkdir -p $output
fi   

# Load required modules
module load FastQC/0.11.9-Java-11

# FastQC for trimmed reads
for i in {1,3,5,8,15,24,29,41,50,60}
do 
fastqc $input/$i\_In_R1_paired.fastq.gz $input/$i\_In_R2_paired.fastq.gz -o $output
done

#copy fastQC htmls to github
for i in {1,3,5,8,15,24,29,41,50,60}
do
for x in {1..2}
do
cp $output/$i\_In_R$x\_paired_fastqc.html /work/binf8165/lml38336/final_proj/BINF_8165/fastQC_trimmed/$i\_In_R$x\_paired_fastqc.html
done
done