version 1.0

task SLF_comp_screen
{
    meta
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Calculate SLF and ZZ score from Concensus data using the comp screen pipeline.'
    }
    
    input
    {
        #Files & file paths
        File countdatapath #Input file
        String saverdsfilename = "mabs_output" #File name for saving the output
        String savefilepath = "${saverdsfilename}.rds"

        #Other Variables
        Boolean count_exact1
        String untreated_name
        String intcon_name 
        Int lowcountfilter
        Int lowcountfilter_untreated
        String docker_im = "ojasbard/concensus_images:slf_v1"
        Int? mem_gb = 32
    }

    command <<<
        set -e Rscript ${which SLF_compscreen.R} ~{countdatapath} ~{savefilepath} ~{count_exact1} ~{untreated_name} ~{intcon_name} ~{lowcountfilter} ~{lowcountfilter_untreated} 
    >>>
    
    runtime
    {
        cpu : 4
        docker : docker_im
        memory : mem_gb + 'G'
        maxRetries : 0
    }
    
    output
    {
        File rawcounts_subset = savefilepath
    }

    parameter_meta
    {
        countdatapath:   {
            description: 'Path to input',
            help: 'Summary table (.csv) that was produced by Concensus2 pipeline'
                        }
        savefilepath:    {
            description: 'Output path for both .rds and .csv files',
            help : 'Path to output where you want to save your final SLF and ZZ-score file.'
                        }
        count_exact1:    {
            description: 'Compute exact matches if T',
            help: 'Boolean to determine whether to compute exact matches for counts'
                        }     
        untreated_name:  {
            description: 'Name of negative control compound',
            example: 'DMSO'
                        }
        intcon_name: {
            description: 'Name of the internal spike-in controls',
            help: 'Common word shared by all internal spike-in controls excluding hypomorphs',
            example: 'PCR'
                        }            
    }
}


