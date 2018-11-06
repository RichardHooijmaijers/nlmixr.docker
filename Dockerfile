# Use the r-base docker to start
FROM rocker/rstudio:3.5.1

RUN apt-get -y update \
  && apt-get install -y \
              python \
              python-sympy python-pip python-setuptools python3-pip python-dev python3-dev \
              libcurl4-openssl-dev libssl-dev  zlib1g-dev libudunits2-dev libxml2-dev \
  && Rscript -e "install.packages(c('devtools','xpose','tidyr','shiny','shinydashboard','shinyBS','shinyAce','gridExtra','collapsibleTree','DT','R3port','RCurl','vpc','n1qn1','SnakeCharmR'), repos = 'http://cran.us.r-project.org')" \
  && Rscript -e "install.packages(c('RxODE','nlmixr'), INSTALL_opts = c("--install-tests"), repos = 'http://cran.us.r-project.org')" \
  && Rscript -e "devtools::install_github('nlmixrdevelopment/xpose.nlmixr')" \
  && Rscript -e "devtools::install_github('richardhooijmaijers/shinyMixR')"

COPY examples /home/rstudio/examples
