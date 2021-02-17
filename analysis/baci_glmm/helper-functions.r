# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Helper functions that will be used in the BACI R Markdown reports.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

load_install_packages <- function(){
  # List of packages to be used in the R session
  .packages = c("lme4", "AICcmodavg", "MuMIn", "pbkrtest", "optimx",
                "parallel", "data.table", "blmeco", "lsmeans",
                "ggplot2", "plotly" , "directlabels")
  # Install CRAN packages (if not already installed)
  .inst <- .packages %in% installed.packages()
  if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
  # Attach packages
  sapply(.packages, require, character.only = TRUE)
}

exploratory_plot <- function(varb){
  set.seed(2020)
  
  preliminary_plot <- 
    ggplot(data = baci_dt, 
           aes(x = as.integer(Year), 
               y = get(varb),
               group    = treatment_ci,
               color    = treatment_ci,
               linetype = treatment_ci)) +
    # add Before-After vertical line
    geom_vline(xintercept = 2015.5,
               lty        = "dashed",
               colour     = "gray60",
               size       = 0.6)+
    # plot data points, jitter-dodged by treatment
    geom_point(aes(shape = treatment_ci),
               size  = 1, 
               alpha = 0.5,
               position = position_jitterdodge(jitter.width  = 0.15,
                                               jitter.height = 0,
                                               dodge.width   = 0.5)) +
    # set type of observation point shape
    scale_shape_manual(name   = 'Treatment',
                       breaks = c("control", "impact"),
                       values = c("control" = 1,
                                  "impact"  = 2)) + 
    # set color of observation points; 
    # this will trickle down to mean lines below 
    # because color was specified in as aes in ggplot() call above.
    scale_color_manual(name   = 'Treatment',
                       values = c("control" = "#F8766D", 
                                  "impact"  = "#2869D7")) + # orig was #00BFC4
    # add mean lines
    stat_summary(fun  = "mean", 
                 geom   = "line", 
                 size   = 1,
                 show.legend = TRUE) +
    # add lines for each site
    stat_summary(data = baci_dt, 
                 aes(group = site_f),
                 fun  = "mean", 
                 geom  = "line", 
                 size  = 0.3,
                 alpha = 0.5) +
    # add labels with the sites at the start and end of each site line
    geom_dl(aes(label = site_f),
            method = list(dl.combine("first.points", "last.points"))) +
    # set manually the type of line
    scale_linetype_manual(name = 'Treatment',
                          breaks = c("control", "impact"),
                          values = c("control" = "twodash",
                                     "impact"  = "solid")) +
    # do not use tranparency in the legend for points (do not let it trickle down to legend)
    guides(shape=guide_legend(override.aes=list(alpha=c(1,1)))) +
    # set axis labels
    labs(x = "Year", 
         y = varb) +
    theme_bw()
  
  return(preliminary_plot)
}

interaction_plot <- function(estimates, varb){
  estimates_df <- as.data.frame(summary(estimates))
  
  # depending on the link function, the 3rd column can be called rate or
  # response, so rename it to "predicted"
  colnames(estimates_df)[3] <- "predicted"
  
  estimates_df$period_ba <- factor(x = estimates_df$period_ba, 
                                   levels = c("before","after"), 
                                   ordered = TRUE)
  
  pd <- position_dodge(width = 0.05)
  
  inter_plot <- 
    ggplot(data = estimates_df, 
           aes(x = period_ba, 
               y = predicted, 
               group = treatment_ci,
               color = treatment_ci)) +
    # add the points (means)
    geom_line(position = pd, 
              lwd = 0.5) +
    # set manually the color for lines
    scale_color_manual(name   = 'Treatment',
                       values = c("control" = "#F8766D", 
                                  "impact"  = "#2869D7")) +
    # add means as points
    geom_point(size = 1.5, 
               position = pd) +
    # plot 95% CIs
    geom_errorbar(aes(ymax = asymp.UCL, 
                      ymin = asymp.LCL), 
                  size = 0.2, 
                  width = 0.15, 
                  linetype = "solid", 
                  position = pd) +
    # set axis labels
    labs(x = "Period", 
         y = varb) +
    # adjust the distance (gap) of OX from OY axes
    scale_x_discrete(expand = c(0, 0.2)) +
    theme_bw()
  
  return(inter_plot)
}