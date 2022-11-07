###############################
# Dockerfile for SLF Pipeline #
###############################

FROM r-base@sha256:fff003a52d076e963396876b83cfa88c4f40a8bc27e341339cd3cc0236c1db79 as builder

RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site

ENV R_LIBS_USER=/usr/local/lib/R
ENV R_VERSION=4.1.2
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

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
    libncurses5-dev \
    r-bioc-biomart

#Install R packages
RUN R --no-echo --no-restore --no-save -e "install.packages('tidyr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('stringr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('dplyr')"

#RUN /usr/local/lib/R

#WORKDIR /home/

#Copying R scripts -- use /usr/local/bin if calling R script using which in workflow task
RUN mkdir -p /home/R/
COPY src/Functions_CompoundScreenPipelineSLF_210927.R /home/R/

COPY src/SLF_compscreen.R /usr/local/bin/
COPY src/SLF_subset.R /usr/local/bin/
COPY src/test.R /usr/local/bin/









