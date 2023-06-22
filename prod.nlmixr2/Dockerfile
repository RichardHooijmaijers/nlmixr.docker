FROM rocker/verse:latest

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      cmake \
      libbz2-dev \
      libcairo2-dev \
      libcurl4-openssl-dev \
      libgit2-dev \
      libglpk40 \
      libgmp-dev \
      libhdf5-dev \
      liblzma-dev \
      libmpc-dev \
      libmpfr-dev \
      libpng-dev \
      libssl-dev \
      libudunits2-dev \
      libxml2-dev \
      libxt-dev \
      xclip \
      zlib1g-dev \
   && \
   apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages(c('tidyverse','xpose','RCurl','vpc','flextable','rmarkdown','patchwork'))"
RUN Rscript -e "install.packages(c('nlmixr2','xpose.nlmixr2','ggPMX'), INSTALL_opts = '--install-tests')"
RUN Rscript -e "devtools::install_github('richardhooijmaijers/shinyMixR')"

COPY examples /home/rstudio/examples
