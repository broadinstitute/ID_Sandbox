version 1.0

#Importing the necessary tasks
import "../tasks/SLF_task_subset.wdl" as SLF_sub

workflow slf_subset_wf 
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
        File compscreen_rds_output #Input file from compscreen pipeline
        String? savefilepath2 = "mabs_output.csv"
        #String prefix

        #Other Variables
        String? keep_colnames="strain,compound,concentration,plate_name,row,column,count,rep,wellcount,wellcountfrac,std_lf,zscore_stdlf,zscore_stdlf2,correlation,log2FC"
        Int? mem_gb = 32
        Int? disk_gb = 100
        String? docker="ojasbard/concensus_images:slf_v1"
    }
    call SLF_sub.SLF_subset as slf_sb{
        input:
            savefilepath2 = savefilepath2,
            compscreen_rds = compscreen_rds_output,
            keep_colnames = keep_colnames,
            mem_gb = mem_gb,
            disk_gb = disk_gb,
            docker_image = docker
    }
    output
    {
        File slf_counts_subset_csv = slf_sb.rawcounts_subset_csv #output which is .csv file
    }
}