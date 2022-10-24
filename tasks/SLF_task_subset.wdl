version 1.0

task SLF_subset
{
    meta
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Output a subset of columns of a file containing SLF and ZZ counts from comp screen pipeline.'
    }
    input
    {
        #Files & file inputs 
        String savefilepath #Path to output directory from comp screen pipeline
        String compscreen_rds #Input is file path to where the .rds file from comp screen pipeline is
        
        #Other Variables
        Array[String] keep_colnames
        String docker_im = "ojasbard/concensus_images:slf_v1"
    }

    command
    <<<
        Rscript ~{which SLF_subset.R} ~{compscreen_rds} ~{keep_colnames} ~{savefilepath}
    >>>
    
    runtime
    {
        container: docker_im
        maxRetries: 0
    }
    
    output
    {
        File rawcounts_subset_csv = savefilepath + ".csv"
    }
    parameter_meta
    {
        compscreen_rds: {
            description: 'File path to input (.rds) file'
            help: 'Input which is the file path to where the .rds file from comp screen pipeline is'
                        }
        keep_colnames: {
            description: 'Column names to keep in output file'
            help: 'Column names kept in final .csv file outputted'
            default: ['strain','compound','concentration','plate_name','row','column,count','rep,wellcount','wellcountfrac','std_lf,zscore_stdlf','zscore_stdlf2','correlation','log2FC']
                        }
    }
}
