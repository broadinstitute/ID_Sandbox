suppressMessages(library(tidyr))
suppressMessages(library(dplyr))
suppressMessages(library(stringr))
#Path in the docker image
suppressMessages(source("/home/R/Functions_CompoundScreenPipelineSLF_210927.R"))

args <- commandArgs()
print(args)
countdatapath1 <- args[6]
savefilepath <- args[7]
count_exact1 <- args[8]
untreated_name <- args[9]
intcon_name = args[10]
lowcountfilter = as.integer(args[11])
lowcountfilter_untreated = as.integer(args[12])

countdata = cleanfromConcensus2(rawcountpath = countdatapath1, count_exact = count_exact1)

rds_output = compScreenPipeline(countdata, untreatedname = untreated_name, intconname = intcon_name, comp_conc_separator = ":", lowwellcount = lowcountfilter, low_untreated_count = lowcountfilter_untreated, medianLFC = FALSE, newSchema = F, savefilename = savefilepath)
saveRDS(rds_output, savefilepath)

#Clean count data from Concensus2
##countdata = cleanfromConcensus2(rawcountpath = countdatapath1, count_exact = count_exact1)
#saveRDS(countdata, savefilepath)
  
#Clean count data from Concensus2
##countdata = cleanfromConcensus2(rawcountpath = countdatapath1, count_exact = count_exact1)
#saveRDS(countdata, savefilepath)