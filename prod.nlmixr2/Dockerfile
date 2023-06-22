FROM rocker/verse:latest

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      libhdf5-dev \
      libxml2-dev \
      libpng-dev \
      libxt-dev \
      zlib1g-dev \
      libbz2-dev \
      liblzma-dev \
      libglpk40 \
      libgit2-dev \
      xclip \
      libcurl4-openssl-dev \
      libssl-dev \
      zlib1g-dev \
      libudunits2-dev \
      libxml2-dev \
      libcairo2-dev \
      cmake \
      libgmp-dev \
      libmpfr-dev \
      libmpc-dev \
   && \
   apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages(c('tidyverse','devtools','xpose','tidyr','shiny','shinydashboard','shinyBS','shinyAce','gridExtra','collapsibleTree','DT','R3port','RCurl','vpc','n1qn1','reticulate','flextable','rmarkdown','patchwork'));"
RUN Rscript -e "install.packages(c('rxode2','nlmixr2','xpose.nlmixr2','ggPMX'), INSTALL_opts = '--install-tests' )"
RUN Rscript -e "devtools::install_github('richardhooijmaijers/shinyMixR')"

COPY examples /home/rstudio/examples
