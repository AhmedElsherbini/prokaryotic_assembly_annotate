
#########################################
#start: 12-07-2021
#update: 16-11-2021
echo "author:ahmed_elsherbini"

#########################################
"""
mkdir mqc
for f in *.fastq.gz;do fastqc -t 1 -f fastq -noextract $f;done
mv  *html mqc/
mv  *zip mqc/
cd mqc/
multiqc -z -o . .

"""
############################################################
#if you are gonna use unicycler 
#conda activate trim_galore
#parallel --xapply trim_galore --illumina --paired --fastqc -o trim_galore/ ::: *_R1_001.fastq.gz ::: *_R2_002.fastq.gz
############################################################
#depending on which strategy you may prefer !
"""
#conda activate shovill
#conda activate unicycler 
for file in *001.fastq.gz;

do

#2110-bk-d1-030_30_S30_R1_001.fastq.gz

#f = what is before _R1_001.fastq.gz

f=$(echo $file | sed -E "s/\_R1_001.fastq.gz*//");
#I work on HPC so I use what I used of memory
shovill --cpus 32 --ram 128 --trim -outdir "$f" --R1 "$f"_R1_001.fastq.gz --R2 "$f"_R2_001.fastq.gz

#Unicycler has also its own advantges. right?
#unicycler -t 12 -o "$f" --keep 2 --short1 "$f"_R1_001.fastq.gz --R2--short2 "$f"_R2_001.fastq.gz

done
"""

#################################################################
#here you will have many folders. sorry :))))
conda activate prokka
for d in */ ; do
    cd "$d"
    prokka contigs.fa
    cd ..
done
#################################################################

