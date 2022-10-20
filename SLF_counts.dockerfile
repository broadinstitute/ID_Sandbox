###############################
# Dockerfile for SLF Pipeline #
###############################

FROM r-base@sha256:fff003a52d076e963396876b83cfa88c4f40a8bc27e341339cd3cc0236c1db79 as builder

RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site

ENV R_LIBS_USER=/usr/local/lib/R
ENV DEBIAN_FRONTEND=noninteractive

#TODO:check to see if additional libraries are installed using ANTICONF
RUN apt-get update && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    git \
    curl \
    g++ \
    make \
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
RUN R --no-echo --no-restore --no-save -e "install.packages('tidyr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('stringr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('dplyr')"

#TODO: COPY R scripts here -- use /usr/local/bin if calling R script using which in workflow task








