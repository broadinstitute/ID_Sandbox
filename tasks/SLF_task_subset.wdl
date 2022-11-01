version 1.0

task SLF_subset
{
    meta
    {
        version: 'v0.1'
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Output a subset of columns of a file containing SLF and ZZ counts from comp screen pipeline'
    }
    input
    {
        #Files & file inputs 
        String prefix 
        #String savefilepath2 = "${prefix}.csv"
        File compscreen_rds #Input is the .rds file from comp screen pipeline

        
        #Other Variables
        Array[String] keep_colnames = ["strain","compound","concentration","plate_name","row","column,count","rep,wellcount","wellcountfrac","std_lf,zscore_stdlf","zscore_stdlf2","correlation","log2FC"]
        String docker_image = "ojasbard/concensus_images:slf_v1"
        Int? mem_gb = 32
        Int? disk_gb = 100
    }

    command <<<
        set -e Rscript $(which SLF_subset.R) ~{compscreen_rds} ~{keep_colnames} ~{"${prefix}.csv"}
    >>>
    
    runtime
    {
        cpu : 4
        docker : docker_image
        memory : mem_gb+'G'
        disks : 'local-disk ${disk_gb} LOCAL'
        maxRetries : 0
    }
    
    output
    {
        File rawcounts_subset_csv = "${prefix}.csv"
    }
    parameter_meta
    {
        compscreen_rds: {
            description: 'Input (.rds) file',
            help: 'Input .rds file from comp screen pipeline'
                        }
        keep_colnames: {
            description: 'Column names to keep in output file',
            help: 'Column names kept in final .csv file outputted',
            default: ['strain','compound','concentration','plate_name','row','column,count','rep,wellcount','wellcountfrac','std_lf,zscore_stdlf','zscore_stdlf2','correlation','log2FC']
                        }
    }
}
