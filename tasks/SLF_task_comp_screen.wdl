version 1.0

task SLF_comp_screen
{
    meta
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Calculate SLF and ZZ score from Concensus data using the comp screen pipeline'
    }
    
    input
    {
        #Files & file paths
        File countdatapath #Input file
        #String prefix 
        String savefilepath1 = "mabs_output.rds" #File name for saving the output

        #Other Variables
        String count_exact1="T"
        String untreated_name="DMSO"
        String intcon_name="PCR"
        Int lowcountfilter = 10
        Int lowcountfilter_untreated = 100
        String docker_image = "ojasbard/concensus_images:slf_v1"
        Int mem_gb = 32
        Int disk_gb = 100
    }

    command {
        echo "Starting R script"
        echo "${savefilepath1} is going to be the file output name" 
        Rscript /usr/local/bin/SLF_compscreen.R ${countdatapath} ${savefilepath1} ${count_exact1} ${untreated_name} ${intcon_name} ${lowcountfilter} ${lowcountfilter_untreated}
        ls
    }
    
    runtime
    {
        cpu : 4
        docker : docker_image
        memory : "${mem_gb} GB"
        disks : "local-disk ${disk_gb} LOCAL"
        maxRetries : 1
    }
    
    output
    {
        #File rawcounts_changed_columns = 
        File print_output = stdout()
        File rawcounts_subset = savefilepath1
    }

    parameter_meta
    {
        countdatapath:   {
            description: 'Path to input',
            help: 'Summary table (.csv) that was produced by Concensus2 pipeline'
                        }
        savefilepath1:    {
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


