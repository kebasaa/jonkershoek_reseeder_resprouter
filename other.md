# Realistic additional research questions enabled by this dataset

This document lists research questions that could be addressed with the available datasets beyond the main manuscript analysis. The emphasis is on questions that are realistic given the sampling depth, temporal replication, and known limitations of the data.

## Dataset depth and constraints

- **LI-600 raw dataset:** 7,426 observations and 243 columns, measured on 11 sampling dates from 2023-05-18 to 2024-01-25.
- **LI-600 sampling design:** 3 plant types (`Nit-A`, `Nit-S`, `Rep-S`) x 3 leaf-age classes (`Yng`, `Mid`, `Old`) x 3 daytime periods (`morning`, `noon`, `afternoon`), with 45 barcoded leaves in total, approximately 5 leaves per plant type x leaf-age combination.
- **LI-600 summarised dataset:** 297 rows, exactly 3 plant types x 3 leaf ages x 3 daytime periods x 11 dates.
- **Season coverage:** autumn has 1 sampling date, winter has 6, spring has 2, and summer has 2. Winter is therefore much better represented than the other seasons.
- **LI-6400 dataset:** 799 observations and 209 columns, measured on 9 dates from 2023-06-01 to 2024-01-25.
- **LI-6400 measurement depth:** 397 ACi observations, 365 fluorescence light-response curve observations, and 37 light-response curve observations. Coverage is uneven among plant types and measurement types.
- **Fitted light-response curves:** 36 fitted curves, representing 3 plant types x 3 leaf ages x 4 dates.
- **Leaf morphology and chlorophyll:** 45 rows each, with 5 samples per plant type x leaf-age combination, measured once.
- **Trait-linking caveat:** leaf morphology and chlorophyll barcode lists overlap fully with each other, but only 30 of the 45 trait barcodes overlap with raw LI-600 barcodes as currently named.

The strongest reuse potential is therefore in repeated LI-600 leaf physiology across plant type, leaf age, daytime, and date. Questions that depend on morphology, chlorophyll, LI-6400 response curves, or ecosystem-scale flux attribution are possible, but should be framed more cautiously.

## Well-supported questions

1. **How do stomatal conductance, ETR, PhiPS2, and apparent transpiration vary by plant type, leaf age, daytime, and season?**  
   This is well supported by the LI-600 raw and summarised datasets: 7,426 raw observations and a complete 297-row summary table across all plant type x leaf age x daytime x date combinations. The main limitation is uneven seasonal replication, especially only 1 autumn date and 2 summer dates.

2. **Does midday depression differ among plant types and seasons?**  
   This is well supported because every LI-600 sampling date includes morning, noon, and afternoon measurements for all plant types and leaf-age classes. The best analysis unit is likely the summarised dataset, with 27 rows per date. Interpretation should account for repeated measures of the same leaves and the stronger winter replication.

3. **Do reseeder seedlings show stronger sensitivity to VPD, SWC, PAR, or CO2 than resprouter seedlings and adults?**  
   This is well supported for LI-600 stomatal conductance and fluorescence responses because key environmental variables are available for all 7,426 LI-600 observations. It is strongest as a repeated-measures or mixed-effects/GAM-style analysis. It should not be interpreted as a fully independent ecosystem manipulation because environmental variables covary seasonally.

4. **Do young, mid-aged, and old leaves differ consistently across the 11-date LI-600 series?**  
   This is well supported by the balanced 3 leaf-age design and approximately 5 leaves per plant type x leaf-age group. It can test whether leaf age modifies conductance, fluorescence, apparent transpiration, and environmental sensitivity. The main limitation is that leaf age is observed within a single post-fire year rather than across multiple years.

5. **Are seasonal physiological shifts visible before or after changes in matched EC-derived GPP or NEE?**  
   This is plausible using the LI-600 merged meteorological/Eddy Covariance context, with GPP available for most summarised rows and NEE available for 288 of 297 summarised rows. It is best framed as timing and association, not causal attribution, because the EC footprint represents ecosystem-scale fluxes and not only the sampled plants.

6. **Which reduced set of LI-600 variables captures the main differences among plant types and seasons?**  
   This is well supported as an ordination, variable-selection, or redundancy analysis using the repeated LI-600 measurements. It could help identify a smaller future field protocol. The limitation is that many instrument diagnostic variables are not biologically independent.

## Exploratory but possible questions

1. **Are leaf morphology and chlorophyll associated with repeated physiological performance?**  
   This is possible but exploratory because morphology and chlorophyll each have 45 rows and were measured once. The trait datasets are balanced across plant type and leaf age, but only 30 trait barcodes overlap with raw LI-600 barcodes as currently named. Analyses should focus on broad trait summaries or linked subsets, not fine-scale causal inference.

2. **Do plant types differ in light-response plasticity across spring and summer?**  
   This is possible using the 36 fitted light-response curves, representing one fitted curve per plant type x leaf age x date group across 4 dates. It can support descriptive comparisons of `Asat_net`, `Km_net`, and fitted parameters. It is not deep enough for highly parameterised models with many interactions.

3. **Can LI-600 measurements be compared with LI-6400 measurements?**  
   This is possible as a cautious method comparison, especially for broadly related variables such as conductance, fluorescence, ETR, VPD, and PAR. The limitation is that LI-6400 coverage is uneven: ACi measurements are present for `Nit-S` and `Rep-S` but not `Nit-A`, while FLRC measurements cover all three plant types on 4 dates.

4. **Are there environmental thresholds where stomatal conductance declines sharply?**  
   This is possible with the repeated LI-600 data because VPD, SWC, PAR, and CO2 context are available across strong seasonal gradients. However, thresholds should be treated as exploratory because autumn and summer have few dates and environmental drivers covary.

5. **Can multivariate physiology classify plant type or season?**  
   This is possible as an exploratory classification or ordination exercise using LI-600 variables. It should not be presented as a robust predictive machine-learning product because the true independent replication is limited to 11 dates and 45 leaves, with many repeated observations.

6. **Do leaf-level physiological patterns help interpret seasonal ecosystem flux dynamics?**  
   This is possible as an associative analysis using matched EC-derived GPP, NEE, Reco, and WUE variables. It should be framed as contextual interpretation, not direct scaling from leaf to ecosystem, because the EC signal integrates the broader vegetation and footprint.

## Not well supported without additional data

1. **Long-term post-fire succession or vegetation maturation.**  
   The dataset covers May 2023 to January 2024, roughly one measurement campaign within the post-fire recovery period. Testing multi-year successional change would require additional years.

2. **Community-level dominance or shifts in vegetation composition.**  
   The dataset focuses on leaf-level physiology in selected *Protea* plant types. It does not include community abundance, cover, recruitment, or mortality data.

3. **Strong causal attribution of ecosystem-scale carbon fluxes to reseeders versus resprouters.**  
   EC-derived variables are useful context, but the EC footprint is broader than the sampled leaves and includes mixed vegetation. Causal ecosystem attribution would need additional footprint composition or scaling data.

4. **Robust machine-learning prediction as a primary research output.**  
   The raw row count is large, but many rows are repeated measurements of the same 45 leaves across 11 dates. A model could easily overstate predictive skill unless validation is grouped by date and leaf barcode.

5. **General parameterisation of global plant functional types.**  
   The data are valuable for hypothesis generation and local model parameterisation, but broader parameterisation would require more species, sites, years, and fire-history contexts.

6. **Strong inference from ACi measurements across all plant types.**  
   ACi data are available for `Nit-S` and `Rep-S`, but not `Nit-A`. Adult resprouter comparisons using ACi therefore require additional measurements.

## Most promising follow-up outputs

1. A compact repeated-measures analysis of LI-600 physiology by plant type, leaf age, daytime, and season.
2. A midday depression analysis using the complete morning-noon-afternoon LI-600 structure.
3. A trait summary comparing morphology and chlorophyll by plant type and leaf age, with cautious links to physiology.
4. A descriptive light-response plasticity note using the 36 fitted LRC curves.
5. A methodological comparison of LI-600 and LI-6400 measurements, clearly limited to overlapping variables and dates.
