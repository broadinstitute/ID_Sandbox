version 1.0

#Importing the necessary workflows
import "../tasks/SLF_task_comp_screen.wdl" as SLF_comp_sc

workflow slf_compscreen_wf
{
    meta 
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Calculate SLF and ZZ scores from Concensus data and save a rds file.'
    }
    input 
    {
        #Files & file paths
        File countdatapath #Input file
        #String prefix
        String? savefilepath1 = "mabs_output.rds" #Path to output for saving the .rds file

        #Other Variables
        String count_exact1="T"
        String untreated_name="DMSO"
        String intcon_name="PCR"
        Int lowcountfilter=10
        Int lowcountfilter_untreated=100
        Int? mem_gb = 32
        Int? disk_gb = 100
        String? docker="ojasbard/concensus_images:slf_v1"
    }
    call SLF_comp_sc.SLF_comp_screen as slf_cs{
        input:
            countdatapath = countdatapath,
            #prefix = prefix,
            savefilepath1 = savefilepath1,
            count_exact1 = count_exact1,
            untreated_name = untreated_name,
            intcon_name = intcon_name,
            lowcountfilter = lowcountfilter,
            lowcountfilter_untreated = lowcountfilter_untreated,
            mem_gb = mem_gb,
            disk_gb = disk_gb,
            docker_image = docker
    }
    output
    {
        File printed_stuff = slf_cs.print_output
        File slf_counts_rds = slf_cs.rawcounts_subset #output which is .rds file
    }
}