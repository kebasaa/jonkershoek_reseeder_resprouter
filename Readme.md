![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)


[![License: CC BY-NC-SA](https://img.shields.io/badge/License-CC%20BY--NC--SA-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

# Data & code for article on Fynbos reseeding and resprouting

The code and datasets in this repository are complementary to the draft manuscript titled "*Life-history trade-offs in the regeneration niche: Post-fire seeding vs. resprouting in Fynbos Proteaceae*" (Muller et al., draft manuscript). The repository contains datasets created for the project in the **data** subfolder and statistical analysis and figure-generation code in the **stat** subfolder. The following files are available:

1. **data/li600_dataset.csv:** Full LI-600F porometer/fluorometer dataset of leaf-level measurements for *Protea nitida* adults, *P. nitida* seedlings, and *P. repens* seedlings. Contains stomatal conductance, transpiration-related variables, chlorophyll fluorescence metrics, leaf and sampling metadata, and matched meteorological and Eddy Covariance-derived variables. Key variables include:
    - _timestamp_: Formatted as YYYY-mm-dd HH:MM:SS
    - _species_: Plant type, where Nit-A is *P. nitida* adult, Nit-S is *P. nitida* seedling, and Rep-S is *P. repens* seedling
    - _leaf_age_: Leaf cohort, defined as Yng, Mid, or Old
    - _season_: Sampling season, defined as autumn, winter, spring, or summer
    - _daytime_: Sampling period, defined as morning, noon, or afternoon
    - _gsw_: Stomatal conductance to water vapour, in mol m<sup>-2</sup> s<sup>-1</sup>
    - _E_apparent_: Apparent transpiration rate
    - _PhiPS2_: Operating efficiency of photosystem II
    - _ETR_: Electron transport rate
    - _VPDleaf_: Leaf vapour pressure deficit
    - _SWC_: Soil water content matched from the site meteorological data
    - _gpp_umol_m2_s1_: Gross primary productivity derived from Eddy Covariance processing
2. **data/li600_dataset_summarised.csv:** Summarised LI-600F dataset aggregated by timestamp, species, season, daytime, and leaf age. Contains median and standard deviation values used for statistical modelling and figure generation.
3. **data/li6400_dataset.csv:** LI-6400 gas-exchange dataset containing light-response curves, fluorescence light-response curves, and A-Ci measurements. Contains photosynthetic gas exchange variables, fluorescence variables, plant metadata, and matched environmental variables.
4. **data/lrc_fitted.csv:** Fitted light-response curve parameter table derived from Marshall-Biscoe model fits. Contains fitted parameters and derived values including _Asat_net_ and _Km_net_.
5. **data/coef_table_appendix.csv:** Appendix coefficient table linking stomatal conductance and electron transport rate relationships by species or plant type and leaf age.
6. **data/Leaf_morph.xlsx:** Leaf morphology measurements by species or plant type, leaf age, and specimen. Contains leaf length, width, and length/width ratio.
7. **data/Chlorophyll Content.xlsx:** Chlorophyll content measurements by barcode, including chlorophyll content and chlorophyll fluorescence ratio.
8. **stat/:** Statistical analysis and figure-generation scripts for the manuscript. Analyses use Python and R, with dependencies including:
    - [Pandas](https://pandas.pydata.org/)
    - [NumPy](https://numpy.org/)
    - [SciPy](https://scipy.org/)
    - [ggplot2](https://ggplot2.tidyverse.org/)
    - [ggpubr](https://rpkgs.datanovia.com/ggpubr/)
    - [glmmTMB](https://glmmtmb.github.io/glmmTMB/)
    - [emmeans](https://cran.r-project.org/web/packages/emmeans/index.html)
    - [mgcv](https://cran.r-project.org/web/packages/mgcv/index.html)
    - [photosynthesis](https://cran.r-project.org/web/packages/photosynthesis/index.html)

Raw Eddy Covariance data used for auxiliary meteorological context are not fully redistributed in this repository. These data are available on request from SAEON Fynbos ([https://fynbos.saeon.ac.za/](https://fynbos.saeon.ac.za/)).

## How to Cite

Muller, J. D., Ramsay, E., Carkeek, R., & Midgley, G. F. (draft manuscript). *Life-history trade-offs in the regeneration niche: Post-fire seeding vs. resprouting in Fynbos Proteaceae*.

## License

This repository is distributed under the Creative Commons Attribution-NonCommercial-ShareAlike license (CC BY-NC-SA 4.0).
