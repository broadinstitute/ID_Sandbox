version 1.0

#Importing the necessary workflows
import "../tasks/SLF_task_comp_screen.wdl" as SLF_comp_sc
import "../tasks/SLF_task_subset.wdl" as SLF_sub

workflow SLF_wf 
{
    meta 
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Calculate SLF and ZZ scores from Concensus data and save a csv file containing a subset of columns selected.'
    }
    input 
    {
        #Files & file paths
        File countdatapath #Input file
        String savefilepath #Path to output for saving the .rds and .csv file 
        
        #Other Variables
        Boolean count_exact1
        String untreated_name
        String intcon_name 
        Int lowcountfilter
        Int lowcountfilter_untreated
        Array[String] keep_colnames
        String? docker_file
    }
    call SLF_comp_sc.SLF_comp_screen as slf_cs{
        input:
            countdatapath = countdatapath,
            savefilepath = savefilepath,
            count_exact1 = count_exact1,
            untreated_name = untreated_name,
            intcon_name = intcon_name,
            lowcountfilter = lowcountfilter,
            lowcountfilter_untreated = lowcountfilter_untreated,
            docker_im = docker_file
    }
    call SLF_sub.SLF_subset as slf_sb{
        input:
            savefilepath = savefilepath,
            compscreen_rds = slf_cs.rawcounts_subset_path, #.rds file path from comp screen pipeline
            keep_colnames = keep_colnames,
            docker_im = docker_file
    }
    output
    {
        File slf_counts_rds = slf_cs.rawcounts_subset #output which is .rds file
        File slf_counts_subset_csv = slf_sb.rawcounts_subset_csv #output which is .csv file
    }
}