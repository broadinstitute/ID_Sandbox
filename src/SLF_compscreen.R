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
  countdatapath1 <- args[1]
  savefilepath <- args[2]
  count_exact1 <- args[3]
  untreated_name <- args[4]
  intcon_name = args[5]
  lowcountfilter = as.integer(args[6])
  lowcountfilter_untreated = as.integer(args[7])

  #Clean count data from Concensus2
  countdata = cleanfromConcensus2(rawcountpath = countdatapath1, count_exact = count_exact1)
  saveRDS(countdata, savefilepath, row.names = FALSE)
  #Calculate SLF and ZZ-scores
  #savefilepath_rds = paste0(gsub("\\..*","",savefilepath),".rds")
  #compScreenPipeline(countdata, untreatedname = untreated_name, intconname = intcon_name, comp_conc_separator = ":", lowwellcount = lowcountfilter, low_untreated_count = lowcountfilter_untreated, medianLFC = FALSE, newSchema = F, savefilename = savefilepath)
} 

main()