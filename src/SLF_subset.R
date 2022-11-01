#10/28/20, jbagnall@broadinstitute.org
#Script for running SLF and ZZ-score pipeline
#Assumes input data is the output of Concensus2 pipeline (or ConcensusMap's cleaned counts)

#Command line call to script:
#Rscript SLFPipeline.R countdatapath1 savefilepath count_exact1 untreated_name intcon_name keep_colnames

suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
#Path in the docker image
suppressMessages(source("/home/R/Functions_CompoundScreenPipelineSLF_210927.R")) 

main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  file_rds <- args[1]
  keep_colnames = unlist(args[2])
  savefilepath <- args[3]

  #Save CSV file with chosen columns
  #savefilepath_csv = paste0(gsub("\\..*","",savefilepath),".csv")
  subsetSLF(screendata_path = file_rds, keep_columns = keep_colnames, savefilename = savefilepath)
} 

main()