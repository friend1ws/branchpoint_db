#! /usr/bin/env bash

# for branch point (currently just for hg19)
# wget http://genome.cshlp.org/content/suppl/2014/12/16/gr.182899.114.DC1/Supplemental_DataS2.bed.gz

zcat MercerEtAl2015/Supplemental_DataS2.bed.gz | sort -k1,1 -k2,2n - | bgzip -c > branchpoint_mercer.bed.gz
zcat MercerEtAl2015/Supplemental_DataS2.bed.gz | awk '{OFS="\t"; gsub("chr","",$1); print $0}' - | sort -k1,1 -k2,2n - | bgzip -c > branchpoint_mercer.grc.bed.gz
tabix -p bed branchpoint_mercer.bed.gz
tabix -p bed branchpoint_mercer.grc.bed.gz


# for branch point (currently just for hg19)
awk -F ',' 'NR>1 {OFS="\t"; $5 = $1 "_" $2 "_" $3 "_" $11; $2 = $2 - 1; print $1,$2,$3,$5,"0",$4}' SignalEtAl2016/gencode_v19_branchpoints.csv | \
    sort -k1,1 -k3,3n - | bgzip -c > branchpoint_signal.bed.gz
awk -F ',' 'NR>1 {OFS="\t"; $5 = $1 "_" $2 "_" $3 "_" $11; gsub("chr","",$1); $2 = $2 - 1; print $1,$2,$3,$5,"0",$4}' SignalEtAl2016/gencode_v19_branchpoints.csv | \
    sort -k1,1 -k3,3n - | bgzip -c > branchpoint_signal.grc.bed.gz
tabix -p bed branchpoint_signal.bed.gz
tabix -p bed branchpoint_signal.grc.bed.gz


