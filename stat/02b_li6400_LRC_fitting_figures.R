# Header ####
library(broom)
library(dplyr)
library(photosynthesis)

# Documentation
# vignette("light-response", package = "photosynthesis")

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

# 1) Load data ####
# - - - - - - - - -

full <- read.csv(paste0(data_path, 'li6400_dataset.csv'))
df <- full[which(full$measurement_type == 'FLRC'),]

# 2) Remove outliers ####
# - - - - - - - - - - - -

# Create backup columns
df$Photo_original <- df$Photo
df$PARi_original  <- df$PARi

# Smoother curve
df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2023_09_13") & ((df$Photo > 7.5) & (df$PARi < 1100))),]$Photo <- NA

# Minor outlier
df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2023_09_13") & ((df$Photo < 7) & (df$PARi > 400))),]$Photo <- NA

# Strange straight line. Add 0 and remove high value. NOT SURE ABOUT THIS
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_09_13") & (df$PARi > 1200)),]$Photo <- NA
df <- rbind(df, NA)
df[which(is.na(df$filename)),]$filename = "Erin_Nitida3_Old_FLRC_2023_09_13"
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_09_13") & is.na(df$Photo_original)),]$Photo <- 0
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_09_13") & is.na(df$PARi_original)),]$PARi   <- 0
current_fn <- "Erin_Nitida3_Old_FLRC_2023_09_13"
current_leaf_age  <- unique(df[which(df$filename == current_fn & !is.na(df$leaf_age)),]$leaf_age)
current_species   <- unique(df[which(df$filename == current_fn & !is.na(df$species)),]$species)
current_timestamp <- tail(df[which(df$filename == current_fn & !is.na(df$timestamp)),]$timestamp, n=1)
df[which(df$filename == current_fn & is.na(df$leaf_age)),]$leaf_age <- current_leaf_age
df[which(df$filename == current_fn & is.na(df$species)),]$species <- current_species
df[which(df$filename == current_fn & is.na(df$timestamp)),]$timestamp <- current_timestamp

# Low A value at high PAR
df[which((df$filename == "Erin_Repens1_Mid_FLRC_2023_09_13") & (df$PARi > 1200)),]$Photo <- NA

# Smooth curve
df[which((df$filename == 'Erin_Repens1_Yng_FLRC_2023_09_13') & ((df$Photo > 12) & (df$PARi < 800))),]$Photo <- NA

# High A with low PAR
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2023_09_13") & ((df$Photo > 12) & (df$PARi < 800))),]$Photo <- NA

# High A with low PAR
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2023_11_21")& ((df$Photo > 5) & (df$PARi < 200))),]$Photo <- NA

# Outliers pulling down the LRC
df[which((df$filename == "Erin_NitAdt3_Mid_FLRC_2023_11_21") & ((df$Photo < 6) & (df$PARi > 250))),]$Photo <- NA
df[which((df$filename == "Erin_NitAdt3_Mid_FLRC_2023_11_21") & ((df$Photo < 5) & (df$PARi > 180))),]$Photo <- NA

# Outliers pulling down the LRC
df[which((df$filename == "Erin_NitAdt3_Old_FLRC_2023_11_21") & ((df$Photo < 6.5) & (df$PARi > 400))),]$Photo <- NA

# Many outliers? NOT SURE HERE
df[which((df$filename == "Erin_Repens1_Old_FLRC_2023_11_21") & ((df$Photo > 4) & (df$PARi < 1000))),]$Photo <- NA
df[which((df$filename == "Erin_Repens1_Old_FLRC_2023_11_21") & (df$Photo < 3)),]$Photo <- NA

df[which((df$filename == "Erin_Repens1_Old_FLRC_2023_09_13") & (df$PARi > 1400)),]$Photo <- NA
plt = ggplot(df[which(df$filename == "Erin_Repens1_Old_FLRC_2023_09_13" & df$PARi < 1500),])
plt = plt + geom_point(aes(x=PARi, y=Photo))
plt

# Bad high A value
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_12_18") & (df$Photo > 7)),]$Photo <- NA
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_12_18") & (df$PARi > 400) & (df$PARi < 600)),]$Photo <- NA
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_12_18") & (df$PARi > 900) & (df$PARi < 1100)),]$Photo <- NA
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2023_12_18") & (df$PARi < 150)),]$Photo <- NA

# 
df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2023_12_18") & ((df$Photo > 2.5) & (df$PARi < 600))),]$Photo <- NA
df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2023_12_18") & (df$Photo < 0.5)),]$Photo <- NA

# 
df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2023_12_18") & ((df$Photo < 7.5) & (df$PARi > 800))),]$Photo <- NA

# Remove weird values
df[which((df$filename == "Erin_Repens3_Old_FLRC_2023_12_18") & (df$PARi > 2500)),]$Photo <- NA
df[which((df$filename == "Erin_Repens3_Old_FLRC_2023_12_18") & ((df$Photo < -1.3) & (df$PARi > 900))),]$Photo <- NA
df[which((df$filename == "Erin_Repens3_Old_FLRC_2023_12_18") & (df$Photo > 0)),]$Photo <- NA

#
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2023_12_18") & ((df$Photo < -2) & (df$PARi > 400))),]$Photo <- NA
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2023_12_18") & ((df$Photo > -2.8) & (df$PARi < 210))),]$Photo <- NA
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2023_12_18") & (df$PARi > 1200)),]$Photo <- NA

#
df[which((df$filename == "Erin_Nitida3_Old_FLRC_2024_01_25") & ((df$Photo < 5) & (df$PARi > 400))),]$Photo <- NA

#
df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2024_01_25") & ((df$Photo < 3.5) & (df$PARi > 800))),]$Photo <- NA
df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2024_01_25") & ((df$Photo > 3.5) & (df$PARi < 200))),]$Photo <- NA

# Minor outlier
df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2024_01_25") & ((df$Photo > 4) & (df$PARi < 250))),]$Photo <- NA

# Assume not much activity at all
df[which((df$filename == "Erin_Repens3_Old_FLRC_2024_01_25") & (df$Photo > 2)),]$Photo <- NA

# Assume not much activity at all
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2024_01_25") & ((df$Photo > 2.1) & (df$PARi < 1100))),]$Photo <- NA
df <- rbind(df, NA)
df[which(is.na(df$filename)),]$filename = "Erin_Repens3_Mid_FLRC_2024_01_25"
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2024_01_25") & is.na(df$Photo_original)),]$Photo <- 0
df[which((df$filename == "Erin_Repens3_Mid_FLRC_2024_01_25") & is.na(df$PARi_original)),]$PARi   <- 0
current_fn <- "Erin_Repens3_Mid_FLRC_2024_01_25"
current_leaf_age  <- unique(df[which(df$filename == current_fn & !is.na(df$leaf_age)),]$leaf_age)
current_species   <- unique(df[which(df$filename == current_fn & !is.na(df$species)),]$species)
current_timestamp <- tail(df[which(df$filename == current_fn & !is.na(df$timestamp)),]$timestamp, n=1)
df[which(df$filename == current_fn & is.na(df$leaf_age)),]$leaf_age <- current_leaf_age
df[which(df$filename == current_fn & is.na(df$species)),]$species <- current_species
df[which(df$filename == current_fn & is.na(df$timestamp)),]$timestamp <- current_timestamp

# Force through 0
df[which((df$filename == "Erin_Repens3_Yng_FLRC_2024_01_25") & ((df$Photo < 2.7) & (df$PARi > 800))),]$Photo <- NA
df[which((df$filename == "Erin_Repens3_Yng_FLRC_2024_01_25") & ((df$Photo < 2.4) & (df$PARi > 400))),]$Photo <- NA
df <- rbind(df, NA)
df[which(is.na(df$filename)),]$filename = "Erin_Repens3_Yng_FLRC_2024_01_25"
df[which((df$filename == "Erin_Repens3_Yng_FLRC_2024_01_25") & is.na(df$Photo_original)),]$Photo <- 0
df[which((df$filename == "Erin_Repens3_Yng_FLRC_2024_01_25") & is.na(df$PARi_original)),]$PARi   <- 0
current_fn <- "Erin_Repens3_Yng_FLRC_2024_01_25"
current_leaf_age  <- unique(df[which(df$filename == current_fn & !is.na(df$leaf_age)),]$leaf_age)
current_species   <- unique(df[which(df$filename == current_fn & !is.na(df$species)),]$species)
current_timestamp <- tail(df[which(df$filename == current_fn & !is.na(df$timestamp)),]$timestamp, n=1)
df[which(df$filename == current_fn & is.na(df$leaf_age)),]$leaf_age <- current_leaf_age
df[which(df$filename == current_fn & is.na(df$species)),]$species <- current_species
df[which(df$filename == current_fn & is.na(df$timestamp)),]$timestamp <- current_timestamp

# Remove the middle as it confuses the fitting algorithm
df[which((df$filename == "Erin_NitAdt3_Old_FLRC_2024_01_25") & ((df$Photo < 2.5) & (df$PARi > 800))),]$Photo <- NA
df[which((df$filename == "Erin_NitAdt3_Old_FLRC_2024_01_25") & !((df$PARi < 400) | (df$PARi > 800))),]$Photo <- NA

# Strange middle-high value
df[which((df$filename == "Erin_NitAdt3_Mid_FLRC_2024_01_25") & ((df$Photo < 1.5) & (df$PARi > 800))),]$Photo <- NA

# Option 1
# df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & ((df$Photo > 1.0) & (df$PARi < 800))),]$Photo <- NA
# df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & ((df$PARi < 250))),]$Photo <- NA
# df <- rbind(df, NA)
# df[which(is.na(df$filename)),]$filename = "Erin_NitAdt3_Yng_FLRC_2024_01_25"
# df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & is.na(df$Photo_original)),]$Photo <- 0
# df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & is.na(df$PARi_original)),]$PARi   <- 0
# current_fn <- "Erin_NitAdt3_Yng_FLRC_2024_01_25"
# current_leaf_age  <- unique(df[which(df$filename == current_fn & !is.na(df$leaf_age)),]$leaf_age)
# current_species   <- unique(df[which(df$filename == current_fn & !is.na(df$species)),]$species)
# current_timestamp <- tail(df[which(df$filename == current_fn & !is.na(df$timestamp)),]$timestamp, n=1)
# df[which(df$filename == current_fn & is.na(df$leaf_age)),]$leaf_age <- current_leaf_age
# df[which(df$filename == current_fn & is.na(df$species)),]$species <- current_species
# df[which(df$filename == current_fn & is.na(df$timestamp)),]$timestamp <- current_timestamp
# Option 2
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & ((df$Photo > 1.0) & (df$PARi < 250))),]$Photo <- NA
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & ((df$Photo < 0.9) & (df$PARi > 250))),]$Photo <- NA
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & (df$PARi > 900)),]$Photo <- NA
df <- rbind(df, NA)
df[which(is.na(df$filename)),]$filename = "Erin_NitAdt3_Yng_FLRC_2024_01_25"
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & is.na(df$Photo_original)),]$Photo <- 0
df[which((df$filename == "Erin_NitAdt3_Yng_FLRC_2024_01_25") & is.na(df$PARi_original)),]$PARi   <- 0
current_fn <- "Erin_NitAdt3_Yng_FLRC_2024_01_25"
current_leaf_age  <- unique(df[which(df$filename == current_fn & !is.na(df$leaf_age)),]$leaf_age)
current_species   <- unique(df[which(df$filename == current_fn & !is.na(df$species)),]$species)
current_timestamp <- tail(df[which(df$filename == current_fn & !is.na(df$timestamp)),]$timestamp, n=1)
df[which(df$filename == current_fn & is.na(df$leaf_age)),]$leaf_age <- current_leaf_age
df[which(df$filename == current_fn & is.na(df$species)),]$species <- current_species
df[which(df$filename == current_fn & is.na(df$timestamp)),]$timestamp <- current_timestamp

# Prepare month labels
df$date <- substr(df$filename, 23, 32)
df$date <- gsub('_','-',df$date)
df$month <- NA
df[which(df$date == '2023-09-13'),]$month <- 'Sep'
df[which(df$date == '2023-11-21'),]$month <- 'Nov'
df[which(df$date == '2023-12-18'),]$month <- 'Dec'
df[which(df$date == '2024-01-25'),]$month <- 'Jan'
df$leaf_age <- factor(df$leaf_age, levels = c('Yng', 'Mid', 'Old'))
df$month <- factor(df$month, levels = c('Sep','Nov','Dec','Jan'))

# Construct the levels using expand.grid
# new_levels <- with(expand.grid(
#   month    = levels(df$month),       # first variable: month (fastest changing)
#   leaf_age = levels(df$leaf_age),      # second variable: leaf_age
#   species  = levels(df$species)        # third variable: species (slowest changing)
# ), paste0(df$species, ", ", df$leaf_age, ", ", df$month))
# df$group <- factor(paste0(df$species, ", ", df$leaf_age, ", ", df$month),
#                    levels = unique(new_levels))

df$group <- paste0(df$species, ', ', df$leaf_age, ', ', df$month)

# 2b) Fit all ####
# - - - - - - - - 
library(purrr)

fits = df %>%
  filter(!is.na(Photo)) %>%
  split(.$filename) %>%
  map(~ fit_photosynthesis(.x,
                           .photo_fun = "aq_response",
                           .vars = list(.A = Photo, .Q = PARi)))

# 2) Collect coefficients into a table
fit_table <- fits %>%
  map(coef) %>%
  map(t) %>%
  map(as.data.frame) %>%
  imap_dfr(~ mutate(.x, CO2_s = .y))

# Show results
# k_sat: Saturating Light-Saturated Photosynthesis (A_sat)
# phi_J: Quantum yield (slope at low light).
# theta_J: Curvature.
# Rd: Dark respiration.
names(fit_table)[names(fit_table) == 'CO2_s'] <- 'filename'
fit_table

# Marshall & Biscoe net A function (vectorised)
marshall_biscoe_net <- function(Q, phi, theta, k_sat, Rd) {
  J <- phi * Q
  under <- (J + k_sat)^2 - 4 * theta * J * k_sat
  # numerical protection
  under[under < 0] <- 0
  A_gross <- (J + k_sat - sqrt(under)) / (2 * theta)
  A_gross - Rd
}

# helper to compute Km_net for one row (returns numeric Km)
compute_Km_net <- function(phi, theta, k_sat, Rd,
                           upper = 2000, max_upper = 1e5, tol = 1e-8, grid_n = 5001) {
  Asat_net <- k_sat - Rd
  if (!is.finite(Asat_net) || Asat_net <= 0) return(NA_real_)
  target <- 0.5 * Asat_net
  
  f0 <- marshall_biscoe_net(0, phi, theta, k_sat, Rd) - target
  
  up <- upper
  fup <- marshall_biscoe_net(up, phi, theta, k_sat, Rd) - target
  # expand upper until sign change or hit max_upper
  while (fup < 0 && up < max_upper) {
    up <- up * 2
    fup <- marshall_biscoe_net(up, phi, theta, k_sat, Rd) - target
  }
  
  if (fup >= 0 && (f0 * fup) <= 0) {
    # bracketed: safe to use uniroot
    out <- tryCatch(
      uniroot(function(Q) marshall_biscoe_net(Q, phi, theta, k_sat, Rd) - target,
              lower = 0, upper = up, tol = tol)$root,
      error = function(e) NA_real_
    )
    return(as.numeric(out))
  }
  
  # fallback: grid + approx (robust even when uniroot can't bracket)
  Qgrid <- seq(0, up, length.out = grid_n)
  Agrid <- marshall_biscoe_net(Qgrid, phi, theta, k_sat, Rd)
  if (all(Agrid < target)) return(NA_real_)
  approx(Agrid, Qgrid, xout = target, ties = mean)$y
}

# apply to fit_table (vectorised via pmap)
fit_table_with_km <- fit_table %>%
  mutate(
    Asat_net = k_sat - Rd
  ) %>%
  mutate(
    Km_net = pmap_dbl(
      list(phi = phi_J, theta = theta_J, k_sat = k_sat, Rd = Rd),
      ~ compute_Km_net(..1, ..2, ..3, ..4)
    )
  )

# inspect
fit_table_with_km

# Prepare fit table for plotting
fit_table_plot <- left_join(fit_table_with_km, unique(df[,c('filename','species','leaf_age','month')]), by='filename')
fit_table_plot$month <- factor(fit_table_plot$month, levels = c('Sep','Nov','Dec','Jan'))

# Plot as boxplot
plt = ggplot(fit_table_plot, aes(x=month, y=k_sat))
plt = plt + geom_boxplot(aes(x=month, y=Asat_net)) # Shows medians
#plt = plt + geom_boxplot(fatten=NULL)
#plt = plt + stat_summary(fun = mean, geom = "crossbar", width = 0.75, fatten = 2) # Change to means
#plt = plt +  geom_jitter(aes(x = month, y = Asat_net), width = 0.15, height = 0, size = 2, alpha = 0.6, colour="#454545")
plt = plt +  geom_point( aes(x = month, y = Asat_net), size = 2, shape = 16, alpha = 0.6, colour="#454545")
plt = plt + theme_bw()
plt = plt + facet_grid(~ species)
plt = plt + labs(x = "Month", y = expression(paste("A"["sat,net"])),
                 colour='Month', shape='Month', linetype='Month')
plt = plt + theme(axis.title.x = element_blank(), text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'all_Asat.pdf'), width=20, height=10, units = "cm", scale=1.0, dpi = 600)
ggsave(paste0(graphs_path, 'all_Asat.jpg'), width=20, height=10, units = "cm", scale=1.0, dpi = 600)

library(tidyr)
fit_table_long <- fit_table_plot[,c('species','leaf_age','month','Asat_net', 'Km_net')] %>%
  pivot_longer(
    cols = c(Asat_net, Km_net),     # the columns to make long
    names_to = "variable",          # name of new column holding former column names
    values_to = "value"             # name of new column holding values
  )
fit_table_long[fit_table_long['variable'] == 'Asat_net',]$variable <- "A[sat]~'['*mu*mol~m^{-2}~s^{-1}*']'"
fit_table_long[fit_table_long['variable'] == 'Km_net',]$variable <- "k[m]~'['*mu*mol~m^{-2}~s^{-1}*']'"
# INSERT HERE
plt = ggplot(fit_table_long, aes(x=month, y=k_sat))
plt = plt + geom_boxplot(aes(x=month, y=value)) # Shows medians
plt = plt + geom_point( aes(x = month, y = value), size = 2, shape = 16, alpha = 0.6, colour="#454545")
plt = plt + theme_bw()
plt = plt + facet_grid(variable ~ species, scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), axis.title.y = element_blank(), text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'all_Asat.pdf'), width=20, height=12, units = "cm", scale=1.0, dpi = 600)
ggsave(paste0(graphs_path, 'all_Asat.jpg'), width=20, height=12, units = "cm", scale=1.0, dpi = 600)

# Test significan differences (all_Asat figure) ----

library(rstatix)
library(ggpubr)

min_n <- 2

# Compact letter display from a table of pairwise p-values (Reviewer comment 3).
# Groups are collected into maximal cliques of pairwise non-significant
# comparisons; untested pairs count as "not different". No new package needed.
cld_from_pairs <- function(group1, group2, p_adj, all_groups, alpha = 0.05) {
  group1 <- as.character(group1)
  group2 <- as.character(group2)
  not_different <- function(a, b) {
    i <- which((group1 == a & group2 == b) | (group1 == b & group2 == a))
    if (length(i) == 0) return(TRUE)
    all(is.na(p_adj[i]) | p_adj[i] >= alpha)
  }
  fits_set <- function(g, s) all(vapply(s, function(m) not_different(g, m), logical(1)))
  # seed
  sets <- list()
  for (g in all_groups) {
    placed <- FALSE
    for (k in seq_along(sets)) {
      if (fits_set(g, sets[[k]])) {
        sets[[k]] <- c(sets[[k]], g)
        placed <- TRUE
      }
    }
    if (!placed) sets[[length(sets) + 1]] <- g
  }
  # grow every set to a maximal clique (a group added late must also be able to
  # join sets that were closed before it was processed)
  repeat {
    changed <- FALSE
    for (k in seq_along(sets)) {
      for (g in setdiff(all_groups, sets[[k]])) {
        if (fits_set(g, sets[[k]])) {
          sets[[k]] <- c(sets[[k]], g)
          changed <- TRUE
        }
      }
    }
    if (!changed) break
  }
  # de-duplicate and drop sets fully contained in a larger one
  sets <- unique(lapply(sets, function(s) all_groups[all_groups %in% s]))
  keep <- rep(TRUE, length(sets))
  for (i in seq_along(sets)) {
    for (j in seq_along(sets)) {
      if (i != j && keep[i] && all(sets[[i]] %in% sets[[j]]) &&
          length(sets[[i]]) < length(sets[[j]])) keep[i] <- FALSE
    }
  }
  sets <- sets[keep]
  # order sets so that letter 'a' goes to the set starting with the first group
  sets <- sets[order(vapply(sets, function(s) min(match(s, all_groups)), numeric(1)))]
  out <- do.call(rbind, lapply(seq_along(sets), function(k)
    data.frame(group = sets[[k]], letter = letters[k], stringsAsFactors = FALSE)))
  out <- aggregate(letter ~ group, data = out,
                   FUN = function(x) paste0(sort(unique(x)), collapse = ""))
  out
}

fit_table_long <- fit_table_long %>%
  mutate(
    month = factor(month, levels = c("Sep", "Nov", "Dec", "Jan")),
    variable = factor(
      variable,
      levels = c(
        "A[sat]~'['*mu*mol~m^{-2}~s^{-1}*']'",
        "k[m]~'['*mu*mol~m^{-2}~s^{-1}*']'"
      )
    )
  )

test_df <- fit_table_long %>%
  filter(is.finite(value)) %>%
  add_count(variable, species, month, name = "n_month") %>%
  filter(n_month >= min_n) %>%
  group_by(variable, species) %>%
  filter(n_distinct(month) >= 2) %>%
  ungroup()

if (nrow(test_df) > 0) {
  p_table <- test_df %>%
    group_by(variable, species) %>%
    #pairwise_wilcox_test(value ~ month, p.adjust.method = "BH") %>%
    pairwise_t_test(
      value ~ month,
      p.adjust.method = "BH",
      pool.sd = FALSE
    ) %>%
    ungroup()
} else {
  p_table <- tibble(
    variable = factor(),
    species = character(),
    group1 = character(),
    group2 = character(),
    p = numeric(),
    p.adj = numeric(),
    p.signif = character()
  )
}

y_bounds <- fit_table_long %>%
  filter(is.finite(value)) %>%
  group_by(variable, species) %>%
  summarize(
    ymax = max(value, na.rm = TRUE),
    ymin = min(value, na.rm = TRUE),
    yrange = ymax - ymin,
    .groups = "drop"
  )

step_frac <- 0.15
base_frac <- 0.05
min_step_frac <- 0.03
min_step_abs <- 1e-6

median_yrange <- median(
  y_bounds$yrange[is.finite(y_bounds$yrange) & y_bounds$yrange > 0],
  na.rm = TRUE
)

min_step_from_median <- ifelse(
  is.na(median_yrange),
  min_step_abs,
  pmax(min_step_frac * median_yrange, min_step_abs)
)

p_table2 <- p_table %>%
  left_join(y_bounds, by = c("variable", "species")) %>%
  group_by(variable, species) %>%
  arrange(p.adj, .by_group = TRUE) %>%
  mutate(
    rank = row_number() - 1,
    step = ifelse(
      is.na(yrange) | yrange <= 0,
      min_step_from_median,
      pmax(step_frac * yrange, min_step_from_median)
    ),
    base = ifelse(
      is.na(yrange) | yrange <= 0,
      ymax + min_step_from_median,
      ymax + base_frac * yrange
    ),
    y.position = base + rank * step
  ) %>%
  ungroup() %>%
  select(group1, group2, p.adj, p.adj.signif, y.position, variable, species)

# Per-panel significance letters and omnibus p-value (Reviewer comment 3).
# Uses the p_table computed above; no statistics are re-run or changed.
obs <- as.data.frame(fit_table_long[is.finite(fit_table_long$value), ])
panels <- unique(obs[, c("variable", "species")])
cld_tab <- NULL
pval_tab <- NULL
for (i in seq_len(nrow(panels))) {
  v  <- panels$variable[i]
  sp <- panels$species[i]
  d  <- obs[obs$variable == v & obs$species == sp, ]
  gs <- levels(droplevels(d$month))
  pr <- p_table[p_table$variable == v & p_table$species == sp, ]
  cl <- cld_from_pairs(pr$group1, pr$group2, pr$p.adj, gs)
  yr <- max(d$value) - min(d$value)
  if (!is.finite(yr) || yr <= 0) yr <- abs(max(d$value)) * 0.1 + 1e-6
  cld_tab <- rbind(cld_tab, data.frame(
    variable = v, species = sp,
    month = factor(cl$group, levels = levels(obs$month)),
    value = max(d$value) + 0.10 * yr,
    letter = cl$letter))
  kp <- tryCatch(rstatix::kruskal_test(d, value ~ month)$p, error = function(e) NA_real_)
  pval_tab <- rbind(pval_tab, data.frame(
    variable = v, species = sp,
    label = if (is.na(kp)) "" else if (kp < 0.001) "P < 0.001" else paste0("P = ", signif(kp, 2))))
}

plt <- ggplot(fit_table_long, aes(x = month, y = value))
plt <- plt + geom_boxplot()
plt <- plt + geom_point(
  size = 2,
  shape = 16,
  alpha = 0.6,
  colour = "#454545"
)
plt <- plt + geom_text(
  data = cld_tab,
  aes(x = month, y = value, label = letter),
  family = "serif", size = 3.2, inherit.aes = FALSE
)
plt <- plt + geom_text(
  data = pval_tab,
  aes(x = -Inf, y = Inf, label = label),
  hjust = -0.15, vjust = 1.4, family = "serif", size = 3, inherit.aes = FALSE
)
plt <- plt + facet_grid(
  variable ~ species,
  scales = "free_y",
  labeller = labeller(variable = label_parsed)
)
plt <- plt + scale_y_continuous(
  expand = expansion(mult = c(0.05, 0.25))
)
plt <- plt + theme_bw()
plt <- plt + theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  strip.text = element_text(size = 12),
  text = element_text(family = "serif")
)
plt
ggsave(paste0(graphs_path, 'all_Asat.pdf'), width=20, height=12, units = "cm", scale=1.0, dpi = 600)
ggsave(paste0(graphs_path, 'all_Asat.jpg'), width=20, height=12, units = "cm", scale=1.0, dpi = 600)


# Curves ----

fit_table_long[fit_table_long['species'] == 'Nit-S' & fit_table_long['month'] == 'Dec',]


# Join and apply for testing
df_fitted <- left_join(df, fit_table_with_km, by='filename')
df_fitted$A <- marshall_biscoe_1980(
  Q_abs = df_fitted$PARi,
  k_sat = df_fitted$k_sat,
  df_fitted$phi_J,
  df_fitted$theta_J) - df_fitted$Rd

# Create a df for plotting
df_predict <- expand.grid(PARi = seq(0, 2000, length.out = 100), filename = unique(df$filename))
# Create date column
df_predict$date <- substr(df_predict$filename, 23, 32)
df_predict$date <- gsub('_','-',df_predict$date)
# Add info
df_predict <- left_join(df_predict, fit_table, by='filename')
df_predict <- left_join(df_predict, unique(df[,c('filename','species','leaf_age')]), by='filename')
# Calculate by fit curve
df_predict$Photo <- marshall_biscoe_1980(
      Q_abs = df_predict$PARi,
      k_sat = df_predict$k_sat,
      df_predict$phi_J,
      df_predict$theta_J) - df_predict$Rd

# Remove 1 really bad outlier
df_fitted <- df_fitted[which(df_fitted$PARi <= 2000),]
# Mark the removed points
df_fitted$Photo_removed <- NA
df_fitted[which(is.na(df_fitted$Photo)),]$Photo_removed <- df_fitted[which(is.na(df_fitted$Photo)),]$Photo_original
# Show
df_fitted[which(is.na(df_fitted$month)),]

df_fitted$leaf_age <- factor(df_fitted$leaf_age, levels = c('Yng', 'Mid', 'Old'))
df_predict$leaf_age <- factor(df_predict$leaf_age, levels = c('Yng', 'Mid', 'Old'))

df_fitted$date <- substr(df_fitted$timestamp, 1, 10)
df_fitted$month <- factor(df_fitted$month, levels = c('Sep','Nov','Dec','Jan'))
df_predict$month <- NA
df_predict[which(df_predict$date == '2023-09-13'),]$month <- 'Sep'
df_predict[which(df_predict$date == '2023-11-21'),]$month <- 'Nov'
df_predict[which(df_predict$date == '2023-12-18'),]$month <- 'Dec'
df_predict[which(df_predict$date == '2024-01-25'),]$month <- 'Jan'
df_predict$month <- factor(df_predict$month, levels = c('Sep','Nov','Dec','Jan'))

df_predict[which(df_predict$species == 'Nit-S' & df_predict$leaf_age == 'Old' & df_predict$month == 'Nov'),]


plt = ggplot()
plt = plt + geom_point(data=df_fitted, aes(x = PARi, y = Photo, colour=month))
plt = plt + geom_point(data=df_fitted, aes(x = PARi, y = Photo_removed, colour=month), shape=2)
#plt = plt + geom_line(aes(x = PARi, y = Photo, colour=date))
plt = plt + geom_line(data=df_predict, aes(x = PARi, y = Photo, colour=month), linetype='dashed')
plt = plt + labs(x = "PAR", y = "Net assimilation rate (Photo)",
                 colour='Month', shape='Month', linetype='Month')
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + coord_cartesian(ylim=c(-5,20))
plt = plt + theme_bw()
#plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
plt = plt + theme(text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'supplement/all_curves_fitted.pdf'), width=20, height=14, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/all_curves_fitted.jpg'), width=20, height=14, units = "cm", scale=1.25, dpi = 600)


# Save fitting parameters
write.csv(fit_table_with_km, paste0(output_path,'lrc_fitted.csv'), row.names=FALSE)

# 2b00) Numbers for text ####
# - - - - - - - - - - - - - -

fit_table_with_km_full <- left_join(fit_table_with_km,
                               unique(df[,c("filename","month","species","leaf_age")]),
                               by="filename")
fit_table_with_km_full$filename <- NULL

Table1_Stats <- fit_table_with_km_full %>%
  group_by(species, month) %>%
  summarise(
    Asat_Median = median(Asat_net, na.rm = TRUE),
    Asat_SD = sd(Asat_net, na.rm = TRUE),
    Km_Median = median(Km_net, na.rm = TRUE),
    Km_SD = sd(Km_net, na.rm = TRUE),
    .groups = "drop"
  )
# This creates the summarised curve stats
print(Table1_Stats)

# Format the table
table1_out <- Table1_Stats
table1_out$A_sat <- paste0(round(table1_out$Asat_Median,2), '±', round(table1_out$Asat_SD,2))
table1_out$k_m <- paste0(round(table1_out$Km_Median,2), '±', round(table1_out$Km_SD,2))
table1_out[which(is.na(table1_out$Km_Median)),]$k_m <- ""
table1_out$n_total <- NULL
table1_out$n_Empirical <- NULL
table1_out$Asat_Median <- NULL
table1_out$Asat_SD <- NULL
table1_out$Km_Median <- NULL
table1_out$Km_SD <- NULL
table1_out
write.csv(table1_out, file=paste0(graphs_path, 'table_km_Asat_summarised.csv'),na='',row.names=FALSE,fileEncoding = "Windows-1252")

# OLD ####

# 2c1) NLS fit of LRCs ####
# - - - - - - - - - - - - -

library(minpack.lm) # Robust NLS
library(stringr)
library(purrr)

# Define the Non-Rectangular Hyperbola function (Standard for LRCs)
# theta = curvature (0 to 1), phi = quantum yield, Asat = max rate, Rd = respiration
# 1. Define Model
nrh_model <- function(PAR, Asat_Gross, phi, theta, Rd) {
  num <- (phi * PAR + Asat_Gross) - sqrt((phi * PAR + Asat_Gross)^2 - 4 * theta * phi * PAR * Asat_Gross)
  den <- 2 * theta
  return((num / den) - Rd)
}

# 2. Robust Fit Function
fit_robust <- function(df_curve) {
  
  max_obs <- max(df_curve$Photo, na.rm = TRUE)
  
  # --- CHECK 1: Is the plant respiring? ---
  # If the max observed photosynthesis is <= 0 (or very close), 
  # NLS will fail or give nonsense. Skip directly to Empirical.
  if(max_obs <= 0.5) {
    return(data.frame(
      Method = "Empirical (Respiring)",
      Asat = max_obs, # This will be the negative number you want
      Km = NA # Km is undefined if never positive
    ))
  }
  
  # --- CHECK 2: Try NLS ---
  tryCatch({
    fit <- nlsLM(Photo ~ nrh_model(PARi, Asat_Gross, phi, theta, Rd),
                 data = df_curve,
                 start = list(Asat_Gross = max(5, max_obs), phi = 0.05, theta = 0.7, Rd = 1),
                 lower = c(Asat_Gross = 0, phi = 0, theta = 0, Rd = 0), 
                 upper = c(Asat_Gross = 60, phi = 0.1, theta = 0.99, Rd = 10),
                 control = nls.lm.control(maxiter = 100))
    
    coefs <- coef(fit)
    
    # Calculate NET Assimilation (Gross - Respiration)
    # This is what matches your raw data observation
    net_asat <- coefs["Asat_Gross"] - coefs["Rd"]
    
    # Calculate Km
    km_val <- coefs["Asat_Gross"] / coefs["phi"]
    
    return(data.frame(
      Method = "Model",
      Asat = net_asat,
      Km = km_val
    ))
    
  }, error = function(e) {
    # --- CHECK 3: Fallback if NLS crashes on active plants ---
    
    # Empirical Km
    emp_km <- approx(x = df_curve$Photo, y = df_curve$PARi, xout = max_obs/2)$y
    
    return(data.frame(
      Method = "Empirical (Fallback)",
      Asat = max_obs,
      Km = emp_km
    ))
  })
}

# Apply the robust function to every curve
results_list <- df %>%
  split(~ group) %>%
  map(fit_robust)

# Bind into a clean table
final_data <- bind_rows(results_list, .id = "group") %>%
  mutate(
    Type = str_split(group, ", ", simplify = T)[,1],
    Age = str_split(group, ", ", simplify = T)[,2],
    Month = str_split(group, ", ", simplify = T)[,3],
    Month = factor(Month, levels = c("Sep", "Nov", "Dec", "Jan"))
  )
# This is every single curve

# Generate TABLE 1 (Mean ± SD)
Table1_Stats <- final_data %>%
  group_by(Type, Month) %>%
  summarise(
    Asat_Mean = mean(Asat, na.rm = TRUE),
    Asat_SD = sd(Asat, na.rm = TRUE),
    Km_Mean = mean(Km, na.rm = TRUE),
    Km_SD = sd(Km, na.rm = TRUE),
    
    # The Counts
    n_total = n(),
    n_NLS = sum(Method == "Model"),       # How many worked with the Model
    n_Empirical = sum(Method == "Empirical"), # How many used Fallback
    
    .groups = "drop"
  )
# This creates the summarised curve stats
print(Table1_Stats)

# Save as latex
library(xtable)
# print.xtable(xtable(Table1_Stats, digits=c(0,0,0,0,2,2,2,2)), file = paste0(graphs_path, 'slope_intercept_km_Asat.tex'),
#              include.rownames=F)
# 
# # Save as .csv
# write.csv(results, file=paste0(graphs_path, 'slope_intercept_km_Asat.csv'),na='',row.names=FALSE)
# # Reduce digits in .csv
# results_digits <- results %>% 
#   mutate_if(is.numeric, ~ round(., 2))
# write.csv(results_digits, file=paste0(graphs_path, 'slope_intercept_km_Asat_digits.csv'),na='',row.names=FALSE)

# Format the table
table1_out <- Table1_Stats
table1_out$A_sat <- paste0(round(table1_out$Asat_Mean,2), '±', round(table1_out$Asat_SD,2))
table1_out$k_m <- paste0(round(table1_out$Km_Mean,2), '±', round(table1_out$Km_SD,2))
table1_out[which(is.na(table1_out$Km_Mean)),]$k_m <- ""
table1_out$n_total <- NULL
table1_out$n_Empirical <- NULL
table1_out$Asat_Mean <- NULL
table1_out$Asat_SD <- NULL
table1_out$Km_Mean <- NULL
table1_out$Km_SD <- NULL
table1_out
write.csv(table1_out, file=paste0(graphs_path, 'table_km_Asat_summarised.csv'),na='',row.names=FALSE,fileEncoding = "Windows-1252")

# Plot everything
# - - - - - - - - -
# 1. Extract full fit parameters

fit_robust_raw <- function(df_curve) {
  
  max_obs <- max(df_curve$Photo, na.rm = TRUE)
  
  # --- CHECK 1: Is the plant respiring? ---
  # If the max observed photosynthesis is <= 0 (or very close), 
  # NLS will fail or give nonsense. Skip directly to Empirical.
  if(max_obs <= 0.5) {
    return(data.frame(
      Method = "Empirical (Respiring)",
      Asat = max_obs, # This will be the negative number you want
      Km = NA # Km is undefined if never positive
    ))
  }
  
  # --- CHECK 2: Try NLS ---
  tryCatch({
    fit <- nlsLM(Photo ~ nrh_model(PARi, Asat_Gross, phi, theta, Rd),
                 data = df_curve,
                 start = list(Asat_Gross = max(5, max_obs), phi = 0.05, theta = 0.7, Rd = 1),
                 lower = c(Asat_Gross = 0, phi = 0, theta = 0, Rd = 0), 
                 upper = c(Asat_Gross = 60, phi = 0.1, theta = 0.99, Rd = 10),
                 control = nls.lm.control(maxiter = 100))
    
    coefs <- coef(fit)
    
    # Calculate NET Assimilation (Gross - Respiration)
    # This is what matches your raw data observation
    net_asat <- coefs["Asat_Gross"] - coefs["Rd"]
    
    # Calculate Km
    km_val <- coefs["Asat_Gross"] / coefs["phi"]
    
    return(data.frame(
      Method = "Model",
      Asat = coefs["Asat_Gross"],
      Rd = coefs["Rd"],
      Phi = coefs["phi"],
      theta = coefs["theta"]
    ))
    
  }, error = function(e) {
    # --- CHECK 3: Fallback if NLS crashes on active plants ---
    
    # Empirical Km
    emp_km <- approx(x = df_curve$Photo, y = df_curve$PARi, xout = max_obs/2)$y
    
    return(data.frame(
      Method = "Empirical (Fallback)",
      Asat = max_obs,
      Rd = NA,
      Phi = NA,
      theta = NA
    ))
  })
}
results_list_raw <- df %>%
  split(~ group) %>%
  map(fit_robust_raw)

final_data_raw <- bind_rows(results_list_raw, .id = "group") %>%
  mutate(
    species = str_split(group, ", ", simplify = T)[,1],
    leaf_age = str_split(group, ", ", simplify = T)[,2],
    month = str_split(group, ", ", simplify = T)[,3],
    month = factor(month, levels = c("Sep", "Nov", "Dec", "Jan"))
  )
final_data_raw

# 1. Create Prediction Grid (0 to 2000 PAR)
df_predict <- expand.grid(
  PARi = seq(0, 2000, length.out = 100), 
  group = unique(df$group)
)

# 2. Merge with Coefficients
df_predict <- left_join(df_predict, final_data_raw, by = "group")

# 3. Calculate the Curve (Only where model exists)
# We use the nrh_model function we defined earlier
df_predict$Photo <- nrh_model(
  PAR = df_predict$PARi,
  Asat = df_predict$Asat,
  phi = df_predict$Phi,
  theta = df_predict$theta,
  Rd = df_predict$Rd
)

# Remove 1 really bad outlier
df_fitted <- df_fitted[which(df_fitted$PARi <= 2000),]
# Mark the removed points
df_fitted$Photo_removed <- NA
df_fitted[which(is.na(df_fitted$Photo)),]$Photo_removed <- df_fitted[which(is.na(df_fitted$Photo)),]$Photo_original
# Show
df_fitted[which(is.na(df_fitted$month)),]

df_fitted$leaf_age <- factor(df_fitted$leaf_age, levels = c('Yng', 'Mid', 'Old'))
df_predict$leaf_age <- factor(df_predict$leaf_age, levels = c('Yng', 'Mid', 'Old'))

df_fitted$date <- substr(df_fitted$timestamp, 1, 10)
df_fitted$month <- factor(df_fitted$month, levels = c('Sep','Nov','Dec','Jan'))

df_predict$month <- factor(df_predict$month, levels = c('Sep','Nov','Dec','Jan'))

df_predict[which(df_predict$species == 'Nit-S' & df_predict$leaf_age == 'Old' & df_predict$month == 'Nov'),]


plt = ggplot()
plt = plt + geom_point(data=df_fitted, aes(x = PARi, y = Photo, colour=month))
plt = plt + geom_point(data=df_fitted, aes(x = PARi, y = Photo_removed, colour=month), shape=2)
#plt = plt + geom_line(aes(x = PARi, y = Photo, colour=date))
plt = plt + geom_line(data=df_predict, aes(x = PARi, y = Photo, colour=month), linetype='dashed')
plt = plt + labs(x = "PAR", y = "Assimilation rate (Photo)",
                 colour='Month', shape='Month', linetype='Month')
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + coord_cartesian(ylim=c(-5,20))
plt = plt + theme_bw()
#plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
plt = plt + theme(text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'supplement/all_curves_fitted2.pdf'), width=20, height=14, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/all_curves_fitted2.jpg'), width=20, height=14, units = "cm", scale=1.25, dpi = 600)

# 2c1) Double reciprocal (Lineweaver–Burk) transformation plots ####
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# # Old method, Based on Michaelis Menten
# 
# # Create backup columns
# df$PARi_inv  <- 1/df$PARi
# df$Photo_inv <- 1/df$Photo
# 
# df$Photo_inv_original <- df$Photo_inv
# df$PARi_inv_original  <- df$PARi_inv
# 
# df[which(df$leaf_age == 'Yng' & df$species == 'Nit-S' & df$date == '2023-12-18'),
#    c("timestamp","measurement_type","species","leaf_age","season","daytime","Obs","Photo","Photo_inv","PARi","PARi_inv","filename")]
# 
# 
# # Remove outliers
# df[which(df$Photo == 0),]$Photo_inv <- NA
# 
# df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2023_09_13") & (df$PARi <= 123)),]$Photo_inv <- NA
# 
# df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2023_09_13") & (df$PARi <= 150)),]$Photo_inv <- NA
# df[which((df$filename == "Erin_Nitida3_Mid_FLRC_2023_09_13") & (df$PARi == 202)),]$Photo_inv <- NA
# 
# df[which(df$filename == "Erin_Nitida3_Old_FLRC_2023_12_18"),]$Photo_inv <- NA
# 
# df[which((df$filename == "Erin_NitAdt3_Mid_FLRC_2024_01_25") & (df$PARi <= 100)),]$Photo_inv <- NA
# df[which((df$filename == "Erin_NitAdt3_Mid_FLRC_2024_01_25") & (df$Photo <= 0.5)),]$Photo_inv <- NA
# 
# df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2023_12_18") & (df$Photo <= 0.6)),]$Photo_inv <- NA
# df[which((df$filename == "Erin_Nitida3_Yng_FLRC_2023_12_18") & (df$PARi == 175)),]$Photo_inv <- NA
# 
# df[which((df$filename == "Erin_Repens3_Old_FLRC_2023_12_18") & (df$Photo >= -1.07)),]$Photo_inv <- NA
# 
# # Add removed points
# df$Photo_inv_removed <- NA
# df[which(is.na(df$Photo_inv)),]$Photo_inv_removed <- df[which(is.na(df$Photo_inv)),]$Photo_inv_original
# #df[which(df$Photo_inv_removed == 0),]$Photo_inv_removed <- NA
# 
# # Check things
# # plt = ggplot(df[which(df$date == '2023-12-18'),])
# # plt = plt + geom_point(aes(x = PARi_inv, y = Photo_inv, colour=date))
# # plt = plt + geom_smooth(aes(x = PARi_inv, y = Photo_inv, colour=date),
# #                         method="lm", linetype='dashed', size=0.5)
# # plt = plt + geom_point(aes(x = PARi_inv, y = Photo_inv_removed, colour=date), shape=2)
# # plt = plt + labs(x = "1/PAR", y = expression("1/A"["net"]))
# # plt = plt + facet_grid(species ~ leaf_age)
# # plt = plt + coord_cartesian(ylim=c(-0.75,1.5))
# # plt = plt + theme_bw()
# # plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
# # plt
# 
# plt = ggplot(df)
# plt = plt + geom_point(aes(x = PARi_inv, y = Photo_inv, colour=month))
# plt = plt + geom_smooth(aes(x = PARi_inv, y = Photo_inv, colour=month),
#                         method="lm", linetype='dashed', size=0.5)
# plt = plt + geom_point(aes(x = PARi_inv, y = Photo_inv_removed, colour=month), shape=2)
# plt = plt + labs(x = "1/PAR", y = expression("1/A"["net"]),
#                  colour='Month', shape='Month', linetype='Month')
# plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
# plt = plt + facet_grid(species ~ leaf_age)
# plt = plt + coord_cartesian(ylim=c(-0.75,1.5))
# plt = plt + theme_bw()
# plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
#                   text=element_text(family="serif"))
# plt
# ggsave(paste0(graphs_path, 'supplement/all_curves_fitted_michaelismenten.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)
# ggsave(paste0(graphs_path, 'supplement/all_curves_fitted_michaelismenten.pdf'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)
# 
# # 2c2) Extract slope & intercept ####
# # - - - - - - - - - - - - - - - - - -
# 
# # Fit the model with interaction (this allows both slopes and intercepts to differ)
# m1 <- lm('Photo_inv ~ PARi_inv * group', data=df)
# coefs <- coef(m1)
# print(coefs)
# 
# # Get the levels of the group factor
# grp_levels <- unique(df$group)
# 
# # Initialize a results data frame
# results <- data.frame(group = character(),
#                       intercept = numeric(),
#                       slope = numeric(),
#                       stringsAsFactors = FALSE)
# 
# # Loop through each group and compute its intercept and slope
# for(g in grp_levels) {
#   if(g == grp_levels[1]) {
#     # For the baseline group (first level)
#     int_val <- coefs["(Intercept)"]
#     slope_val <- coefs["PARi_inv"]
#   } else {
#     # For other groups, add the corresponding group differences
#     int_val <- coefs["(Intercept)"] + coefs[paste0("group", g)]
#     slope_val <- coefs["PARi_inv"] + coefs[paste0("PARi_inv:group", g)]
#   }
#   results <- rbind(results, data.frame(group = g, intercept = int_val, slope = slope_val))
# }
# 
# # Calculate A_sat and k_m (Michaelis constant)
# # 0 intercept is 1/A_sat
# results$A_sat <- 1/results$intercept
# # extrapolate to the origin (y=0) is 1/k_m (Michaelis constant)
# # y = mx + q = 0 -> x = -q/m -> -1/x = m/q
# results$k_m <- -(-results$slope/results$intercept)
# 
# print(results)
# 
# library(tidyr)
# results <- results %>%
#   separate(group, into = c("group", "leaf_age", "month"), sep = ", ") %>%
#   mutate(month = factor(month, levels = c('Sep','Nov','Dec','Jan')),
#          leaf_age = factor(leaf_age, levels = c('Yng', 'Mid', 'Old'))) %>%
#   arrange(group, leaf_age, month)
# results

# # Save as latex
# library(xtable)
# print.xtable(xtable(results, digits=c(0,0,0,0,2,2,2,2)), file = paste0(graphs_path, 'slope_intercept_km_Asat.tex'),
#              include.rownames=F)
# 
# # Save as .csv
# write.csv(results, file=paste0(graphs_path, 'slope_intercept_km_Asat.csv'),na='',row.names=FALSE)
# # Reduce digits in .csv
# results_digits <- results %>% 
#   mutate_if(is.numeric, ~ round(., 2))
# write.csv(results_digits, file=paste0(graphs_path, 'slope_intercept_km_Asat_digits.csv'),na='',row.names=FALSE)
# 
# # Group by species/group, ignoring leaf age
# res_sum <- results[,c('group', 'month', 'A_sat', 'k_m')] %>%
#   group_by(group, month) %>%
#   summarise(
#     across(where(is.numeric), list(
#       mean = ~mean(.x, na.rm = TRUE),
#       #median = ~median(.x, na.rm = TRUE),
#       stddev = ~sd(.x, na.rm = TRUE)
#     ), .names = "{.col}_{.fn}")
#   )
# res_sum$A_sat <- paste0(round(res_sum$A_sat_mean,2), '±', round(res_sum$A_sat_stddev,2))
# res_sum$k_m <- paste0(round(res_sum$k_m_mean,2), '±', round(res_sum$k_m_stddev,2))
# res_sum$A_sat_mean <- NULL
# res_sum$A_sat_stddev <- NULL
# res_sum$k_m_mean <- NULL
# res_sum$k_m_stddev <- NULL
# res_sum
# write.csv(res_sum, file=paste0(graphs_path, 'table_km_Asat_summarised.csv'),na='',row.names=FALSE)

# Plot it
# - - - -
# Wide to long
temp <- results
temp$intercept <- NULL
temp$slope <- NULL

temp <- temp %>% pivot_longer(!c(group, leaf_age, month), names_to = "variable", values_to = "values")
temp$month_num <- NA
temp[which(temp$month == 'Sep'),]$month_num <- 9
temp[which(temp$month == 'Nov'),]$month_num <- 11
temp[which(temp$month == 'Dec'),]$month_num <- 12
temp[which(temp$month == 'Jan'),]$month_num <- 13
temp <- temp[which(!is.na(temp$values)),]
plt = ggplot(temp)
plt = plt + geom_point(aes(x = month_num, y = values, colour=leaf_age))
plt = plt + geom_line(aes(x = month_num, y = values, colour=leaf_age, linetype=leaf_age))
plt = plt + labs(x = "Month", y = "Values",
                 colour='Leaf Age', linetype='Leaf Age')
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + facet_grid(variable ~ group, scales="free_y")
plt = plt + theme_bw()
plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
                  text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'vmax_km_linear.jpg'), width=15, height=10, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(temp)
plt = plt + geom_boxplot(aes(x = month, y = values))
plt = plt + facet_grid(variable ~ group, scales="free_y")
plt = plt + labs(x = "Month", y = "Values")
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'vmax_km_boxplots.jpg'), width=15, height=10, units = "cm", scale=1.25, dpi = 600)


# 2c3) Multiple regression ####
# - - - - - - - - - - - - - - -

#install.packages("emmeans")
library(emmeans)

df$group <- paste0(df$species, ', ', df$leaf_age, ', ', df$month)

# Fit the model with interaction (this allows both slopes and intercepts to differ)
m1 <- lm('Photo_inv ~ PARi_inv * group', data=df)

# Use emtrends() to estimate the slope (trend) for each group
slope_est <- emtrends(m1, specs = "group", var = "PARi_inv")
print(slope_est)

# Get pairwise comparisons of slopes across groups
pairwise_slopes <- pairs(slope_est)

# Typically, intercepts are compared at a specific value of x.
# Here we compare the estimated group means (i.e., intercepts) at x = 0.
# (If x = 0 is not meaningful, you can choose at = list(x = mean(dat$x)) )
emm_intercepts <- emmeans(m1, specs = "group", at = list(x = 0))
print(emm_intercepts)

# Get pairwise comparisons of intercepts
pairwise_intercepts <- pairs(emm_intercepts)

# Re-label
# results[which(results$slope_diff_p < 0.05),]$slope_diff_p <- '<0.05'
# results[which(results$slope_diff_p > 0.01),]$slope_diff_p <- 'n.s.'

pairwise_slopes     <- as.data.frame(pairwise_slopes)
pairwise_slopes$estimate <- NULL
pairwise_slopes$SE       <- NULL
pairwise_slopes$df       <- NULL
pairwise_slopes$t.ratio  <- NULL
names(pairwise_slopes)[names(pairwise_slopes) == 'p.value'] <- 'p_slopes'
pairwise_intercepts <- as.data.frame(summary(pairwise_intercepts))
pairwise_intercepts$estimate <- NULL
pairwise_intercepts$SE       <- NULL
pairwise_intercepts$df       <- NULL
pairwise_intercepts$t.ratio  <- NULL
names(pairwise_intercepts)[names(pairwise_intercepts) == 'p.value'] <- 'p_intercepts'
pairs <- left_join(pairwise_intercepts, pairwise_slopes, by='contrast')

pairs

# Show only the ones where both slope & intercept are significantly different
#pairs_sig <- pairs[which((pairs$p_slopes < 0.1) & (pairs$p_intercepts < 0.1)),]
pairs_sig <- pairs
pairs_sig$contrast <- gsub("_", ", ", pairs_sig$contrast)
pairs_sig$contrast <- gsub("\\(", "", pairs_sig$contrast)
pairs_sig$contrast <- gsub(")", "", pairs_sig$contrast)
class(pairs_sig) <- "data.frame"


# Split the categories
library(dplyr)
library(tidyr)
library(stringr)

psig <- pairs_sig %>%
  # Split the combo column into two parts using " - " as delimiter
  mutate(parts = str_split_fixed(contrast, " - ", 2),
         part1 = parts[, 1],
         part2 = parts[, 2]) %>%
  # Separate each part into its components (species, age, date)
  separate(part1, into = c("Spec1", "Age1", "Month1"), sep = ",\\s*") %>%
  separate(part2, into = c("Spec2", "Age2", "Month2"), sep = ",\\s*") %>%
  # Combine the corresponding elements with " - " as a separator
  mutate(
    Spec = paste(Spec1, Spec2, sep = " - "),
    Age  = paste(Age1, Age2, sep = " - "),
    Month = paste(Month1, Month2, sep = " - ")
  ) %>%
  select(Spec, Age, Month, p_intercepts, p_slopes)

names(psig)[names(psig) == "Spec"] <- "Group"

# Save as latex
library(xtable)
print.xtable(xtable(psig, digits=c(0,0,0,0,2,2)), file = paste0(graphs_path, 'slope_intercept_comparison.tex'),
             include.rownames=F)
# Save as .csv
write.csv(psig, file=paste0(graphs_path, 'slope_intercept_comparison.csv'),na='',row.names=FALSE)

# Reshape (if needed)

p_wide <- psig %>%
  pivot_wider(
    id_cols = c(age, date),       # retain these as identifiers
    names_from = spec,              # use the combined age values as new column names
    values_from = c(p_intercepts, p_slopes),            # fill the cells with the spec values
    names_sep = "_"               # optional: to separate the id and new names in the result
  )

print.xtable(xtable(p_wide, digits=c(0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2)), file = paste0(graphs_path, 'slope_intercept_comparison.tex'),
             include.rownames=F)

# TEST getting species lambda, so I can get A from LI-600 ####
estimate_g1_lambda <- function(g_s, VPD, A, C_CO2) {
  # Calculate g1 for each measurement using the rearranged equation
  g1_vals <- ((g_s * C_CO2) / (1.6 * A) - 1) * sqrt(VPD)
  
  # Estimate g1 as the mean of the individual measurements, ignoring any NAs
  #g1_est <- mean(g1_vals, na.rm = TRUE)
  g1_est <- g1_vals
  
  # Compute lambda from the estimated g1
  lambda_est <- 1 / (g1_est^2)
  
  # Return the estimates as a list
  #return(list(g1 = g1_est, lambda = lambda_est))
  return(lambda_est)
}

names(df)
df$lambda <- estimate_g1_lambda(df$Cond, df$VpdL, df$Photo, df$CO2R)
df[,c("timestamp","measurement_type","species","specimen","leaf_age","season","daytime","CO2R","CO2S")]

df_summary <- df[which(df$PARi > 500),] %>%
  group_by(species,leaf_age) %>%
  summarise(
    mean_value   = mean(lambda, na.rm = TRUE),
    median_value = median(lambda, na.rm = TRUE),
    stddev_value = sd(lambda, na.rm = TRUE)
  )
df_summary

plt = ggplot()
plt = plt + geom_point(data=df, aes(x = PARi, y = lambda, colour=month))
plt = plt + labs(x = "PAR", y = "lambda",
                 colour='Month', shape='Month', linetype='Month')
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + coord_cartesian(ylim=c(0,5))
plt = plt + theme_bw()
#plt = plt + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
plt

# 3) Other variables plotted ####
# - - - - - - - - - - - - - - - -

temp <- df[which(df$PARi <= 2000),]
temp$leaf_age <- factor(temp$leaf_age, levels = c('Yng', 'Mid', 'Old'))
temp$date <- substr(temp$timestamp, 1, 10)
plt = ggplot()
plt = plt + geom_point(data=temp, aes(x = PARi, y = Cond, colour=date))
plt = plt + geom_hline(yintercept=0, colour='red')
plt = plt + labs(x = "PAR", y = "Stomatal conductance")
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + theme_bw()
plt
ggsave(paste0(graphs_path, 'all_curves_fitted_cond.pdf'), width=20, height=27, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'all_curves_fitted_cond.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot()
plt = plt + geom_point(data=temp, aes(x = PARi, y = PhiPS2, colour=date))
plt = plt + labs(x = "PAR", y = "PhiPS2")
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + theme_bw()
plt
ggsave(paste0(graphs_path, 'all_curves_fitted_PhiPS2.pdf'), width=20, height=27, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'all_curves_fitted_PhiPS2.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

names(df)
plt = ggplot()
plt = plt + geom_point(data=temp, aes(x = PARi, y = ETR, colour=date))
plt = plt + labs(x = "PAR", y = "ETR")
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + theme_bw()
plt
ggsave(paste0(graphs_path, 'all_curves_fitted_ETR.pdf'), width=20, height=27, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'all_curves_fitted_ETR.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)


plt = ggplot()
plt = plt + geom_point(data=temp, aes(x = PARi, y = Fv..Fm., colour=date))
plt = plt + labs(x = "PAR", y = "Fv..Fm.")
plt = plt + facet_grid(species ~ leaf_age)
plt = plt + theme_bw()
plt
ggsave(paste0(graphs_path, 'all_curves_fitted_FvFm.pdf'), width=20, height=27, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'all_curves_fitted_FvFm.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

# 4) A-Ci curves ####
# - - - - - - - - - -

aci <- full[which(full$type == 'ACi'),]
summary(aci)
unique(aci$season)
unique(aci$leaf_age)
unique(aci$daytime)

nrow(aci[which(aci$daytime == 'noon'),])
nrow(aci[which(aci$daytime == 'morning'),])

df[which(df$daytime == 'morning'),]$timestamp

# 10) Test package photosynthesis ####
# - - - - - - - - - - - - - - - - - -

current_file <- "Erin_Nitida3_Old_FLRC_2023_12_18"
temp <- df[which(df$filename == current_file),]
temp <- temp[which(!(temp$Photo > 2)),]
temp <- temp[which(!((temp$Photo > 2) & (temp$PARi < 800))),]
temp <- temp[which(!(temp$PARi > 1200)),]
plt = ggplot(temp, aes(PARi, Photo))
plt = plt + geom_point(data = df[which(df$filename == current_file),], colour='red')
plt = plt + geom_point(data = temp)
plt = plt + labs(title = current_file,
  x = expression("PAR irradiance (" * mu * mol ~ m^{-2} ~ s^{-1} * ")"),
  y = expression(A[net] ~ "(" * mu * mol ~ m^{-2} ~ s^{-1} * ")")
)
plt = plt + theme_bw()
plt = plt + coord_cartesian(xlim = c(0,2000))
plt

# Fit one light-response curve
fit = fit_photosynthesis(
  .data = temp[which(!is.na(temp$Photo)),],
  .photo_fun = "aq_response",
  .vars = list(.A = Photo, .Q = PARi),
)

# The 'fit' object inherits class 'nls' and many methods can be used

## Model summary:
summary(fit)
coef(fit)

## Calculate light compensation point
coef(fit) |>
  t() |>
  as.data.frame() |>
  mutate(LCP = ((Rd) * (Rd * theta_J - k_sat) / (phi_J * (Rd - k_sat)))) |>
  
  ## Calculate residual sum-of-squares
  sum(resid(fit) ^ 2)

b = coef(fit)

df_predict = data.frame(PARi = seq(0, 2000, length.out = 100)) |>
  mutate(
    Photo = marshall_biscoe_1980(
      Q_abs = PARi,
      k_sat = b["k_sat"],
      b["phi_J"],
      b["theta_J"]
    ) - b["Rd"]
  )


plt = ggplot(mapping = aes(PARi, Photo))
plt = plt + geom_line(data = df_predict)
plt = plt + geom_point(data = df[which(df$filename == current_file),], colour='red')
plt = plt + geom_point(data = temp)
plt = plt + labs(title = unique(temp$filename),
    x = expression("PAR irradiance (" * mu * mol ~ m^{-2} ~ s^{-1} * ")"),
    y = expression(A[net] ~ "(" * mu * mol ~ m^{-2} ~ s^{-1} * ")")
  )
plt = plt + theme_bw()
plt


# 10a) Check other variables ####

names(temp)
temp[,c('timestamp','Cond')]
plt = ggplot(temp, mapping = aes(PARi, Cond))
plt = plt + geom_line()
plt = plt + geom_point()
plt = plt + labs(title = unique(temp$filename),
                 x = expression("PAR irradiance (" * mu * mol ~ m^{-2} ~ s^{-1} * ")"),
                 y = expression(g[sw] ~ "(" * mu * mol ~ m^{-2} ~ s^{-1} * ")")
)
plt = plt + theme_bw()
plt

unique(df$filename)
current_file <- c("Erin_Nitida3_Yng_FLRC_2023_09_13",
                  "Erin_Nitida3_Yng_FLRC_2023_11_21",
                  "Erin_Nitida3_Yng_FLRC_2023_12_18",
                  "Erin_Nitida3_Yng_FLRC_2024_01_25")
current_file <- c("Erin_Repens1_Yng_FLRC_2023_09_13",
                  "Erin_Repens1_Yng_FLRC_2023_11_21",
                  "Erin_Repens3_Yng_FLRC_2023_12_18",
                  "Erin_Repens3_Yng_FLRC_2024_01_25")
# current_file <- c("Erin_NitAdt3_Yng_FLRC_2023_09_13",
#                   "Erin_NitAdt3_Yng_FLRC_2023_11_21",
#                   "Erin_NitAdt3_Yng_FLRC_2023_12_18",
#                   "Erin_NitAdt3_Yng_FLRC_2024_01_25")
temp <- df[which(df$filename %in% current_file),]
temp$date <- substr(temp$timestamp, 1, 10)
temp_all <- temp

#temp <- temp[which(!(temp$Cond > 0.05)),]

plt = ggplot(mapping = aes(x=PARi, y=Cond, colour=date))
#plt = plt + geom_point(data=temp_all, aes(x=PARi, y=Cond, shape=date), colour='red',)
plt = plt + geom_point(data=temp)
plt = plt + labs(title = unique(temp$filename),
                 x = expression("PAR irradiance [" * mu * mol ~ m^{-2} ~ s^{-1} * "]"),
                 y = expression(g[sw] ~ "[" * mu * mol ~ m^{-2} ~ s^{-1} * "]")
)
plt = plt + theme_bw()
plt

temp[,c('PARi','Cond','Photo_original')]

# 10b) PhiPS2, ETR corr. ####
# - - - - - - - - - - - - - - -

current_file <- "Erin_Nitida3_Old_FLRC_2023_12_18"
temp <- df[which(df$filename == current_file),]
temp <- temp[which(!(temp$Photo > 2)),]
temp <- temp[which(!((temp$Photo > 2) & (temp$PARi < 800))),]
temp <- temp[which(!(temp$PARi > 1200)),]
plt = ggplot(temp, aes(PARi, PhiPS2))
plt = plt + geom_point(data = df[which(df$filename == current_file),], colour='red')
plt = plt + geom_point(data = temp)
plt = plt + labs(title = current_file,
                 x = expression("PAR irradiance (" * mu * mol ~ m^{-2} ~ s^{-1} * ")"),
                 y = expression(Phi[PSII] ~ "(" * mu * mol ~ m^{-2} ~ s^{-1} * ")")
)
plt = plt + theme_bw()
plt = plt + coord_cartesian(xlim = c(0,2000))
plt

plt = ggplot(temp, aes(PARi, ETR))
plt = plt + geom_point(data = df[which(df$filename == current_file),], colour='red')
plt = plt + geom_point(data = temp)
plt = plt + labs(title = current_file,
                 x = expression("PAR irradiance (" * mu * mol ~ m^{-2} ~ s^{-1} * ")"),
                 y = expression(ETR ~ "(" * mu * mol ~ m^{-2} ~ s^{-1} * ")")
)
plt = plt + theme_bw()
plt = plt + coord_cartesian(xlim = c(0,2000))
plt