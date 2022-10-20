task SLF_subset
{
    meta
    {
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Output a subset of columns of a file containing SLF and ZZ counts from comp screen pipeline.'
    }
    input
    {
        #Files & file inputs 
        String savefilepath #Path to output directory from comp screen pipeline
        File compscreen_rds #Input file which is the .rds file from comp screen pipeline
        
        #Other Variables
        Array[String] keep_colnames
        String docker
    }

    command
    <<<
        Rscript ~{which SLF_subset.R} ~{compscreen_rds} ~{keep_colnames} ~{savefilepath}
    >>>
    
    runtime
    {
        container: #TODO:path to SLF_counts.dockerfile -- pull it from dockerhub
    }
    
    output
    {
        File rawcounts_subset_csv = savefilepath + ".csv"
    }
    parameter_meta
    {
        compscreen_rds: {
            description: 'Input (.rds) file'
            help: 'Input file which is the .rds file from comp screen pipeline'
                        }
        keep_colnames: {
            description: 'Column names to keep in output file'
            help: 'Column names kept in final .csv file outputted'
            default: ['strain','compound','concentration','plate_name','row','column,count','rep,wellcount','wellcountfrac','std_lf,zscore_stdlf','zscore_stdlf2','correlation','log2FC']
                        }
    }
}
