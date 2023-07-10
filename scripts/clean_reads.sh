#!/bin/bash
#clean_reads.sh

wkdir=""
bbdir="/cluster/home/ayocca/Alan_bin/bbmap/"

#would love to just stream stdin/out but since multiple files at once I think I need an intermediate
#try it I guess

for i in {1..8}; do
  r1=$(sed -n ${i}p r1_list.txt)
  r2=$(sed -n ${i}p r2_list.txt)
  out_base=$(sed -n ${i}p cleaned_list.txt)

  rm -f tmp_R1.fq
  rm -f tmp_R2.fq
  #there might be a way to do this without intermediate but screw it
  ${bbdir}/bbduk.sh in=${r1} in2=${r2} out=tmp_R1.fq out2=tmp_R2.fq \
  ref=${bbdir}/ribokmers.fa.gz
  
  ${bbdir}/bbduk.sh in=tmp_R1.fq in2=tmp_R2.fq out=${out_base}_R1.fq out2=${out_base}_R2.fq \
  ref=${bbdir}/TruSeq3-PE.fa minlength=25 ktrim=r

done
