# Header ####
rm(list = ls())
library(ggplot2)
library(GGally) # Comparing variables and data exploration
library(mgcv) # Library to fit gams
library(gratia) # Modern library for visualizing and assessing gams
library(visreg)
library(dplyr)
library(tidyr)
library(xtable)
library(tibble)

# Paths & constants ####
# - - - - - - - - - - - -

project_path = './'

# Inputs
data_path = paste0(project_path, '../data/')

# Outputs
graphs_path = paste0(project_path, '../graphs/')
output_path = paste0(project_path, '../data/')

# Colour-blind palette. Colours are HTML codes
# To change codes, use: https://www.w3schools.com/colors/colors_picker.asp
cbPalette <- c("#939393", "#E69F00", "#0072B2", "#CC00CC", "#009E73", "#D55E00", "#CC79A7", "#FF3300", "#F0E442", "#56B4E9")

# Functions
# - - - - -

worst_concurvity <- function(m){
  concurvity_matrix <- concurvity(m, full=F)$worst
  # Remove any interaction terms
  concurvity_matrix <- concurvity_matrix[,!grepl('^ti[(]', colnames(concurvity_matrix))]
  concurvity_matrix <- concurvity_matrix[!grepl('^ti[(]', rownames(concurvity_matrix)),]
  # Remove concurvities of parameters with themselves
  concurvity_matrix <- concurvity_matrix[which(concurvity_matrix < 1)]
  return(max(concurvity_matrix))
}

concurvity_list <- function(model_list){
  conc_list <- c()
  for (m in model_list){
    conc_list <- append(conc_list, worst_concurvity(m))
  }
  return(conc_list)
}

r2_list <- function(model_list){
  r2_list <- c()
  for (m in model_list){
    r2_list <- append(r2_list, summary(m)$r.sq)
  }
  return(r2_list)
}

# 1) Preparing data ####
# - - - - - - - - - - - -
# https://towardsdatascience.com/producing-insights-with-generalized-additive-models-gams-cf2b68b1b847

df <- read.csv(paste0(data_path, 'li600_dataset_summarised.csv'))
# df$species  <- factor(df$species, levels = c("Nit-A", "Nit-S", "Rep-S"))
# df$season   <- factor(df$season, levels = c("autumn", "winter", "spring", "summer"))
# df$leaf_age <- factor(df$leaf_age, levels = c("Yng", "Mid", "Old"))
# df$daytime  <- factor(df$daytime, levels = c("morning", "noon", "afternoon"))

temp <- df


"co2_mole_fraction"
df$timestamp <- as.POSIXct(df$timestamp, format = "%Y-%m-%d %H:%M:%S")
plt = ggplot(df)
plt = plt + geom_point(aes(x=timestamp, y=co2_mole_fraction))
plt = plt + theme_bw()
plt = plt + theme(axis.title.x = element_blank(),
                  axis.text.x = element_text(angle = 45, hjust = 1))
plt = plt + scale_x_datetime(date_labels = "%b",      # label format: month only
                         date_breaks = "1 month"  # one tick per month
)
plt
ggsave(paste0(graphs_path, 'supplement/mole_frac_timeline.jpg'), width=18, height=12, units = "cm", dpi = 600)
ggsave(paste0(graphs_path, 'supplement/mole_frac_timeline.pdf'), width=18, height=12, units = "cm", dpi = 600)


# 2) Data exploration ####
# - - - - - - - - - - - -

names(temp)

temp$doy <- as.numeric(strftime(temp$timestamp, "%j"))
temp$doy_hydro <- temp$doy - 91
temp[which(temp$doy_hydro < 1),]$doy_hydro <- temp[which(temp$doy_hydro < 1),]$doy_hydro + 365

figure_df <- temp[,c("species","gsw_median", "VPDleaf_median", "Tleaf_median",
                                                   "Qamb_median", "wind_speed", "co2_mole_fraction", "SWC_1_1_1")]
plt <- ggpairs(figure_df,
               columnLabels = c("Type", "g[sw]", "VPD[L]", "T[L]", "PAR", "u", "x[CO[2]]", "SWC"), labeller='label_parsed',
               lower = list(continuous = wrap("points", alpha = 0.3,    size=0.1), 
                            combo = wrap("dot", alpha = 0.4,            size=0.2) ),
               ggplot2::aes(colour = figure_df$species),
               upper = list(continuous = wrap("cor", size = 2.5))) +
  theme_bw() + 
  theme(text=element_text(family="serif"), axis.text.x = element_text(angle = -90, vjust = 0.5, hjust=1))
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt
ggsave(paste0(graphs_path, 'pairs_summarised.jpg'), width=18, height=18, units = "cm", dpi = 600)
ggsave(paste0(graphs_path, 'pairs_summarised.pdf'), width=18, height=18, units = "cm", dpi = 600)

# 3) GAMs ####
# - - - - - - 
# https://noamross.github.io/gams-in-r-course/chapter2

temp <- df
names(temp)

temp$species <- as.factor(temp$species)
temp$daytime <- as.factor(temp$daytime)
temp$leaf_age <- as.factor(temp$leaf_age)
temp$season <- as.factor(temp$season)

temp2 <- temp[which((temp$season == "summer" | temp$season == "winter")),]
temp2$species <- as.factor(paste(temp2$species))
temp2$species_season <- as.factor(paste(temp2$species, temp2$season))
temp2$species_season_daytime <- as.factor(paste(temp2$species, temp2$season, temp2$daytime))
summary(temp2$species_season)


temp$species_season <- as.factor(paste(temp$species, temp$season))
temp$species_leafage <- as.factor(paste(temp$species, temp$leaf_age))
temp$species_leafage_season <- as.factor(paste(temp$species, temp$leaf_age, temp$season))
temp$species_leafage_daytime <- as.factor(paste(temp$species, temp$daytime, temp$season))
temp$species_leafage_season

# FINAL MODEL
mX <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(SWC_1_1_1, by=species, k=5) +
            s(co2_mole_fraction, by=species, k=5) +
            s(Qamb_median, by=species, k=4) +
            species,
          data=temp2, method='REML', select=T)

AIC(mX)
summary(mX)
concurvity(mX, full=F)$worst
gam.check(mX)

# Per-type p-values of each fitted smooth, for annotation on Figure 3
# (Reviewer comment 3). Values are read straight off summary(mX)$s.table;
# nothing is refitted or recomputed.
s_tab <- summary(mX)$s.table
p_rows <- function(term) {
  rn <- rownames(s_tab)
  keep <- grepl(paste0("s(", term, "):species"), rn, fixed = TRUE)
  sp <- sub(paste0("s(", term, "):species"), "", rn[keep], fixed = TRUE)
  p  <- s_tab[keep, "p-value"]
  ord <- match(levels(temp2$species), sp)   # colour order = factor level order
  ord <- ord[!is.na(ord)]
  data.frame(species = sp[ord],
             txt = ifelse(p[ord] < 0.001, "P < 0.001",
                          paste0("P = ", ifelse(p[ord] >= 0.01,
                                                sprintf("%.2f", p[ord]),
                                                sprintf("%.4f", p[ord])))),
             stringsAsFactors = FALSE)
}
# Annotation layer: one coloured line per plant type, matching the fitted lines
p_annot <- function(term) {
  pr <- p_rows(term)
  annotate("text", x = -Inf, y = Inf, hjust = -0.10,
           vjust = seq(1.7, by = 1.4, length.out = nrow(pr)),
           label = paste0(pr$species, ": ", pr$txt),
           colour = cbPalette[seq_len(nrow(pr))],
           size = 2.6, family = "serif")
}

p = visreg(mX,"VPDleaf_median", by="species", data = temp2,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(mX, xvar = "VPDleaf_median", by="species", data = temp2, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(VPDleaf_median, visregFit, linetype=species, fill=species, colour=species))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=species), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + p_annot("VPDleaf_median")
plt = plt + scale_y_continuous(expand = expansion(mult = c(0.05, 0.28)))
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste("VPD"["L"]," [kPa]")),
                 y = expression(paste(g['sw']," [",mol~m^{-2}~s^{-1},"]")),
                 colour='Type', fill='Type', linetype='Type')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position.inside = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste('VPD'['L'],' contribution to ','g'['sw'])))
plt1 <- plt


p = visreg(mX,"Qamb_median", by="species", data = temp2,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(mX, xvar = "Qamb_median", by="species", data = temp2, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(Qamb_median, visregFit, linetype=species, fill=species, colour=species))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=species), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + p_annot("Qamb_median")
plt = plt + scale_y_continuous(expand = expansion(mult = c(0.05, 0.28)))
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste("PAR"[L]," [",mu,mol~m^{-2}~s^{-1},"]")),
                 y = expression(paste(g['sw']," [",mol~m^{-2}~s^{-1},"]")),
                 colour='Type', fill='Type', linetype='Type')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position.inside = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste('PAR'[L],' contribution to ','g'['sw'])))
plt2 <- plt

p = visreg(mX,"SWC_1_1_1", by="species", data = temp2,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(mX, xvar = "SWC_1_1_1", by="species", data = temp2, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(SWC_1_1_1, visregFit, linetype=species, fill=species, colour=species))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=species), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + p_annot("SWC_1_1_1")
plt = plt + scale_y_continuous(expand = expansion(mult = c(0.05, 0.28)))
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste("SWC [%]")),
                 y = expression(paste(g['sw']," [",mol~m^{-2}~s^{-1},"]")),
                 colour='Type', fill='Type', linetype='Type')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position.inside = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste('SWC contribution to ','g'['sw'])))
plt3 <- plt

p = visreg(mX,"co2_mole_fraction", by="species", data = temp2,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(mX, xvar = "co2_mole_fraction", by="species", data = temp2, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(co2_mole_fraction, visregFit, linetype=species, fill=species, colour=species))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=species), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + p_annot("co2_mole_fraction")
plt = plt + scale_y_continuous(expand = expansion(mult = c(0.05, 0.28)))
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste(x[CO['2']]," [",mu,mol~mol^{-1},"]")),
                 y = expression(paste(g['sw']," [",mol~m^{-2}~s^{-1},"]")),
                 colour='Type', fill='Type', linetype='Type')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position.inside = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste(x[CO['2']],' contribution to ','g'['sw'])))
plt4 <- plt


library(ggpubr)
library(cowplot)

legend <- get_legend(plt1)
plt1 <- plt1 + theme(legend.position = "none")
plt2 <- plt2 + theme(legend.position = "none")
plt3 <- plt3 + theme(legend.position = "none")
plt4 <- plt4 + theme(legend.position = "none")

plts <- ggarrange(plt1, plt2,
                  plt3, plt4,
                  labels = c("(a)", "(b)",
                             "(c)", "(d)"),
                  ncol = 2, nrow = 2)

final_plot <- plot_grid(plts, legend, ncol = 2, rel_widths = c(1, 0.1))
final_plot
ggsave(paste0(graphs_path, 'model_output_all.jpg'), width = 21, height = 20, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model_output_all.pdf'), width = 21, height = 20, units = "cm", dpi = 1200)

# 4) Model selection ####
# - - - - - - - - - - - -

# Tleaf & VPDleaf can't be in the same model due to high concurvity

# Parameter selection. Concurvity issues:
# TL or VPD
# TL or Qamb
# VPD or Qamb
# Then add CO2 frac, SWC and wind speed


# # TL or VPD (high concurvity)
# m1 <- gam(gsw_median ~ s(Tleaf_median, by=species, k=5) +
#             s(VPDleaf_median, by=species, k=5) +
#             species,
#           data=temp2, method='REML', select=T)

# # TL or Qamb (high concurvity)
# m2 <- gam(gsw_median ~ s(Tleaf_median, by=species, k=5) +
#             s(Qamb_median, by=species, k=4) +
#             species,
#           data=temp2, method='REML', select=T)

# # VPD or Qamb (high concurvity)
# m3 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
#             s(Qamb_median, by=species, k=4) +
#             species,
#           data=temp2, method='REML', select=T)

# Now that VPD is selected
# Add co2_mole_frac
m1 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(co2_mole_fraction, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# PAR & co2
m2 <- gam(gsw_median ~ s(Qamb_median, by=species, k=4) +
            s(co2_mole_fraction, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# TL & co2
m3 <- gam(gsw_median ~ s(Tleaf_median, by=species, k=5) +
            s(co2_mole_fraction, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# Check SWC
m4 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(SWC_1_1_1, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

m5 <- gam(gsw_median ~ s(Qamb_median, by=species, k=4) +
            s(SWC_1_1_1, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

m6 <- gam(gsw_median ~ s(Tleaf_median, by=species, k=5) +
            s(SWC_1_1_1, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# Check wind speed
m7 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(wind_speed, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

m8 <- gam(gsw_median ~ s(Qamb_median, by=species, k=4) +
            s(wind_speed, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

m9 <- gam(gsw_median ~ s(Tleaf_median, by=species, k=5) +
            s(wind_speed, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# CO2 & SWC (final selected model)
# In spite of having 3x3 (leaf ages & daytimes) datapoints per species per day, I still have significant results!
m10 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(co2_mole_fraction, by=species, k=5) +
            s(SWC_1_1_1, by=species, k=5) +
            species,
          data=temp2, method='REML', select=T)

# While slightly better, concurvity is worse!
# Here, concurvity between VPD and PAR is >0.87, which is lower than concurvity between VPD & SWC for Rep-S
m11 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
             s(SWC_1_1_1, by=species, k=5) +
             s(co2_mole_fraction, by=species, k=5) +
             s(Qamb_median, by=species, k=4) +
             species,
           data=temp2, method='REML', select=T)

# Create model comparison after renaming
comparison_df <- AIC(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11)
comparison_df <- rownames_to_column(comparison_df)
names(comparison_df)[names(comparison_df) == 'rowname'] <- 'model'
comparison_df$r2 <- r2_list(list(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11))
comparison_df$concurvity <- concurvity_list(list(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11))
comparison_df <- comparison_df[order(comparison_df$AIC, decreasing = F), ]
comparison_df

# Save as latex
print.xtable(xtable(comparison_df, digits=c(0,0,2,0,2,2)), file = paste0(graphs_path, 'model_comparison.tex'),
             include.rownames=F)

concurvity(m10, full=F)$worst
concurvity(m11, full=F)$worst

plt = ggplot(temp2)#[which(temp2$species == 'Rep-S'),])
plt = plt + geom_point(aes(x=VPDleaf_median, y=SWC_1_1_1, colour=species))
plt

m15 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
            s(wind_speed, by=species, k=5) +
            s(SWC_1_1_1, by=species, k=5) +
            s(co2_mole_fraction, by=species, k=5) +
            s(Qamb_median, by=species, k=4) +
            species,
          data=temp2, method='REML', select=T)


# # FINAL MODEL
# # In spite of having 3x3 (leaf ages & daytimes) datapoints per species per day, I still have significant results!
# mX <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
#             s(SWC_1_1_1, by=species, k=5) +
#             s(co2_mole_fraction, by=species, k=5) +
#             s(Qamb_median, by=species, k=4) +
#             species,
#           data=temp2, method='REML', select=T)

m16 <- gam(gsw_median ~ s(VPDleaf_median, by=species, k=5) +
             s(co2_mole_fraction, by=species, k=5) +
             s(Qamb_median, by=species, k=4) +
             species,
           data=temp2, method='REML', select=T)
concurvity(m16, full=F)$worst
# SWC <-> VPDleaf > 0.8
# Rep-S Qamb - VPD

# Create model comparison after renaming
comparison_df <- AIC(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15)
comparison_df <- rownames_to_column(comparison_df)
names(comparison_df)[names(comparison_df) == 'rowname'] <- 'model'
comparison_df$r2 <- r2_list(list(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15))
comparison_df$concurvity <- concurvity_list(list(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15))
comparison_df <- comparison_df[order(comparison_df$AIC, decreasing = F), ]
comparison_df

# Save as latex
print.xtable(xtable(comparison_df, digits=c(0,0,2,0,0,2,2)), file = paste0(graphs_path, 'model_comparison.tex'),
             include.rownames=F)

# Plot of interactions
# - - - - - - - - - - -

plt <- draw(mX, contour = T, n = 50, select=5, too.far = 0.002)
plt[[1]]$labels$caption <- NULL # Remove
plt[[1]]$labels$title <- NULL # Remove
plt <- plt + scale_fill_gradient2(low='#2166AC', mid='#eaeaea', high='#9c1a16', na.value="#ffffff00",
                                                  limits = c(-0.01, 0.01))
plt <- plt + metR::geom_text_contour(aes(z = est), stroke = 0.15)
plt <- plt + theme_bw()
plt <- plt + theme(legend.position = "right",
                                   text=element_text(family="serif"),
                                   plot.title = element_text(hjust = 0.5))
plt <- plt + ggtitle(expression(paste("Droughted: ",'g'['t,CO'],' & Tr contrib. to f'['CO'])))
#plt <- plt + labs(x=expression(paste("time_since_last_event_s")),
#                  y=expression(paste("P_cum_mm")))
plt

plt <- draw(mX, contour = T, n = 50, select=6, too.far = 0.002)
plt[[1]]$labels$caption <- NULL # Remove
plt[[1]]$labels$title <- NULL # Remove
plt <- plt + scale_fill_gradient2(low='#2166AC', mid='#eaeaea', high='#9c1a16', na.value="#ffffff00",
                                  limits = c(-0.08, 0.08))
plt <- plt + metR::geom_text_contour(aes(z = est), stroke = 0.15)
plt <- plt + theme_bw()
plt <- plt + theme(legend.position = "right",
                   text=element_text(family="serif"),
                   plot.title = element_text(hjust = 0.5))
plt <- plt + ggtitle(expression(paste("Droughted: ",'g'['t,CO'],' & Tr contrib. to f'['CO'])))
#plt <- plt + labs(x=expression(paste("time_since_last_event_s")),
#                  y=expression(paste("P_cum_mm")))
plt

#plot(mX)
View(temp[,c('timestamp','species','daytime','leaf_age','season','VPDleaf_median', 'SWIN_1_1_1', 'co2_mole_fraction', 'P_cum_mm')])

# Production & transport in 2 models!
m_coi <- gam(COi ~ s(TL, k=4, by=treatment) + s(PAR, k=4, by=treatment) + treatment, # Production GOOD
          data=temp, method='REML', select=T)
summary(m_coi)
AIC(m_coi)
concurvity(m_coi, full=F)$worst
gam.check(m_coi)
p = visreg(m_coi,"PAR", by="treatment", data = temp,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(m_coi, xvar = 'PAR', by='treatment', data = temp, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(PAR, visregFit, linetype=treatment, fill=treatment, colour=treatment))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=treatment), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste("PAR [",mu,mol~m^{-2}~s^{-1},"]")),
                 y = expression(paste(c['CO,i']," [",nmol~mol^{-1},"]")),
                 colour='Treatment', fill='Treatment', linetype='Treatment')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste('PAR contribution to ','c'['CO,i'])))
plt_coi_par <- plt
plt_coi_par
ggsave(paste0(graphs_path, 'model2a_output_PAR.jpg'), width=8, height=8, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model2a_output_PAR.pdf'), width=8, height=8, units = "cm", dpi = 1200)

p = visreg(m_coi,"TL", by="treatment", data = temp,  method = "REML", overlay=T, plot = F,
           partial = F, rug = F)
p2 = visreg(m_coi, xvar = 'TL', by='treatment', data = temp, gg=T, method = "REML", overlay=T)
plt = ggplot(p$fit, aes(TL, visregFit, linetype=treatment, fill=treatment, colour=treatment))
plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=treatment), size=0.75)
plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
plt = plt + geom_line()
#plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
#                     size = 5, hjust = 0, vjust = 1, family='serif')
plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
plt = plt + labs(x = expression(paste('T'[L]," [°C]")),
                 y = expression(paste(c['CO,i']," [",nmol~mol^{-1},"]")),
                 colour='Treatment', fill='Treatment', linetype='Treatment')
plt = plt + theme_bw()
#plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
plt = plt + theme(legend.position = c(0.18, 0.80), text=element_text(family="serif"),
                  plot.title = element_text(hjust = 0.5))
plt = plt + ggtitle( expression(paste('T'['L']," contribution to ",'c'['CO,i'])))
plt_coi_tl <- plt
plt_coi_tl
ggsave(paste0(graphs_path, 'model2b_output_TL.jpg'), width=8, height=8, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model2b_output_TL.pdf'), width=8, height=8, units = "cm", dpi = 1200)

# FLUX
#m_cof <- gam(co.flux ~ te(H2Oi, Tr, by=treatment, k=4) + treatment,
#            data=temp, method='REML', select=T)
m_cof <- gam(co.flux ~ te(Tr, g_tCO, by=treatment, k=4) + treatment,
             data=temp, method='REML', select=T) # Dan wants me to drop H2Oi
summary(m_cof)
AIC(m_cof)
# p = visreg(m_cof,"COi", by="treatment", data = temp,  method = "REML", overlay=T, plot = F,
#            partial = F, rug = F)
# p2 = visreg(m_cof, xvar = 'COi', by='treatment', data = temp, gg=T, method = "REML", overlay=T)
# plt = ggplot(p$fit, aes(COi, visregFit, linetype=treatment, fill=treatment, colour=treatment))
# plt = plt + geom_point(data=p2$data, aes(x=x, y=y, colour=treatment), size=0.75)
# plt = plt + geom_ribbon(aes(ymin=visregLwr, ymax=visregUpr), alpha=0.5, colour=NA)
# plt = plt + geom_line()
# #plt = plt + annotate("text", x = min(p2$data$x), y = max(p2$data$y) + 1, label = "(a)",
# #                     size = 5, hjust = 0, vjust = 1, family='serif')
# plt = plt + scale_colour_manual(values=cbPalette)  + scale_fill_manual(values=cbPalette)
# plt = plt + labs(x = expression(paste('c'['CO,i']," [",nmol~mol^{-1},"]")),
#                  y = expression(paste('Part. contribution to  ','f'['CO']," [",nmol~m^{-2}~s^{-1},"]")),
#                  colour='Treatment', fill='Treatment', linetype='Treatment')
# plt = plt + theme_bw()
# #plt = plt + theme(legend.position="bottom", text=element_text(family="serif"))
# plt = plt + theme(legend.position = c(0.18, 0.80), text=element_text(family="serif"),
#                   plot.title = element_text(hjust = 0.5))
# plt = plt + ggtitle( expression(paste('c'['CO,i'],' contribution to f'['CO'])))
# plt = plt + coord_cartesian(ylim= c(-0.5,3.5))
# plt_cof_coi <- plt
# plt_cof_coi
# ggsave(paste0(graphs_path, 'model3a_output_COi.jpg'), width=8, height=8, units = "cm", dpi = 1200)
# ggsave(paste0(graphs_path, 'model3a_output_COi.pdf'), width=8, height=8, units = "cm", dpi = 1200)


library(gratia)
library(metR)

m_cof <- gam(co.flux ~ te(Tr, g_tCO, by=treatment, k=4),
                 data=temp, method='REML', select=T)
summary(m_cof)
AIC(m_cof)

# m_cof_dro <- gam(co.flux ~ te(H2Oi, Tr, k=4),
#                  data=temp[which((temp$treatment == 'dro')),], method='REML', select=T)
m_cof_dro <- gam(co.flux ~ te(Tr, g_tCO, k=4),
                 data=temp[which((temp$treatment == 'dro')),], method='REML', select=T)
plt_cof_dro <- draw(m_cof_dro, contour = T, n = 50, select=1)
plt_cof_dro[[1]]$labels$caption <- NULL # Remove
plt_cof_dro[[1]]$labels$title <- NULL # Remove
plt_cof_dro <- plt_cof_dro + scale_fill_gradient2(low='#2166AC', mid='#eaeaea', high='#9c1a16', na.value="#ffffff00",
                                                  limits = c(-1.5, 4))
plt_cof_dro <- plt_cof_dro + metR::geom_text_contour(aes(z = est), stroke = 0.15)
plt_cof_dro <- plt_cof_dro + theme_bw()
plt_cof_dro <- plt_cof_dro + theme(legend.position = "right",
                                   text=element_text(family="serif"),
                                   plot.title = element_text(hjust = 0.5))
# plt_cof_dro <- plt_cof_dro + ggtitle(expression(paste("Dro: ",'c'['H2O,i'],' & Tr contrib. to f'['CO'])))
# plt_cof_dro <- plt_cof_dro + labs(x=expression(paste(c[paste(H[2],"O,i")]," [mmol ",mol^{-1},"]")),
#                                   y=expression(paste(Tr," [",mmol~m^{-2}~s^{-1},"]")))
plt_cof_dro <- plt_cof_dro + ggtitle(expression(paste("Droughted: ",'g'['t,CO'],' & Tr contrib. to f'['CO'])))
plt_cof_dro <- plt_cof_dro + labs(y=expression(paste(g[paste("t,CO")]," [mol ",mol^{-2}," ",s^{-1},"]")),
                                  x=expression(paste(Tr," [",mmol~m^{-2}~s^{-1},"]")))
plt_cof_dro
ggsave(paste0(graphs_path, 'model3b_output_interaction_H2Oi_Tr.jpg'), width=8, height=8, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model3b_output_interaction_H2Oi_Tr.pdf'), width=8, height=8, units = "cm", dpi = 1200)


# m_cof_irr <- gam(co.flux ~ te(H2Oi, Tr, k=4),
#                  data=temp[which((temp$treatment == 'irr')),], method='REML', select=T)
m_cof_irr <- gam(co.flux ~ te(Tr, g_tCO, k=4),
                 data=temp[which((temp$treatment == 'irr')),], method='REML', select=T)
plt_cof_irr <- draw(m_cof_irr, contour = T, n = 50, select=1)
plt_cof_irr[[1]]$labels$caption <- NULL # Remove
plt_cof_irr[[1]]$labels$title <- NULL # Remove
plt_cof_irr <- plt_cof_irr + scale_fill_gradient2(low='#2166AC', mid='#eaeaea', high='#9c1a16', na.value="#ffffff00",
                                                  limits = c(-1.5, 4))
plt_cof_irr <- plt_cof_irr + metR::geom_text_contour(aes(z = est), stroke = 0.15)
plt_cof_irr <- plt_cof_irr + theme_bw()
plt_cof_irr <- plt_cof_irr + theme(legend.position = "right",
                                   text=element_text(family="serif"),
                                   plot.title = element_text(hjust = 0.5))
# plt_cof_irr <- plt_cof_irr + ggtitle(expression(paste("Irr: ",'c'['H2O,i'],' & Tr contrib. to f'['CO'])))
# plt_cof_dro <- plt_cof_dro + labs(x=expression(paste(c[paste(H[2],"O,i")]," [mmol ",mol^{-1},"]")),
#                                   y=expression(paste(Tr," [",mmol~m^{-2}~s^{-1},"]")))
plt_cof_irr <- plt_cof_irr + ggtitle(expression(paste("Irrigated: ",'g'['t,CO'],' & Tr contrib. to f'['CO'])))
plt_cof_irr <- plt_cof_irr + labs(y=expression(paste(g[paste("t,CO")]," [mol ",mol^{-2}," ",s^{-1},"]")),
                                  x=expression(paste(Tr," [",mmol~m^{-2}~s^{-1},"]")))

plt_cof_irr
ggsave(paste0(graphs_path, 'model3c_output_interaction_H2Oi_Tr.jpg'), width=8, height=8, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model3c_output_interaction_H2Oi_Tr.pdf'), width=8, height=8, units = "cm", dpi = 1200)

# library(grImport2)
# library(rsvg)
# rsvg::rsvg_svg("../graphs/model1_outline.svg", "../graphs/model1_outline2.svg")
# raw <- grImport2::readPicture("C:/Users/Jonathan/Documents/_research_statistics/2.6 - CO branch chambers/graphs/model1_outline2.svg")
# grob <- grImport2::pictureGrob(raw, just = c("left",'bottom'), x=unit(0, "cm"), y = unit(0, "cm"))

library(ggpubr)
library(cowplot)
# ggarrange(grob, plt_cof_coi,
#           plt_coi_par, plt_cof_irr,
#           plt_coi_tl, plt_cof_dro, 
#           labels = c("(1)",  "(3a)",
#                      "(2a)", "(3b)",
#                      "(2b)", "(3c)"),
#           ncol = 2, nrow = 3)
# ggsave(paste0(graphs_path, 'model_output_all.jpg'), width = 20, height = 27, units = "cm", dpi = 1200)
# ggsave(paste0(graphs_path, 'model_output_all.pdf'), width = 20, height = 27, units = "cm", dpi = 1200)

legend <- get_legend(plt_cof_irr)
plt_cof_irr2 <- plt_cof_irr + theme(legend.position = "none")
plt_cof_dro2 <- plt_cof_dro + theme(legend.position = "none")

plts <- ggarrange(plt_coi_par, plt_coi_tl,
          plt_cof_irr2, plt_cof_dro2,
          labels = c("(a)", "(b)",
                     "(c)", "(d)"),
          ncol = 2, nrow = 2)

final_plot <- plot_grid(plts, legend, ncol = 2, rel_widths = c(1, 0.1))
final_plot
ggsave(paste0(graphs_path, 'model_output_all.jpg'), width = 21, height = 20, units = "cm", dpi = 1200)
ggsave(paste0(graphs_path, 'model_output_all.pdf'), width = 21, height = 20, units = "cm", dpi = 1200)

