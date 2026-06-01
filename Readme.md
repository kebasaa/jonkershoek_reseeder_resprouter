![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)
![Pandas](https://img.shields.io/badge/pandas-%23150458.svg?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/numpy-%23013243.svg?style=for-the-badge&logo=numpy&logoColor=white)


[![License: CC BY-NC-SA](https://img.shields.io/badge/License-CC%20BY--NC--SA-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

# Data & code for article on Fynbos reseeding and resprouting

The code and datasets in this repository are complementary to the draft manuscript titled "*Life-history trade-offs in the regeneration niche: Post-fire seeding vs. resprouting in Fynbos Proteaceae*" (Muller et al., draft manuscript). The repository contains datasets created for the project in the **data** subfolder and statistical analysis and figure-generation code in the **stat** subfolder.

This study investigates how post-fire reseeding and resprouting strategies differ in their leaf-level physiology in a fire-prone, summer-drought Fynbos ecosystem. Using measurements from *Protea repens* seedlings, *Protea nitida* seedlings, and *P. nitida* adults at the Jonkershoek Fynbos research site, the project links stomatal conductance, photosynthetic capacity, chlorophyll fluorescence, leaf traits, and meteorological/Eddy Covariance context to test how reseeders and resprouters balance rapid carbon gain against drought resilience during post-fire recovery.

Leaf-level screening measurements in files beginning with **li600** were made with a [LI-COR LI-600/LI-600F Porometer/Fluorometer](https://www.licor.com/products/LI-600), a compact handheld instrument for rapid ambient leaf-level measurements of stomatal conductance and chlorophyll a fluorescence, especially for broadleaf measurements. Gas-exchange response-curve measurements in files beginning with **li6400** were made with a LI-COR LI-6400 Portable Photosynthesis System, a portable photosynthesis and gas-exchange system supporting light-response curves, CO<sub>2</sub>-response curves, chamber environmental control, and optional leaf chamber fluorescence workflows ([manuals](https://cloud.licor.com/env/support/LI-6400/manuals.html); [LI-COR history](https://www.licor.com/corp/history)).

The following files are available:

1. **data/li600_dataset.csv:** Full LI-COR LI-600/LI-600F porometer/fluorometer dataset of leaf-level measurements for *Protea nitida* adults, *P. nitida* seedlings, and *P. repens* seedlings. Contains stomatal conductance, transpiration-related variables, chlorophyll fluorescence metrics, leaf and sampling metadata, and matched meteorological and Eddy Covariance-derived variables. [Column metadata](metadata/li600_dataset_metadata.md)
2. **data/li600_dataset_summarised.csv:** Summarised LI-COR LI-600/LI-600F dataset aggregated by timestamp, species, season, daytime, and leaf age. [Column metadata](metadata/li600_dataset_summarised_metadata.md)
3. **data/li6400_dataset.csv:** LI-COR LI-6400 portable photosynthesis system dataset containing light-response curves, fluorescence light-response curves, and A-Ci measurements. Contains photosynthetic gas exchange variables, fluorescence variables, plant metadata, and matched environmental variables. [Column metadata](metadata/li6400_dataset_metadata.md)
4. **data/lrc_fitted.csv:** Fitted LI-COR LI-6400 light-response curve parameter table derived from Marshall-Biscoe model fits. [Column metadata](metadata/lrc_fitted_metadata.md)
5. **data/coef_table_appendix.csv:** Appendix coefficient table linking stomatal conductance and electron transport rate relationships by species or plant type and leaf age. [Column metadata](metadata/coef_table_appendix_metadata.md)
6. **data/Leaf_morph.xlsx:** Leaf morphology measurements by species or plant type, leaf age, and specimen. [Column metadata](metadata/Leaf_morph_metadata.md)
7. **data/Chlorophyll Content.xlsx:** Chlorophyll content measurements by barcode. [Column metadata](metadata/Chlorophyll Content_metadata.md)
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

Matched Eddy Covariance and meteorological variables are included in the distributed merged datasets where needed for the analyses. Eddy Covariance data are not fully redistributed in this repository as they are the property of the South African Environmental Observation Network (SAEON) and are available on request from SAEON ([https://fynbos.saeon.ac.za/](https://fynbos.saeon.ac.za/)).

## How to Cite

Muller, J. D., Ramsay, E., Carkeek, R., & Midgley, G. F. (draft manuscript). *Life-history trade-offs in the regeneration niche: Post-fire seeding vs. resprouting in Fynbos Proteaceae*.

## License

This repository is distributed under the Creative Commons Attribution-NonCommercial-ShareAlike license (CC BY-NC-SA 4.0).

In practical terms, you may copy, redistribute, reuse, and adapt the datasets and code in this repository for non-commercial research, teaching, and other non-commercial purposes, provided that you give appropriate credit to the authors, cite the manuscript or repository, indicate whether changes were made, and share any adapted material under the same CC BY-NC-SA 4.0 terms. You may not use the material for commercial purposes, apply legal or technical restrictions that prevent others from exercising the same license rights, or imply that the authors endorse your reuse. Eddy Covariance data remain the ownership of SAEON, are governed by SAEON's own licensing and access terms, and are not licensed under this repository's CC BY-NC-SA 4.0 license.
