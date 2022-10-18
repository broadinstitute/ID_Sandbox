task Calculate_SLF_Score
{
    meta
    {
        author: 'Ojas Bardiya (bardiya@broadinstitute.org) at Broad Institute of MIT and Harvard'
        description: 'Calculate SLF and ZZ score from Concensus data task'
    }
    input
    {
        #Files
        File countdatapath #Since we're going to store this data in an external google bucket 
        File savefilepath
        
        #Other Variables
        Boolean count_exact1
        String untreated_name
        String intcon_name 
        Array[String] keep_colnames
        int lowcountfilter
        int lowcountfilter_untreated
    }

    command
    <<<
        Rscript ~{which SLF_Pipeline.R} ~{countdatapath} ~{savefilepath} ~{count_exact1} ~{untreated_name} ~{intcon_name} ~{lowcountfilter} ~{lowcountfilter_untreated} ~{keep_colnames}
    >>>
    
    runtime
    {
        container: #docker we need to run
    }
    
    output
    {
    
    }
    parameter_meta
    {
       countdatapath:
       {
       
       }
       savefilepath
       {
        
       }
    }
}


