# nlmixr course PAGE2108
# Case example 0: Demo 
# Author: Teun Post, Richard Hooijmaijers
# This script shows how nlmixr can be used and to demo the shinyMixR interface

# --------------------------------------------------------
# Using nlmixr directly (in combination with xpose.nlmixr)
library(nlmixr)
library(xpose.nlmixr)
basemod <- function() {
  ini({
    tka <- .5
    tcl <- -3.2
    tv <- -1
    eta.ka ~ 1
    eta.cl ~ 2
    eta.v ~ 1
    add.err <- 0.1
  })
  model({
    ka <- exp(tka + eta.ka)
    cl <- exp(tcl + eta.cl)
    v <- exp(tv + eta.v)
    linCmt() ~ add(add.err)
  })
}

# run nlmixr with previously defined model (data is present in package!)
# print method shows most important results
fit <- nlmixr(basemod,theo_sd,est="nlme")
fit

# xpose.nlmixr makes xpose available for nlmixr results!
library(xpose.nlmixr)
xpdb <- xpose_data_nlmixr(fit)

dv_vs_pred(xpdb)
dv_vs_ipred(xpdb)
res_vs_pred(xpdb)
res_vs_idv(xpdb)
prm_vs_iteration(xpdb) ## ERROR!!!
absval_res_vs_idv(xpdb, res = 'IWRES')
absval_res_vs_pred(xpdb, res = 'IWRES')
ind_plots(xpdb, nrow=3, ncol=4)
res_distrib(xpdb)

# Resulting plots can be placed in object and adapted or saved to pdf/html
# using pdf() or R3port functions

# ---------------
# Using shinyMixR
library(shinyMixR)

# the package requires a specific folder structure
#create_proj()

# models are present as external files and can be submitted outside current R session
run_nmx("run1")
cat(readLines("./shinyMixR/temp/run1.prog.txt"),sep="\n")

# Results are saved in R data file (rds). A project object contains the latest info regarding projects
res1 <- readRDS("shinyMixR/run1.res.rds")
proj <- get_proj()

# Many functions within the package can be used in interactive session
overview()
tree_overview()
par_table(proj, "run1")

# plots are by default created using xpose.nlmixr but plain ggplots are also available
# results can be saved using the R3port package
gof_plot(res1)
fit_plot(res1, type="user")
fit_plot(res1, type="user",mdlnm = "run1",outnm="fits.html",show=TRUE)
pl <- nlmixr::vpc(res1,nsim=400,show=list(obs_dv=T))

# The shinydashboard interface can be started from within an R session
run_shinymixr(launch.browser=TRUE)

# For the demo perform the following:
# - load package and show what folders/files are created when running create_proj()
# - run the app and show the overview, how model notes can be adapted (and how this 
#   reflects the model itself by showing it in the edit widget)
# - Adapt reference model to show how this changes the tree view (and dofv)
# - Show "column visibilty",  "CSV" and collapsing boxes functionality of overview
# - Show "Edit" widget by selecting different models. make changes and save model
# - duplicate model and make some changes and select new model to show template models
# - Go to settings widget to show how editor settigs can be changed
# - Go back to overview and show how refresh should be used
# - Go to run widget and show how one model can be submitted (external, read in text file for progress)
# - Also show how two side-by-side models can be submitted and how progress is presented then
# - Show parameter estimates and how it can be used to compare model results. Here also show save option
#   for html --> Then show how it ends up in analysis widget (mention drawbacks for pdf!)
# - Create gof plot for a run (1) and save results as html
# - Go to settings widget to show how plot type settigs can be changed and remake plot for run1
# - Now also make ind fit plots and save results for html as well
# - Show scripts widget and indicate it can be used to create any type of results that can be scripted 
#   by user. If saving of results is done within shinyMixR structure it is also available within app
# - Show how different reports are made available when selecting different kind of models and results


########################### DUMP #######################
tmp <- get_proj()
run_nmx("run2")
meta <- proj_obj[["run2"]]$modeleval$meta

tmpl <- readLines(paste0(system.file(package = "shinyMixR"),"/Other/run_nmx.tmp"))

readLines("shinyMixR/temp/run2.prog.txt")
#tst <- eval(parse(text=c("try(nlmixrUI(",readLines('models/run1.r'),"))")))
overview()
tmp <- get_proj()

# moddir="./models"
# proj="./shinyMixR/project.rds"
# geteval=TRUE
# mdln    <- normalizePath(list.files(moddir,pattern="run[[:digit:]]*\\.[r|R]",full.names = TRUE))
# mdls   <- readRDS(proj)
# inproj <- unlist(sapply(mdls[names(mdls)[names(mdls)!="meta"]],"[",1))
# str(mdls)
# names(mdls)
# normalizePath(paste0(moddir,"/",names(mdls)[names(mdls)!="meta"],".r"))
# paste0(normalizePath(moddir),"/",names(mdls)[names(mdls)!="meta"],".r")
# inproj <- paste0(normalizePath(moddir),"/",names(mdls)[names(mdls)!="meta"],".r")
# todel  <- setdiff(toupper(inproj),toupper(mdln))
# themods <- sapply(mdls[names(mdls)[names(mdls)!="meta"]],function(x) x$model%in%todel)
# mdls <- mdls[c(sort(names(themods[!themods])),"meta")]
# list.files("models",full.names = TRUE)
mdln    <- normalizePath(list.files(moddir,pattern="run[[:digit:]]*\\.[r|R]",full.names = TRUE))
mdlnb   <- sub("\\.[r|R]","",basename(mdln))
mdls   <- readRDS(proj)
inproj <- names(mdls)[names(mdls)!="meta"]
todel  <- setdiff(tolower(inproj),tolower(mdlnb))
toadd  <- setdiff(tolower(mdlnb),tolower(inproj))

themods <- sapply(mdls[names(mdls)[names(mdls)!="meta"]],function(x) x$model%in%todel)
mdls <- mdls[c(sort(names(themods[!themods])),"meta")]
tmp <- mdls[c(sort(inproj[!inproj%in%todel]),"meta")]



#mdln[which(mdlnb%in%toadd)]
#normalizePath(paste0(moddir,"/",toadd,".r"))
mdls2 <- lapply(mdln[which(mdlnb%in%toadd)],list)
names(mdls2) <- toadd
for(i in 1:length(mdls2)){
  names(mdls2[[i]]) <- "model"
  if(geteval) mdls2[[i]]$modeleval <- eval(parse(text=c("try(nlmixrUI(",readLines(mdln[which(mdlnb%in%toadd)][i]),"))")))
}




# PART 2. ANALYSING THE RESULTS
library(xpose.nlmixr)

# ------------------------------
# 1. Using xpose.nlmixr directly 
xpdb <- xpose_data_nlmixr(fit)

dv_vs_pred(xpdb)
dv_vs_ipred(xpdb)
res_vs_pred(xpdb)
res_vs_idv(xpdb)
prm_vs_iteration(xpdb)
absval_res_vs_idv(xpdb, res = 'IWRES')
absval_res_vs_pred(xpdb, res = 'IWRES')
ind_plots(xpdb, nrow=3, ncol=4)
res_distrib(xpdb)
#nlmixr::vpc(fit,500, show=list(obs_dv=T),stratify = "dos")

# Results can be exported by using for example pdf(file="results.pdf") ... dev.off()

# ------------------------------------------------------
# 1. Using xpose.nlmixr/shinyMixr in interactive session
res      <- readRDS("shinyMixR/run1.res.rds")
xpdb2    <- xpose_data_nlmixr(res)

gof_plot(res)             # combine multiple GOF at once
prm_vs_iteration(xpdb2)   # xpose.nlmixr functions can be used directly
fit_plot(res,type="user") # "default ggplot" output can be created


nlmixr::vpc(res,500, show=list(obs_dv=T))

# Results can be exported by the function, using the R3port package or with pdf() function e.g.
# gof_plot(res,outnm="gofplot.tex",mdlnm="run1")
# pl <- prm_vs_iteration(xpdb2); R3port::ltx_plot(pl,out="plot.tex")
# pdf("results.pdf"); fit_plot(res); dev.off()

# -----------------------------------------
# 2. Using xpose.nlmixr/shinyMixr interface
# There are widgets for a few default plots, user scripts are possible in the script widget
# plots are by default saved in the analyis folder and made available in the interface
run_shinymixr()


