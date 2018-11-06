# Use the r-base docker to start from
FROM rocker/rstudio:3.5.0

RUN apt-get -y update \
  && apt-get install -y python \
  && apt-get install -y python-sympy python-pip python-setuptools python3-pip python-dev python3-dev \
  && apt-get install -y libcurl4-openssl-dev libssl-dev  zlib1g-dev libudunits2-dev libxml2-dev \
  && Rscript -e "install.packages(c('devtools','xpose','tidyr','shiny','shinydashboard','shinyBS','shinyAce'), repos = 'http://cran.us.r-project.org')" \
  && Rscript -e "install.packages(c('gridExtra','collapsibleTree','DT','R3port','RCurl'), repos = 'http://cran.us.r-project.org')" \
  && Rscript -e "devtools::install_github('ronkeizer/vpc')" \
  && Rscript -e "devtools::install_github('nlmixrdevelopment/n1qn1')" \
  && Rscript -e "devtools::install_github('nlmixrdevelopment/SnakeCharmR')" \
  && Rscript -e "install.packages(c('RxODE','nlmixr'), repos = 'http://cran.us.r-project.org')" \
  && Rscript -e "devtools::install_github('nlmixrdevelopment/xpose.nlmixr')" \
  && Rscript -e "devtools::install_github('richardhooijmaijers/shinyMixR')"

COPY examples /home/rstudio/examples
