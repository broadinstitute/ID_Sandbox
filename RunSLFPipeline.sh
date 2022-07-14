#!/bin/bash
#$ -N SLF_Pipeline
#$ -l h_vmem=16G
#$ -l h_rt=72:00:00

# Use this script to run SLFPipeline.R to calculate SLF and ZZ-scores
# 10/28/20, jbagnall@broadinstitute.org
# 9/29/21, updated SLF script to exclude DMSO wells with technical error

source /broad/software/scripts/useuse
use UGER
use R-3.5

##############################################################################################
#        Please type your inputs below: (careful not to put extra spaces)                   #
##############################################################################################
#Path to input summary table that was produced by Concensus2 pipeline
countdatapath1="/broad/IDP-Dx_storage/Concensus_results/jbagnall/Concensus2_v2/jbagnall/SN0189539_mmsbc2/SN0189539_summary.csv"

#Path to output where you want to save your final SLF and ZZ-score file. No extension necessary. Pipeline will save an .rds and .csv file.
savefilepath="/broad/hptmp/jbagnall/SN0189539_SLF"


###########################################################################################
#               Other parameters (shouldn't need to be changed for each run):             #
###########################################################################################
#Do you want to use exact matches for counts (count_exact)? If so, type "T" otherwise type "F". 
#"F" means that it will use count_all, which includes mismatches (depends how you defined # allowed mismatches when running Concensus2)
count_exact1="T"

#What is the name of the negative control compound? Usually is "DMSO"
untreated_name="DMSO"

#What is the name of the internal spike-in controls. Should be a common word shared by them all, but not by hypomorphs, e.g. "control" for TB since PCR-control and Lysis-control share that word; was "PCR" for PA14 
intcon_name="PCR"

#What column names to keep in the final .csv output file. Default is to keep as written here. No spaces, and commas between column names
keep_colnames="strain,compound,concentration,plate_name,row,column,count,rep,wellcount,wellcountfrac,std_lf,zscore_stdlf,zscore_stdlf2,correlation,log2FC"

#Remove wells with counts less than or equal to this value, used 10 for TB, possibly makes more sense to use when there are spike-ins. Otherwise set to -1 to not filter out any wells (note: currently, it does not recognize the negative value and treats it as 1).
lowcountfilter=10

#Remove DMSO wells with counts less than or equal to this value, 100 seems reasonable, determined by the case where column 23 was not run in otavadrc, but produced counts < 100. 
#This is to remove DMSO wells with technical error prior to SLF calculation, without removing other compounds that may be well-killers.
lowcountfilter_untreated=100

#########################################################################################
#                      Run SLF/ZZ pipeline. Do not change.                              #
#########################################################################################
Rscript /idi/cgtb/jbagnall/pipelines/SLF_pipeline/SLFPipeline.R "$countdatapath1" "$savefilepath" "$count_exact1" "$untreated_name" "$intcon_name" $lowcountfilter $lowcountfilter_untreated "$keep_colnames" 
