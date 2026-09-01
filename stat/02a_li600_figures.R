# Header ####

# library(here)
# library(psych)
# library(dplyr)
# library(readr)
# library(agricolae)
# library(knitr)
# library(kableExtra)
library(ggplot2)
library(ggpubr)
library(tidyr)

# The original script relied on these being attached from an interactive session,
# so it fails under Rscript. Loading them explicitly changes no result.
library(dplyr)
library(rlang)
library(lme4)
library(glmmTMB)
library(emmeans)
library(DHARMa)
library(rstatix)

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
  sets <- unique(lapply(sets, function(s) all_groups[all_groups %in% s]))
  keep <- rep(TRUE, length(sets))
  for (i in seq_along(sets)) {
    for (j in seq_along(sets)) {
      if (i != j && keep[i] && all(sets[[i]] %in% sets[[j]]) &&
          length(sets[[i]]) < length(sets[[j]])) keep[i] <- FALSE
    }
  }
  sets <- sets[keep]
  sets <- sets[order(vapply(sets, function(s) min(match(s, all_groups)), numeric(1)))]
  out <- do.call(rbind, lapply(seq_along(sets), function(k)
    data.frame(group = sets[[k]], letter = letters[k], stringsAsFactors = FALSE)))
  aggregate(letter ~ group, data = out,
            FUN = function(x) paste0(sort(unique(x)), collapse = ""))
}

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

df <- read.csv(paste0(data_path, 'li600_dataset.csv'))
df$species  <- factor(df$species, levels = c("Nit-A", "Nit-S", "Rep-S"))
df$season   <- factor(df$season, levels = c("autumn", "winter", "spring", "summer"))
df$leaf_age <- factor(df$leaf_age, levels = c("Yng", "Mid", "Old"))
df$daytime  <- factor(df$daytime, levels = c("morning", "noon", "afternoon"))

# li600_dataset.csv carries 'timestamp' (datetime) but the model/aggregation code
# below expects a calendar 'date' column, which the original script assumed was
# already present in the session. Derived here so the script runs standalone.
df$date <- substr(df$timestamp, 1, 10)

# total conductance to water vapor (gtw) is computed as a function of E and vapor pressure
# stomatal conductance to water (gsw) is computed as a function of gtw and
# the boundary layer conductance to water vapor (gbw).
# VPD leaf and VP leaf
# Fs: steady state fluorescence
# Fm': maximum fluorescence from PSII during photosynthesis under light conditions when a saturating pulse of light is applied
# Tleaf: 


# 2) Boxplot (example) ####
# - - - - - - - - - - - -

# Create labels for sample size
n_labels = as.data.frame(table(df$season, df$daytime, df$leaf_age, df$species))
#n_labels$Freq = paste0('n=', n_labels$Freq)
names(n_labels)[names(n_labels) == 'Var1'] <- 'season'
names(n_labels)[names(n_labels) == 'Var2'] <- 'daytime'
names(n_labels)[names(n_labels) == 'Var3'] <- 'leaf_age'
names(n_labels)[names(n_labels) == 'Var4'] <- 'species'
#View(n_labels)

# Show gsw for all groups
graph_df <- df[which(df$timestamp != '2023-06-01'),]
filtered_df <- graph_df[graph_df$ETR >= 0, ]
plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=gsw, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('Stomatal conductance ', 'g'['sw'],' [mol m'^'-2','s'^'-1',']')), fill='Leaf Age')
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=-0.1, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime', scales="free_y")
plt = plt + coord_cartesian(ylim = c(-0.000,0.25)) # Zoom in
plt
ggsave(paste0(graphs_path, 'all_groups_gsw.jpg'), width=15, height=10, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'all_groups_gsw.pdf'), width=15, height=10, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=VPDleaf, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('VPD'['L'],' [kPa]')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=-0.005, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime', scales="free_y")
#plt = plt + coord_cartesian(ylim = c(-0.005,0.2)) # Zoom in
plt
ggsave(paste0(graphs_path, 'all_groups_VPDleaf.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=Fs, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('Steady-state fluorescence (Fs)')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=-0.005, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime', scales="free_y")
#plt = plt + coord_cartesian(ylim = c(-0.005,0.2)) # Zoom in
plt
ggsave(paste0(graphs_path, 'all_groups_Fs_steadystate_fluorescence.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=Fm., fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('Max. fluorescence from PSII (Fm\')')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=-0.005, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime', scales="free_y")
#plt = plt + coord_cartesian(ylim = c(-0.005,0.2)) # Zoom in
plt
ggsave(paste0(graphs_path, 'all_groups_Fm_max_fluorescence.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=Tleaf, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('Leaf temperature [°C]')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=10, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime', scales='free_y')
#plt = plt + coord_cartesian(ylim = c(-0.005,0.2)) # Zoom in
plt
ggsave(paste0(graphs_path, 'all_groups_Tleaf.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=PhiPS2, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste(Phi['PSII'],' [unitless]')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=10, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime')
plt = plt + coord_cartesian(ylim=c(-0.025,1))
plt
ggsave(paste0(graphs_path, 'all_groups_PhiPS2.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)

plt = ggplot(filtered_df)
plt = plt + geom_boxplot(aes(x=species, y=ETR, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Type',
                 y=expression(paste('ETR',' [',mu,'mol m'^'-2','s'^'-1',']')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=10, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
plt = plt + facet_grid('season ~ daytime')
#plt = plt + coord_cartesian(ylim=c(-0.025,1))
plt
ggsave(paste0(graphs_path, 'all_groups_ETR.jpg'), width=21, height=14, units = "cm", scale=1.25, dpi = 600)


# 3) Boxplot (Fig 2) gsw, ETR, PhiPS2 ####
# - - - - - - - - - - - - - - - - - - - -
# 
# df$date <- strftime(df$timestamp, '%Y-%m-%d')
# 
# # Median within each date, species, leaf age, specimen
# # Excluding 1 July 2023, due to outliers. Erin said the leaves were wet
# library(dplyr)
# df_summary <- df[which(df$date != '2023-06-01'),] %>%
#   group_by(date, species, leaf_age, specimen, season, daytime) %>%
#   summarize(across(where(is.numeric), ~ median(.x, na.rm = TRUE)),
#             .groups = "drop")
# graph_df <- df_summary[,c("date","season", "daytime", "species", "leaf_age","gsw","ETR","PhiPS2")] %>% 
#   pivot_longer(
#     cols = -c(date, season, daytime, species, leaf_age),
#     names_to = "variable",
#     values_to = "value"
#   )
# graph_df <- as.data.frame(graph_df)
# 
# graph_df$var_label <- NA
# graph_df[which(graph_df$variable == 'gsw'),]$var_label = 'g[sw]'
# graph_df[which(graph_df$variable == 'ETR'),]$var_label = 'ETR'
# graph_df[which(graph_df$variable == 'PhiPS2'),]$var_label = 'Phi[PSII]'
# graph_df$var_label <- factor(graph_df$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))
# 
# plt = ggboxplot(graph_df, x = "species", y = "value")
# my_comparisons <- list( c("Nit-A", "Nit-S"), c("Nit-S", "Rep-S"), c("Nit-A", "Rep-S"))
# plt = plt + stat_compare_means(aes(x="species", y="value"), comparisons = my_comparisons,
#                                label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
# #plt = plt + stat_compare_means(label.y = 0.4)
# plt = plt + facet_grid('var_label ~ season', scales="free_y", labeller = labeller(var_label = label_parsed))
# plt = plt + theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
#                   axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
#                   text=element_text(family="serif"))
# plt
# ggsave(paste0(graphs_path, 'gsw_ETR_PhiPS2_season.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
# ggsave(paste0(graphs_path, 'gsw_ETR_PhiPS2_season.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
# 
# graph_df

# 3b) Boxplot with LMM ####
# - - - - - - - - - - - - -

# 1) Aggregation function (your df2 -> df_summary steps wrapped)
aggregate_to_sampling_unit <- function(df,
                                       exclude_dates = NULL,
                                       specimen_id_cols = c("date","daytime","species","leaf_age","specimen"),
                                       group_summary_cols = c("date","species","leaf_age","specimen_id","season","daytime"),
                                       summary_fn = median) {
  # optionally drop dates
  if(!is.null(exclude_dates)) {
    df <- df %>% filter(!date %in% exclude_dates)
  }
  # create specimen_id exactly as you did
  df2 <- df %>%
    arrange(date, daytime, species, leaf_age, specimen) %>%
    mutate(specimen_id = as.integer(interaction(!!!syms(specimen_id_cols), drop = TRUE))) %>%
    ungroup()
  # aggregate numeric columns by median (or change summary_fn)
  df_summary <- df2 %>%
    group_by(across(all_of(group_summary_cols))) %>%
    summarize(across(where(is.numeric), ~ summary_fn(.x, na.rm = TRUE)),
              .groups = "drop")
  df_summary
}

# 2) Family heuristic (your original choose_family with minor tweak)
choose_family <- function(x) {
  x <- x[!is.na(x)]
  if(length(x) < 5) return("gaussian")
  minx <- min(x); maxx <- max(x)
  if(minx >= 0 && maxx <= 1) return("beta")
  if(minx > 0) {
    cv <- sd(x)/abs(mean(x))
    if(is.finite(cv) && (cv > 1.0 || (quantile(x, .9, na.rm = TRUE)/quantile(x, .5, na.rm = TRUE) > 3))) return("gamma")
  }
  return("gaussian")
}

# 3) Fit a single model (single variable across all seasons, with species*season)
fit_single_model <- function(d, value_col = "value", cluster = "date",
                             add_daytime_random = TRUE, family_hint = NULL,
                             transform_beta_eps = 1e-6) {
  # prepare data: factors
  d <- d %>%
    mutate(species = factor(species),
           season = factor(season),
           daytime = factor(daytime))
  # select family
  fam <- if(is.null(family_hint)) choose_family(d[[value_col]]) else family_hint
  # build random formula
  rnd <- if(add_daytime_random) {
    paste0("(1 | ", cluster, ") + (1 | ", cluster, ":daytime)")
  } else {
    paste0("(1 | ", cluster, ")")
  }
  form <- as.formula(paste(value_col, "~ species * season +", rnd))
  
  # transform for beta if needed
  dfit <- d
  if(fam == "beta") {
    dfit <- dfit %>%
      mutate(!!value_col := pmax(pmin(.data[[value_col]], 1 - transform_beta_eps), transform_beta_eps))
    fam_obj <- glmmTMB::beta_family(link = "logit")
  } else if(fam == "gamma") {
    fam_obj <- Gamma(link = "log")
  } else {
    fam_obj <- gaussian()
  }
  
  # fit model (try glmmTMB for non-gaussian, lmer or glmmTMB for gaussian)
  fit <- tryCatch({
    if(fam == "gaussian") {
      # try lmer first (fast & standard), fallback to glmmTMB
      tryCatch(lme4::lmer(form, data = dfit, REML = FALSE),
               error = function(e) {
                 message("lmer failed; trying glmmTMB for gaussian: ", e$message)
                 glmmTMB::glmmTMB(form, data = dfit, family = gaussian())
               })
    } else {
      glmmTMB::glmmTMB(form, data = dfit, family = fam_obj)
    }
  }, error = function(e) {
    message("Model fit error: ", e$message)
    NULL
  })
  
  list(fit = fit, data_for_fit = dfit, family = fam)
}

# 4) Run DHARMa diagnostics (optional)
run_dharma <- function(fit_obj) {
  if(is.null(fit_obj)) return(NULL)
  sim <- tryCatch({
    DHARMa::simulateResiduals(fittedModel = fit_obj, plot = FALSE)
  }, error = function(e) {
    message("DHARMa simulation failed: ", e$message); NULL
  })
  if(!is.null(sim)) {
    # run tests and show them (not saved)
    try({ print(DHARMa::testUniformity(sim)) }, silent = TRUE)
    try({ print(DHARMa::testDispersion(sim)) }, silent = TRUE)
  }
  sim
}

# 5) Robust extractor for group1/group2 from contrast strings (your version, wrapped)
extract_groups <- function(contrast_str, species_levels) {
  if(is.na(contrast_str) || contrast_str == "") return(c(NA_character_, NA_character_))
  s <- as.character(contrast_str)
  s_clean <- gsub("[()]", "", s)
  s_clean <- gsub("\\s+", " ", trimws(s_clean))
  # direct match
  found <- species_levels[sapply(species_levels, function(sp) { grepl(sp, s_clean, fixed = TRUE) })]
  if(length(found) >= 2) return(found[1:2])
  # token-based fallback
  tokens <- stringr::str_extract_all(s_clean, "[A-Za-z0-9\\-]+")[[1]]
  if(length(tokens) >= 2) {
    matched <- intersect(species_levels, tokens)
    if(length(matched) >= 2) return(matched[1:2])
  }
  parts <- strsplit(s_clean, split = " - | / | vs | vs\\. |/|:|,|\\|")[[1]]
  parts <- trimws(parts); parts <- gsub("[()]", "", parts); parts <- parts[parts != ""]
  matched <- species_levels[sapply(species_levels, function(sp) any(grepl(sp, parts, fixed = TRUE)))]
  if(length(matched) >= 2) return(matched[1:2])
  return(c(NA_character_, NA_character_))
}

# 6) Get emmeans pairwise contrasts per season, with robust checks and fallbacks
get_emmeans_pairs <- function(fit_obj, data_used, value_col = "value",
                              p_adjust = "holm", emmeans_type = "response",
                              quiet = FALSE) {
  if (is.null(fit_obj)) return(NULL)
  if (!("season" %in% names(data_used)) || !("species" %in% names(data_used))) {
    if(!quiet) message("data_used lacks 'season' or 'species' columns; cannot compute emmeans by season.")
    return(NULL)
  }
  
  # seasons that actually have >=2 species (safe)
  species_counts <- data_used %>% group_by(season) %>% summarise(n_species = n_distinct(species), .groups = "drop")
  seasons_to_do <- species_counts %>% filter(n_species >= 2) %>% pull(season)
  if (length(seasons_to_do) == 0) {
    if(!quiet) message("No season has >= 2 species; skipping emmeans.")
    return(NULL)
  }
  
  all_pw <- list()
  for(s in seasons_to_do) {
    em <- tryCatch({
      emmeans::emmeans(fit_obj, ~ species | season, at = list(season = s), type = emmeans_type)
    }, error = function(e) {
      if(!quiet) message("emmeans() failed for season ", s, ": ", e$message)
      return(NULL)
    })
    if(is.null(em)) next
    
    pr <- tryCatch({
      pairs(em, adjust = p_adjust)
    }, error = function(e) {
      if(!quiet) message("pairs() failed for season ", s, ": ", e$message)
      return(NULL)
    })
    if(is.null(pr)) next
    
    df_pr <- as.data.frame(pr)
    # create a 'contrast' column robustly (some versions put it as a character column)
    if(!"contrast" %in% names(df_pr)) {
      char_cols <- names(df_pr)[sapply(df_pr, is.character)]
      if(length(char_cols) > 0) df_pr$contrast <- df_pr[[char_cols[1]]] else df_pr$contrast <- rownames(df_pr)
    }
    df_pr$season <- s
    all_pw[[as.character(s)]] <- df_pr
  }
  
  if(length(all_pw) == 0) return(NULL)
  res <- bind_rows(all_pw)
  # add group1/group2 using your extractor (to be robust)
  species_levels <- unique(as.character(data_used$species))
  groups_mat <- t(vapply(as.character(res$contrast),
                         FUN = extract_groups,
                         FUN.VALUE = character(2),
                         species_levels = species_levels))
  res$group1 <- groups_mat[,1]
  res$group2 <- groups_mat[,2]
  res
}


# 7) Format pairwise table for ggpubr::stat_pvalue_manual
format_stat_table_for_plot <- function(pw_df, data_used, varname = "var", var_label = NULL,
                                       value_col = "value", y_offset_frac = 0.08, p_col_name = NULL,
                                       debug = FALSE) {
  if (is.null(pw_df) || nrow(pw_df) == 0) return(NULL)
  if (!(value_col %in% names(data_used))) stop("value_col '", value_col, "' not found in data_used")
  
  # Prefer explicit p-column names (most reliable)
  prefer_names <- c("p.value", "p.value.adj", "p.adj", "p.adjusted", "p", "adj.p.value", "p.val")
  found_pref <- intersect(prefer_names, names(pw_df))
  if(!is.null(p_col_name) && p_col_name %in% names(pw_df)) {
    chosen_pcol <- p_col_name
  } else if(length(found_pref) > 0) {
    chosen_pcol <- found_pref[1]
  } else {
    # fallback: find numeric columns with typical p ranges but be conservative:
    numeric_cols <- names(pw_df)[sapply(pw_df, is.numeric)]
    cand <- numeric_cols[sapply(numeric_cols, function(nm) {
      v <- pw_df[[nm]]
      # prefer columns that are in [0,1] and not almost constant
      (all(is.na(v) | (v >= 0 & v <= 1)) && (sd(v, na.rm = TRUE) > 1e-8))
    })]
    if(length(cand) > 0) chosen_pcol <- cand[1] else chosen_pcol <- numeric_cols[1]
  }
  
  if(debug) {
    message("format_stat_table_for_plot: chosen p-column = ", chosen_pcol)
    if(debug) print(head(pw_df[, intersect(names(pw_df), c(chosen_pcol, "contrast", "group1", "group2", "season"))], 6))
  }
  
  # compute ymax per season (use provided value_col)
  ymax_tab <- data_used %>%
    group_by(season) %>%
    summarise(
      ymax = max(.data[[value_col]], na.rm = TRUE),
      ymin = min(.data[[value_col]], na.rm = TRUE),
      yrange = ymax - ymin,
      .groups = "drop"
    )
  
  if(!"season" %in% names(pw_df)) pw_df$season <- NA
  
  res <- pw_df %>%
    mutate(p.value = .data[[chosen_pcol]],
           p.adj = p.value,
           p.signif = case_when(
             p.adj < 0.001 ~ "***",
             p.adj < 0.01  ~ "**",
             p.adj < 0.05  ~ "*",
             TRUE ~ "ns"
           )) %>%
    left_join(ymax_tab, by = "season") %>%
    mutate(y.position = ifelse(!is.na(ymax),
                               ymax + y_offset_frac * pmax(yrange, abs(ymax) * 0.05),
                               NA_real_),
           var = varname,
           var_label = ifelse(is.null(var_label), varname, var_label)) %>%
    select(group1, group2, p.adj, p.signif, y.position, season, var, var_label)
  
  res
}

# 8) Wrapper that iterates over variables (uses the above functions)
fit_pairwise_by_variable_and_season <- function(df_summary,
                                                value_vars = c("gsw","ETR","PhiPS2"),
                                                cluster = "date",
                                                add_daytime_random = TRUE,
                                                p_adjust = "holm",
                                                family_heuristic = TRUE,
                                                emmeans_type = "response") {
  all_fits <- list(); all_emms <- list(); all_stat_tables <- list()
  
  for(v in value_vars) {
    if(!v %in% names(df_summary)) {
      message("Variable ", v, " not found in df_summary; skipping.")
      next
    }
    # create long-ish df used downstream (similar to your graph_df)
    d <- df_summary %>%
      select(all_of(c("season","species","daytime", cluster, v))) %>%
      rename(value = all_of(v)) %>%
      mutate(season = factor(season, levels = c("winter","spring","summer","autumn")),
             species = factor(species),
             daytime = factor(daytime))
    
    # skip if no rows
    if(nrow(d) == 0) next
    
    # choose family
    fam <- if(family_heuristic) choose_family(d$value) else "gaussian"
    message("Variable: ", v, " -> family: ", fam)
    
    # fit model
    fit_info <- fit_single_model(d, value_col = "value", cluster = cluster,
                                 add_daytime_random = add_daytime_random,
                                 family_hint = fam)
    fit <- fit_info$fit
    if(is.null(fit)) {
      warning("Fit failed for ", v, "; skipping.")
      next
    }
    all_fits[[v]] <- fit
    
    # diagnostics (try)
    sim <- run_dharma(fit)
    
    # get emmeans pairs (with safeguards)
    pw_df <- get_emmeans_pairs(fit, data_used = fit_info$data_for_fit,
                               value_col = "value", p_adjust = p_adjust,
                               emmeans_type = emmeans_type)
    # format stat table (if we have pw_df)
    stat_tbl <- NULL
    if(!is.null(pw_df)) {
      stat_tbl <- format_stat_table_for_plot(pw_df, data_used = fit_info$data_for_fit,
                                             varname = v, var_label = v)
      all_emms[[v]] <- pw_df
      all_stat_tables[[v]] <- stat_tbl
    } else {
      message("No pairwise results for variable ", v)
    }
  }
  
  list(fits = all_fits, emmeans = all_emms, stat_table = bind_rows(all_stat_tables))
}


# Run LMM ####
# - - - - - - -
# 1) Aggregate (example: exclude date '2023-06-01' as you did)
df_summary <- aggregate_to_sampling_unit(df, exclude_dates = c("2023-06-01"))

# 2) Run wrapper
res <- fit_pairwise_by_variable_and_season(df_summary,
                                          value_vars = c("gsw","ETR","PhiPS2"),
                                          cluster = "date",
                                          add_daytime_random = TRUE,
                                          p_adjust = "holm",
                                          family_heuristic = TRUE,
                                          emmeans_type = "response")
#
# 3) res$stat_table is formatted for use with ggpubr::stat_pvalue_manual
head(res$stat_table)

p_table <- res$stat_table %>%
  mutate(season = as.character(season),
         var_label = as.character(var_label),
         group1 = as.character(group1),
         group2 = as.character(group2))
p_table
p_table$var_label <- NA
p_table[which(p_table$var == 'gsw'),]$var_label = 'g[sw]'
p_table[which(p_table$var == 'ETR'),]$var_label = 'ETR'
p_table[which(p_table$var == 'PhiPS2'),]$var_label = 'Phi[PSII]'
p_table$var_label <- factor(p_table$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))

graph_df <- df_summary[,c("date","season", "daytime", "species", "leaf_age","gsw","ETR","PhiPS2")] %>% 
  pivot_longer(
    cols = -c(date, season, daytime, species, leaf_age),
    names_to = "variable",
    values_to = "value"
  )
graph_df <- as.data.frame(graph_df)

graph_df$var_label <- NA
graph_df[which(graph_df$variable == 'gsw'),]$var_label = 'g[sw]'
graph_df[which(graph_df$variable == 'ETR'),]$var_label = 'ETR'
graph_df[which(graph_df$variable == 'PhiPS2'),]$var_label = 'Phi[PSII]'
graph_df$var_label <- factor(graph_df$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))


# compute per-facet summary (max/min) from the plotting data
y_bounds <- graph_df  %>%
  group_by(var = variable, var_label, season) %>%
  summarize(ymax = max(value, na.rm = TRUE),
            ymin = min(value, na.rm = TRUE),
            yrange = ymax - ymin,
            .groups = "drop")

# tuning parameters (fractions of facet yrange)
step_frac <- 0.15       # fraction of yrange used as vertical gap between stacked labels
base_frac <- 0.05       # fraction of yrange above ymax where the bottom annotation starts
min_step_frac <- 0.03   # minimum step = min_step_frac * median(yrange) across facets
min_step_abs <- 1e-6    # absolute fallback if needed

# compute a median-based minimum step (in data units)
median_yrange <- median(y_bounds$yrange[is.finite(y_bounds$yrange) & y_bounds$yrange > 0], na.rm = TRUE)
min_step_from_median <- ifelse(is.na(median_yrange), min_step_abs, pmax(min_step_frac * median_yrange, min_step_abs))

# build p_table2 with scaled positions
p_table2 <- p_table %>%
  mutate(var = as.character(var),
         var_label = as.character(var_label),
         season = as.character(season)) %>%
  left_join(y_bounds, by = c("var", "var_label", "season")) %>%
  group_by(var, var_label, season) %>%
  arrange(p.adj, .by_group = TRUE) %>%    # order within facet (change if you want a different order)
  mutate(rank = row_number() - 1,
         # compute step as a fraction of the facet's yrange, but enforce a minimum based on median yrange
         step = ifelse(is.na(yrange) | yrange <= 0,
                       min_step_from_median,
                       pmax(step_frac * yrange, min_step_from_median)),
         # compute base offset above ymax as a fraction of yrange
         base = ifelse(is.na(yrange) | yrange <= 0,
                       ymax + min_step_from_median,
                       ymax + base_frac * yrange),
         y.position = base + rank * step) %>%
  ungroup() %>%
  # keep only what stat_pvalue_manual needs
  select(group1, group2, p.adj, p.signif, y.position, season, var, var_label)

graph_df$var_label <- factor(graph_df$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))
p_table2$var_label <- factor(p_table2$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))
graph_df$season   <- factor(graph_df$season, levels = c("autumn", "winter", "spring", "summer"))
p_table2$season   <- factor(p_table2$season, levels = c("autumn", "winter", "spring", "summer"))

# Per-panel significance letters and omnibus p-value (Reviewer comment 3).
# Letters are derived from p_table2 (the Holm-adjusted glmmTMB/emmeans contrasts
# computed above); no model is refitted and no p-value is recomputed.
obs <- graph_df[is.finite(graph_df$value), ]
panels <- unique(obs[, c("var_label", "season")])
cld_tab <- NULL
sp_levels <- levels(factor(obs$species))
for (i in seq_len(nrow(panels))) {
  v  <- panels$var_label[i]
  se <- panels$season[i]
  d  <- obs[obs$var_label == v & obs$season == se, ]
  gs <- sp_levels[sp_levels %in% unique(as.character(d$species))]
  pr <- p_table2[p_table2$var_label == v & p_table2$season == se, ]
  cl <- cld_from_pairs(pr$group1, pr$group2, pr$p.adj, gs)
  yr <- max(d$value) - min(d$value)
  if (!is.finite(yr) || yr <= 0) yr <- abs(max(d$value)) * 0.1 + 1e-6
  cld_tab <- rbind(cld_tab, data.frame(
    var_label = v, season = se,
    species = factor(cl$group, levels = sp_levels),
    value = max(d$value) + 0.08 * yr,
    letter = cl$letter))
}

# Omnibus test of the species effect within each season, taken from the SAME
# fitted models the letters come from (res$fits), so panel p-value and letters
# are consistent. No model is refitted.
fmt_p <- function(p) {
  if (is.na(p)) "" else if (p < 0.001) "P < 0.001" else paste0("P = ", signif(p, 2))
}
var_lab_map <- c(gsw = "g[sw]", ETR = "ETR", PhiPS2 = "Phi[PSII]")
pval_tab <- NULL
for (v in names(res$fits)) {
  jt <- tryCatch(as.data.frame(emmeans::joint_tests(res$fits[[v]], by = "season")),
                 error = function(e) NULL)
  if (is.null(jt)) next
  jt <- jt[jt[["model term"]] == "species", ]
  pval_tab <- rbind(pval_tab, data.frame(
    var_label = var_lab_map[[v]],
    season = as.character(jt$season),
    label = vapply(jt$p.value, fmt_p, character(1))))
}
pval_tab$var_label <- factor(pval_tab$var_label, levels = c("g[sw]", "ETR", "Phi[PSII]"))
pval_tab$season <- factor(pval_tab$season, levels = c("autumn", "winter", "spring", "summer"))

plt = ggboxplot(graph_df, x = "species", y = "value")
plt = plt + geom_text(data = cld_tab, aes(x = species, y = value, label = letter),
                      family = "serif", size = 3.2, inherit.aes = FALSE)
plt = plt + geom_text(data = pval_tab, aes(x = -Inf, y = Inf, label = label),
                      hjust = -0.15, vjust = 1.4, family = "serif", size = 3, inherit.aes = FALSE)
plt = plt + scale_y_continuous(expand = expansion(mult = c(0.05, 0.20)))
plt = plt + facet_grid('var_label ~ season', scales="free_y", labeller = labeller(var_label = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt
ggsave(paste0(graphs_path, 'gsw_ETR_PhiPS2_season.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'gsw_ETR_PhiPS2_season.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

# 4) Numbers for text ####
# - - - - - - - - - - - -

graph_df$spec <- NA
graph_df[which(graph_df$species != 'Rep-S'),]$spec <- 'P. nitida'
graph_df[which(graph_df$species == 'Rep-S'),]$spec <- 'P. repens'

graph_df$season2 <- NA
graph_df[which(graph_df$season != 'summer'),]$season2 <- 'other'
graph_df[which(graph_df$season == 'summer'),]$season2 <- 'summer'

gsw_df <- graph_df[which(graph_df$variable == 'gsw'),] %>%
  group_by(species,season2) %>%
  summarize(across(where(is.numeric), list(
    median = ~median(.x, na.rm = TRUE),
    mean = ~mean(.x, na.rm = TRUE),
    sd = ~sd(.x, na.rm = TRUE)
  )), .groups = "drop")
gsw_df

gsw_df <- graph_df[which(graph_df$variable == 'gsw'),] %>%
            group_by(season,species) %>%
            summarize(across(where(is.numeric), list(
              median = ~median(.x, na.rm = TRUE),
              mean = ~mean(.x, na.rm = TRUE),
              sd = ~sd(.x, na.rm = TRUE)
            )), .groups = "drop")
gsw_df

etr_df <- graph_df[which(graph_df$variable == 'ETR'),] %>%
  group_by(season,spec) %>%
  summarize(across(where(is.numeric), list(
    median = ~median(.x, na.rm = TRUE),
    mean = ~mean(.x, na.rm = TRUE),
    sd = ~sd(.x, na.rm = TRUE)
  )), .groups = "drop")
etr_df

phi_df <- graph_df[which(graph_df$variable == 'PhiPS2'),] %>%
  group_by(season,spec) %>%
  summarize(across(where(is.numeric), list(
    median = ~median(.x, na.rm = TRUE),
    mean = ~mean(.x, na.rm = TRUE),
    sd = ~sd(.x, na.rm = TRUE)
  )), .groups = "drop")
phi_df

gsw_df <- graph_df[which(graph_df$variable == 'gsw'),] %>%
  group_by(species) %>%
  summarize(across(where(is.numeric), list(
    median = ~median(.x, na.rm = TRUE),
    mean = ~mean(.x, na.rm = TRUE),
    sd = ~sd(.x, na.rm = TRUE)
  )), .groups = "drop")
gsw_df

# 5a) Supplement: TL & VPD ####
# - - - - - - - - - - - - - - -

graph_df <- df[which(df$date != '2023-06-01'),
               c("timestamp","season", "daytime", "species", "leaf_age","Tleaf","VPDleaf")] %>% 
  pivot_longer(
    cols = -c(timestamp, season, daytime, species, leaf_age),
    names_to = "variable",
    values_to = "value"
  )
graph_df <- as.data.frame(graph_df)

plt = ggboxplot(graph_df[which(graph_df['variable'] == "VPDleaf"),], x = "species", y = "value")
my_comparisons <- list( c("Nit-A", "Nit-S"), c("Nit-S", "Rep-S"), c("Nit-A", "Rep-S"))
plt = plt + stat_compare_means(aes(x="species", y="value"), comparisons = my_comparisons,
                               label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_grid('season ~ daytime', scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt = plt + labs(y="VPD [kPa]")
#plt = plt + coord_cartesian(ylim = c(0, 0.3))
plt
ggsave(paste0(graphs_path, 'supplement/groups_daytime_VPD.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/groups_daytime_VPD.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

plt = ggboxplot(graph_df[which(graph_df['variable'] == "Tleaf"),], x = "species", y = "value")
my_comparisons <- list( c("Nit-A", "Nit-S"), c("Nit-S", "Rep-S"), c("Nit-A", "Rep-S"))
plt = plt + stat_compare_means(aes(x="species", y="value"), comparisons = my_comparisons,
                               label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_grid('season ~ daytime', scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt = plt + labs(y=expression(paste("T"["L"]," [°C]")))
#plt = plt + coord_cartesian(ylim = c(0, 0.3))
plt
ggsave(paste0(graphs_path, 'supplement/groups_daytime_TL.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/groups_daytime_TL.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

# 5b) Supplement: Leaf Age differences ####
# - - - - - - - - - - - - - - - - - - - - -

graph_df <- df[which(df$date != '2023-06-01'),
               c("timestamp","season", "daytime", "species", "leaf_age","gsw", "ETR", "PhiPS2")] %>% 
  pivot_longer(
    cols = -c(timestamp, season, daytime, species, leaf_age),
    names_to = "variable",
    values_to = "value"
  )
graph_df <- as.data.frame(graph_df)
graph_df[which(graph_df$variable == "ETR" & graph_df$value < -10),]$value <- NA

plt = ggboxplot(graph_df[which(graph_df['variable'] == "gsw"),], x = "leaf_age", y = "value")
my_comparisons <- list( c("Yng", "Mid"), c("Yng", "Old"), c("Mid", "Old"))
plt = plt + stat_compare_means(aes(x="leaf_age", y="value"), comparisons = my_comparisons,
                               label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_grid('season ~ species', scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt = plt + labs(y=expression(paste('Stomatal conductance ', 'g'['sw'],' [mol m'^'-2','s'^'-1',']')))
#plt = plt + coord_cartesian(ylim = c(0, 0.3))
plt
ggsave(paste0(graphs_path, 'supplement/groups_leafage_gsw.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/groups_leafage_gsw.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

plt = ggboxplot(graph_df[which(graph_df['variable'] == "ETR"),], x = "leaf_age", y = "value")
my_comparisons <- list( c("Yng", "Mid"), c("Yng", "Old"), c("Mid", "Old"))
plt = plt + stat_compare_means(aes(x="leaf_age", y="value"), comparisons = my_comparisons,
                               label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_grid('season ~ species', scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt = plt + labs(y=expression(paste('ETR',' [',mu,'mol m'^'-2','s'^'-1',']')))
#plt = plt + coord_cartesian(ylim = c(0, 0.3))
plt
ggsave(paste0(graphs_path, 'supplement/groups_leafage_etr.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/groups_leafage_etr.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

graph_df[which(graph_df$variable == "PhiPS2" & graph_df$value < -10),]$value <- NA
plt = ggboxplot(graph_df[which(graph_df$variable == "PhiPS2"),], x = "leaf_age", y = "value")
my_comparisons <- list( c("Yng", "Mid"), c("Yng", "Old"), c("Mid", "Old"))
plt = plt + stat_compare_means(aes(x="leaf_age", y="value"), comparisons = my_comparisons,
                               label="p.signif", vjust = 0.15)  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_grid('season ~ species', scales="free_y", labeller = labeller(variable = label_parsed))
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  strip.text = element_text(size = 12),
                  text=element_text(family="serif"))
plt = plt + labs(y=expression(paste(Phi['PSII'],' [unitless]')))
#plt = plt + coord_cartesian(ylim = c(0, 0.3))
plt
ggsave(paste0(graphs_path, 'supplement/groups_leafage_phips2.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'supplement/groups_leafage_phips2.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
