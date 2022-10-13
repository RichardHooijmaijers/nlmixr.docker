# This is an example script to check if nlmixr models
# can be submitted and that all packages work as expected

# Step 1: load applicable packages
library(nlmixr2)
library(xpose.nlmixr2)
library(shinyMixR)

# Step 2: run a simple nlmixr model
theo_mdl <- function() {
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

fit <- nlmixr2(theo_mdl,theo_sd,est="saem")
fit

# Step 3: Create plots with xpose.nlmixr
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

# Step 4: run shinymixR (make sure you allow pop-ups in the browser!)
create_proj()
run_shinymixr(launch.browser=TRUE)
