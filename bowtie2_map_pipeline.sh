#!/bin/bash

START=$(date)

set -e
Mapping=~jenny/Eflux_Pumps_Raw_data_Genewiz/mapping

echo "-------------------------------------------------------------------------"
echo "STARTING MAPPING RUN LIST FILE:" $1
echo "START DATE:" $START
echo "MAPPING BWA REFERENCE GENOME H37Rv"
echo "-------------------------------------------------------------------------"

for i in `ls *.fastq.gz | cut -d "_" -f 1` ; #this line is important to run PE data (R1 and R2)

    do ~software/bowtie2-2.4.1-linux-x86_64/bowtie2 -p 20 -x ~jenny/Eflux_Pumps_Raw_data_Genewiz/mapping/MTB_H37Rv_Gref_NC_000962.3_inx -1 $i\_R1_paired2.fastq.gz -2 $i\_R2_paired2.fastq.gz -S $Mapping/$i.sam ;

        samtools view -bS -@ 16 $Mapping/$i.sam > $Mapping/$i.bam

        samtools sort -@ 16 $Mapping/$i.bam -o $Mapping/$i.sort.bam
done ;

echo " ## Finish mapping ......."
echo "------------------------------------"

# ---------------------------------------------------------------------------------------------------------------------$
# Finish script work here
# ---------------------------------------------------------------------------------------------------------------------$
FINISH=$(date)
echo "-------------------------------------------------------------------------" 
echo "TIME EXECUTION:"
echo "#  Start Time: $START"
echo "#  Finish Time: $FINISH"
echo "PROCESS COMPLETED : OK"
echo "-------------------------------------------------------------------------"
#--------------------------------------------------------------------------------------------------------------
