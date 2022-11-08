version 1.0

#Importing the necessary tasks
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
        String? savefilepath1 = "mabs_output.rds" 
        String? savefilepath2 = "mabs_output.csv"
        #String prefix

        #Other Variables
        String count_exact1="T"
        String untreated_name="DMSO"
        String intcon_name="PCR"
        Int lowcountfilter = 10
        Int lowcountfilter_untreated = 100
        Array[String]? keep_colnames=["strain","compound","concentration","plate_name","row","column,count","rep,wellcount","wellcountfrac","std_lf,zscore_stdlf","zscore_stdlf2","correlation","log2FC"]
        String? docker="ojasbard/concensus_images:slf_v1"
    }
    call SLF_comp_sc.SLF_comp_screen as slf_cs{
        input:
            countdatapath = countdatapath,
            savefilepath1 = savefilepath1,
            count_exact1 = count_exact1,
            untreated_name = untreated_name,
            intcon_name = intcon_name,
            lowcountfilter = lowcountfilter,
            lowcountfilter_untreated = lowcountfilter_untreated,
            docker_image = docker
    }
    call SLF_sub.SLF_subset as slf_sb{
        input:
            savefilepath2 = savefilepath2,
            compscreen_rds = slf_cs.rawcounts_subset, #.rds file from comp screen pipeline
            keep_colnames = keep_colnames,
            docker_image = docker
    }
    output
    {
        File slf_counts_rds = slf_cs.rawcounts_subset #output which is .rds file
        File slf_counts_subset_csv = slf_sb.rawcounts_subset_csv #output which is .csv file
    }
}