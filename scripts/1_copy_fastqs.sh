#create input directory path
input="/work/binf8165/instructor_data/final_project_data"

#create output directory path
output="/work/binf8165/lml38336/final_proj/raw_data"

#if output directory doesn't exist, create it
if [ ! -d $output ]
then
    mkdir -p $output
fi       

#change directory
cd $output

#copy fastqs from instructor data folder
for i in {1,3,5,8,15,24,29,41,50,60}
do 
for x in {1..2}
do
cp $input/$i\_In_*_R$x\_001.fastq.gz $output/$i\_In_R$x\.fastq.gz
done
done
