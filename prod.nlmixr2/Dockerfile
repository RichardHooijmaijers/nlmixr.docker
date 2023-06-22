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

RUN mkdir -p /srv/r-installation
COPY *.R *.sh /srv/r-installation

# Run all files ending with "sh"; then cleanup any apt installation remnants
RUN run-parts --exit-on-error --verbose --regex '.*sh' /srv/r-installation && \
    apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY examples /home/rstudio/examples
