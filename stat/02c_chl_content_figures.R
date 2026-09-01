# Header ####

library(readxl)
library(ggplot2)
library(ggpubr)
library(dplyr)

# Paths & constants ####
# - - - - - - - - - - - -

project_path = './'

# Inputs
data_path = paste0(project_path, '../data/')

# Outputs
graphs_path = paste0(project_path, '../graphs/supplement/')
output_path = paste0(project_path, '../data/')

# Colour-blind palette. Colours are HTML codes
# To change codes, use: https://www.w3schools.com/colors/colors_picker.asp
cbPalette <- c("#939393", "#E69F00", "#0072B2", "#CC00CC", "#009E73", "#D55E00", "#CC79A7", "#FF3300", "#F0E442", "#56B4E9")

# 0) Functions ####
# - - - - - - - - -

create_leaf_age <- function(label){
  leafage <- gsub("Nitida-Adlt|Nitida-Seed|Repens-Seed|-|1|2|3|4|5", "", label)
  leafage <- factor(leafage, levels = c('Yng','Mid','Old'))
  return(leafage)
}

create_specimen <- function(label){
  specimen = as.numeric(substr(label, nchar(label),nchar(label)))
  return(specimen)
}

create_species <- function(label){
  # Assign species
  species =  rep(NA, length(label))
  species[which(grepl('Nitida-Adlt', label))] <- 'Nit-A'
  species[which(grepl('Nitida-Seed', label))] <- 'Nit-S'
  species[which(grepl('Repens-Seed',   label))] <- 'Rep-S'
  return(species)
}

# 1) Load data ####
# - - - - - - - - -

df <- read_excel(paste0(data_path, 'Chlorophyll Content.xlsx'))
# Rename columns
names(df)[names(df) == 'Barcode'] <- 'barcode'
names(df)[names(df) == 'Chl[mg/m^2]'] <- 'chl_mg.m2'

# Create category variables
df$leaf_age = create_leaf_age(df$barcode)
df$specimen = create_specimen(df$barcode)
df$species  = create_species(df$barcode)


# Create labels for sample size
n_labels = as.data.frame(table(df$leaf_age, df$species))
#n_labels$Freq = paste0('n=', n_labels$Freq)
names(n_labels)[names(n_labels) == 'Var1'] <- 'leaf_age'
names(n_labels)[names(n_labels) == 'Var2'] <- 'species'
print(n_labels) # Note: There are 5 of each

plt = ggplot(df)
plt = plt + geom_boxplot(aes(x=species, y=chl_mg.m2, fill=leaf_age), colour='black', outlier.size = 0.5, size=0.3)
plt = plt + labs(x='Group',
                 y=expression(paste('Chlorophyll content  [mg m'^'-2',']')), fill='Leaf Age' )
plt = plt + scale_colour_manual(values=cbPalette) + scale_fill_manual(values=cbPalette)
plt = plt + theme_bw()
plt = plt + theme(text=element_text(family="serif"),
                  #legend.justification=c(0.5, 0.5), 
                  #legend.position=c(0.5, 0.5),
                  axis.text.x = element_text(angle = -45, vjust = 1, hjust=0))
#plt = plt + geom_text(data=n_labels, aes(x=factor(species), y=-0.005, label=Freq), position = position_dodge2(width = .75), size=3, family="serif")
#plt = plt + facet_grid('season ~ leaf_age')
#plt = plt + coord_cartesian(ylim = c(-0.005,0.2)) # Zoom in
plt

# 2) Figure for chl. content ####
# - - - - - - - - - - - - - - - -

# Create comparisons plot with Nitida Seedling #leafage

plt = ggboxplot(df, x = "leaf_age", y = "chl_mg.m2")
plt = plt + labs(x='Leaf age',
                 y=expression(paste('Chlorophyll content  [mg m'^'-2',']')), fill='leaf_age' )
my_comparisons <- list( c("Yng", "Mid"), c("Mid", "Old"), c("Yng", "Old"))
# Add p-values comparing groups
plt = plt + stat_compare_means(aes(x="leaf_age", y="chl_mg.m2"), comparisons = my_comparisons, label="p.signif")  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_wrap('~ species')
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  text=element_text(family="serif"))
p1 <- plt


plt = ggboxplot(df, x = "species", y = "chl_mg.m2")
plt = plt + labs(x='Group',
                 y=expression(paste('Chlorophyll content  [mg m'^'-2',']')), fill='species' )
my_comparisons <- list( c("Nit-S", "Rep-S"), c("Nit-S", "Nit-A"), c("Rep-S", "Nit-A"))
# Add p-values comparing groups
plt = plt + stat_compare_means(aes(x="species", y="chl_mg.m2"), comparisons = my_comparisons, label="p.signif")  # Add pairwise comparisons p-value
#plt = plt + stat_compare_means(label.y = 0.4)
plt = plt + facet_wrap('~ leaf_age')
plt = plt + theme(axis.title.x = element_blank(), #axis.title.y = element_blank(),
                  axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
                  text=element_text(family="serif"))
p2 <- plt

combined <- ggarrange(p1, p2, ncol = 1, labels = c("A", "B"))
print(combined)
ggsave(paste0(graphs_path, 'chl_content.jpg'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)
ggsave(paste0(graphs_path, 'chl_content.pdf'), width=20, height=20, units = "cm", scale=1.25, dpi = 600)

# 3) Stats on differences  ####
# - - - - - - - - - - - - - - -
summary_stats <- df %>%
  group_by(species,leaf_age) %>%
  summarise(
    mean_value = mean(chl_mg.m2, na.rm = TRUE),
    stddev_value = sd(chl_mg.m2, na.rm = TRUE)
  )

print(summary_stats)


