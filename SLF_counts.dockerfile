###############################
# Dockerfile for SLF Pipeline #
###############################

FROM r-base@sha256:fff003a52d076e963396876b83cfa88c4f40a8bc27e341339cd3cc0236c1db79 as builder

WORKDIR /cromwell_root

ENV R_VERSION=4.1.2

RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    git \
    curl \
    g++ \
    zip \
    unzip \
    gzip \
    make \
    python3 \
    libssl-dev \
    libcurl4-openssl-dev \
    liblz4-dev \
    liblzma-dev \
    libncurses5-dev \
    libxml2-dev \
    libbz2-dev \
    libpng-dev \
    r-bioc-biomart \
    rysnc
    
    

#Install R packages

RUN echo "r <- getOption('repos'); r['CRAN'] <- 'https://cloud.r-project.org'; options(repos = r);" > ~/.Rprofile && \
    Rscript -e "install.packages('ggplot2')" && \
    Rscript -e "install.packages('stringr')" && \
    Rscript -e "install.packages('dplyr')" && \
    Rscript -e "install.packages('tidyr')"
    







