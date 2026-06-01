# Metadata for li6400_dataset.csv

LI-COR LI-6400 portable photosynthesis system dataset containing light-response curves, fluorescence light-response curves, and A-Ci measurements. Contains photosynthetic gas exchange variables, fluorescence variables, plant metadata, and matched environmental variables.

Measurements were made with a LI-COR LI-6400 Portable Photosynthesis System for gas-exchange response-curve and fluorescence workflows.

LI-6400 instrument units follow the official LI-COR LI-6400/LI-6400XT operating instructions and variable tables: https://cloud.licor.com/env/support/LI-6400/manuals.html

## Columns

Physical units, formats, or value types are provided where they can be assigned from the instrument documentation, Eddy Covariance conventions, column names, or project processing context.

| Column | Unit | Description |
| --- | --- | --- |
| `timestamp` | date-time format | Date and time of the matched observation, formatted as YYYY-mm-dd HH:MM:SS. |
| `measurement_type` | category | LI-6400 measurement programme type, such as ACi, FLRC, or LRC. |
| `species` | category | Plant type: Nit-A is Protea nitida adult, Nit-S is Protea nitida seedling, and Rep-S is Protea repens seedling. |
| `specimen` | identifier | Individual plant or specimen identifier. |
| `leaf_age` | category | Leaf cohort, defined as Yng, Mid, or Old. |
| `season` | category | Sampling season, defined as autumn, winter, spring, or summer. |
| `daytime` | category | Sampling period, defined as morning, noon, or afternoon. |
| `filename` | identifier | Source LI-6400 file or fitted light-response curve identifier. |
| `Obs` | record number | LI-6400 observation number within a measurement file or sequence. |
| `FTime` | s | LI-6400 elapsed file time or observation time. |
| `EBal` | energy-balance code | LI-6400 energy-balance flag or value. |
| `Photo` | umol CO2 m^-2 s^-1 | Net photosynthetic CO2 assimilation rate. |
| `Cond` | mol H2O m^-2 s^-1 | Stomatal conductance reported by the LI-6400. |
| `Ci` | umol CO2 mol^-1 | Intercellular CO2 concentration. |
| `FCnt` | count | Fluorescence count or protocol counter. |
| `DCnt` | count | Dark-adaptation or dark-count counter. |
| `Fo` | relative fluorescence yield | Minimum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fm` | relative fluorescence yield | Maximum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fo_1` | relative fluorescence yield | Alternate or repeated minimum fluorescence value. |
| `Fm_1` | relative fluorescence yield | Alternate or repeated maximum fluorescence value. |
| `Fs` | relative fluorescence yield | Steady-state fluorescence. |
| `Fv_Fm` | dimensionless ratio | Maximum quantum efficiency of photosystem II. |
| `Fv_Fm_1` | dimensionless ratio | Alternate or repeated maximum quantum efficiency of photosystem II. |
| `PhiPS2` | dimensionless quantum efficiency | Operating efficiency of photosystem II. |
| `Adark` | umol CO2 m^-2 s^-1 | Dark respiration or dark assimilation value. |
| `RedAbs` | dimensionless fraction | Red-light absorptance setting. |
| `BlueAbs` | dimensionless fraction | Blue-light absorptance setting. |
| `Blue` | % | Blue light fraction or intensity setting. |
| `LeafAbs` | dimensionless fraction | Leaf absorptance setting. |
| `PhiCO2` | dimensionless quantum yield | Quantum yield of CO2 assimilation. |
| `qP` | dimensionless coefficient | Photochemical quenching coefficient. |
| `qN` | dimensionless coefficient | Non-photochemical quenching coefficient. |
| `NPQ` | dimensionless coefficient | Non-photochemical quenching. |
| `ParIn_Fs` | umol photons m^-2 s^-1 | Incident PAR during steady-state fluorescence. |
| `PS2_1` | dimensionless ratio | Photosystem II allocation or fluorescence ratio from LI-6400 output. |
| `ETR` | umol electrons m^-2 s^-1 | Electron transport rate. |
| `Trmmol` | mmol H2O m^-2 s^-1 | Transpiration rate in mmol m^-2 s^-1. |
| `VpdL` | kPa | Leaf-to-air vapour pressure deficit. |
| `CTleaf` | deg C | Computed leaf temperature. |
| `Area` | cm^2 | Leaf area enclosed in the LI-6400 chamber. |
| `BLC_1` | mol m^-2 s^-1 | Boundary-layer conductance setting or value. |
| `StmRat` | dimensionless ratio | Stomatal ratio setting. |
| `BLCond` | mol m^-2 s^-1 | Boundary-layer conductance. |
| `Tair` | deg C | Air temperature in the chamber. |
| `Tleaf` | deg C | Leaf temperature. |
| `TBlk` | deg C | Block temperature. |
| `CO2R` | umol CO2 mol^-1 | Reference CO2 concentration. |
| `CO2S` | umol CO2 mol^-1 | Sample CO2 concentration. |
| `H2OR` | mmol H2O mol^-1 | Reference H2O concentration. |
| `H2OS` | mmol H2O mol^-1 | Sample H2O concentration. |
| `RH_R` | % | Reference relative humidity. |
| `RH_S` | % | Sample relative humidity. |
| `Flow` | umol s^-1 | LI-6400 flow rate. |
| `PARi` | umol photons m^-2 s^-1 | Incident photosynthetically active radiation. |
| `PARo` | umol photons m^-2 s^-1 | Outgoing or external photosynthetically active radiation. |
| `Press` | kPa | Atmospheric pressure. |
| `CsMch` | umol CO2 mol^-1 | Matched sample CO2 value. |
| `HsMch` | mmol H2O mol^-1 | Matched sample H2O value. |
| `CsMchSD` | umol CO2 mol^-1 | Standard deviation of matched sample CO2 value. |
| `HsMchSD` | mmol H2O mol^-1 | Standard deviation of matched sample H2O value. |
| `CrMchSD` | umol CO2 mol^-1 | Standard deviation of matched reference CO2 value. |
| `HrMchSD` | mmol H2O mol^-1 | Standard deviation of matched reference H2O value. |
| `StableF` | stability decimal value | Fluorescence stability flag or value. |
| `BLCslope` | calibration slope | Boundary-layer conductance calibration slope. |
| `BLCoffst` | mol m^-2 s^-1 | Boundary-layer conductance calibration offset. |
| `f_parin` | dimensionless correction factor | Incident PAR correction factor. |
| `f_parout` | dimensionless correction factor | Outgoing PAR correction factor. |
| `alphaK` | dimensionless coefficient | Leaf absorptance or calibration coefficient used by LI-6400 calculations. |
| `Status` | instrument status code | LI-6400 status code. |
| `Tau` | kg m^-1 s^-2 | Momentum flux from Eddy Covariance processing. |
| `qc_Tau` | quality flag | Quality-control flag for momentum flux. |
| `rand_err_Tau` | kg m^-1 s^-2 | Random error estimate for momentum flux. |
| `H` | W m^-2 | Sensible heat flux. |
| `qc_H` | quality flag | Quality-control flag for sensible heat flux. |
| `rand_err_H` | W m^-2 | Random error estimate for sensible heat flux. |
| `LE` | W m^-2 | Latent heat flux. |
| `qc_LE` | quality flag | Quality-control flag for latent heat flux. |
| `rand_err_LE` | W m^-2 | Random error estimate for latent heat flux. |
| `co2_flux` | umol CO2 m^-2 s^-1 | CO2 flux from Eddy Covariance processing. |
| `qc_co2_flux` | quality flag | Quality-control flag for CO2 flux. |
| `rand_err_co2_flux` | umol CO2 m^-2 s^-1 | Random error estimate for CO2 flux. |
| `h2o_flux` | mmol H2O m^-2 s^-1 | H2O flux from Eddy Covariance processing. |
| `qc_h2o_flux` | quality flag | Quality-control flag for H2O flux. |
| `rand_err_h2o_flux` | mmol H2O m^-2 s^-1 | Random error estimate for H2O flux. |
| `H_strg` | W m^-2 | Storage correction for sensible heat flux. |
| `LE_strg` | W m^-2 | Storage correction for latent heat flux. |
| `co2_strg` | umol CO2 m^-2 s^-1 | Storage correction for CO2 flux. |
| `h2o_strg` | mmol H2O m^-2 s^-1 | Storage correction for H2O flux. |
| `co2_v-adv` | umol CO2 m^-2 s^-1 | Vertical advection term for CO2. |
| `h2o_v-adv` | mmol H2O m^-2 s^-1 | Vertical advection term for H2O. |
| `co2_molar_density` | mmol CO2 m^-3 | CO2 molar density. |
| `co2_mole_fraction` | umol CO2 mol^-1 | CO2 mole fraction. |
| `co2_mixing_ratio` | umol CO2 mol^-1 | CO2 mixing ratio. |
| `co2_time_lag` | s | Estimated CO2 time lag. |
| `co2_def_timelag` | default-lag flag | Default CO2 time-lag flag or value. |
| `h2o_molar_density` | mmol H2O m^-3 | H2O molar density. |
| `h2o_mole_fraction` | mmol H2O mol^-1 | H2O mole fraction. |
| `h2o_mixing_ratio` | mmol H2O mol^-1 | H2O mixing ratio. |
| `h2o_time_lag` | s | Estimated H2O time lag. |
| `h2o_def_timelag` | default-lag flag | Default H2O time-lag flag or value. |
| `sonic_temperature` | K | Sonic temperature. |
| `air_temperature` | K | Air temperature. |
| `air_pressure` | Pa | Air pressure. |
| `air_density` | kg m^-3 | Air density. |
| `air_heat_capacity` | J kg^-1 K^-1 | Air heat capacity. |
| `air_molar_volume` | m^3 mol^-1 | Air molar volume. |
| `ET` | mm h^-1 | Evapotranspiration. |
| `water_vapor_density` | kg m^-3 | Water vapour density. |
| `e` | Pa | Actual vapour pressure. |
| `es` | Pa | Saturation vapour pressure. |
| `specific_humidity` | kg kg^-1 | Specific humidity. |
| `RH` | % | Relative humidity. |
| `VPD` | Pa | Atmospheric vapour pressure deficit. |
| `Tdew` | K | Dew-point temperature. |
| `u_unrot` | m s^-1 | Unrotated longitudinal wind component. |
| `v_unrot` | m s^-1 | Unrotated lateral wind component. |
| `w_unrot` | m s^-1 | Unrotated vertical wind component. |
| `u_rot` | m s^-1 | Rotated longitudinal wind component. |
| `v_rot` | m s^-1 | Rotated lateral wind component. |
| `w_rot` | m s^-1 | Rotated vertical wind component. |
| `wind_speed` | m s^-1 | Mean wind speed. |
| `max_wind_speed` | m s^-1 | Maximum wind speed. |
| `wind_dir` | degrees | Wind direction. |
| `yaw` | degrees | Sonic-anemometer yaw angle. |
| `pitch` | degrees | Sonic-anemometer pitch angle. |
| `roll` | degrees | Sonic-anemometer roll angle. |
| `u*` | m s^-1 | Friction velocity. |
| `TKE` | m^2 s^-2 | Turbulent kinetic energy. |
| `L` | m | Obukhov length. |
| `(z-d)/L` | dimensionless stability parameter | Atmospheric stability parameter. |
| `bowen_ratio` | dimensionless ratio | Bowen ratio. |
| `T*` | K | Temperature scale. |
| `model` | model identifier | Footprint model identifier. |
| `x_peak` | m | Footprint peak distance. |
| `x_offset` | m | Footprint offset distance. |
| `x_10%` | m | Distance enclosing 10 percent of the flux footprint. |
| `x_30%` | m | Distance enclosing 30 percent of the flux footprint. |
| `x_50%` | m | Distance enclosing 50 percent of the flux footprint. |
| `x_70%` | m | Distance enclosing 70 percent of the flux footprint. |
| `x_90%` | m | Distance enclosing 90 percent of the flux footprint. |
| `un_Tau` | kg m^-1 s^-2 | Uncorrected momentum flux. |
| `Tau_scf` | dimensionless correction factor | Spectral correction factor for momentum flux. |
| `un_H` | W m^-2 | Uncorrected sensible heat flux. |
| `H_scf` | dimensionless correction factor | Spectral correction factor for sensible heat flux. |
| `un_LE` | W m^-2 | Uncorrected latent heat flux. |
| `LE_scf` | dimensionless correction factor | Spectral correction factor for latent heat flux. |
| `un_co2_flux` | umol CO2 m^-2 s^-1 | Uncorrected CO2 flux. |
| `co2_scf` | dimensionless correction factor | Spectral correction factor for CO2 flux. |
| `un_h2o_flux` | mmol H2O m^-2 s^-1 | Uncorrected H2O flux. |
| `h2o_scf` | dimensionless correction factor | Spectral correction factor for H2O flux. |
| `spikes_hf` | quality flag | High-frequency spike quality flag. |
| `amplitude_resolution_hf` | quality flag | High-frequency amplitude-resolution quality flag. |
| `drop_out_hf` | quality flag | High-frequency dropout quality flag. |
| `absolute_limits_hf` | quality flag | High-frequency absolute-limits quality flag. |
| `skewness_kurtosis_hf` | quality flag | High-frequency skewness/kurtosis quality flag. |
| `skewness_kurtosis_sf` | quality flag | Slow-frequency skewness/kurtosis quality flag. |
| `discontinuities_hf` | quality flag | High-frequency discontinuity quality flag. |
| `discontinuities_sf` | quality flag | Slow-frequency discontinuity quality flag. |
| `timelag_hf` | quality flag | High-frequency time-lag quality flag. |
| `timelag_sf` | quality flag | Slow-frequency time-lag quality flag. |
| `attack_angle_hf` | quality flag | High-frequency attack-angle quality flag. |
| `non_steady_wind_hf` | quality flag | High-frequency non-steady-wind quality flag. |
| `u_spikes` | count | Spike count or flag for u wind component. |
| `v_spikes` | count | Spike count or flag for v wind component. |
| `w_spikes` | count | Spike count or flag for w wind component. |
| `ts_spikes` | count | Spike count or flag for sonic temperature. |
| `co2_spikes` | count | Spike count or flag for CO2. |
| `h2o_spikes` | count | Spike count or flag for H2O. |
| `u_var` | m^2 s^-2 | Variance of u wind component. |
| `v_var` | m^2 s^-2 | Variance of v wind component. |
| `w_var` | m^2 s^-2 | Variance of w wind component. |
| `ts_var` | K^2 | Variance of sonic temperature. |
| `co2_var` | (umol mol^-1)^2 | Variance of CO2. |
| `h2o_var` | (mmol mol^-1)^2 | Variance of H2O. |
| `w/ts_cov` | m K s^-1 | Covariance of vertical wind and sonic temperature. |
| `w/co2_cov` | m umol mol^-1 s^-1 | Covariance of vertical wind and CO2. |
| `w/h2o_cov` | m mmol mol^-1 s^-1 | Covariance of vertical wind and H2O. |
| `fast_t_mean` | K | Mean fast-response temperature. |
| `DRM_V_BATTERY_1_1_1` | V | Data-logger battery voltage. |
| `TCNR_C_1_1_1` | deg C | Net-radiometer temperature or diagnostic channel. |
| `SWIN_1_1_1` | W m^-2 | Incoming shortwave radiation. |
| `SWOUT_1_1_1` | W m^-2 | Outgoing shortwave radiation. |
| `NDVI_1_1_1` | dimensionless vegetation index | Normalized Difference Vegetation Index sensor channel. |
| `PRI_1_1_1` | dimensionless vegetation index | Photochemical Reflectance Index sensor channel 1. |
| `PRI_1_1_2` | dimensionless vegetation index | Photochemical Reflectance Index sensor channel 2. |
| `NETRAD_1_1_1` | W m^-2 | Net radiation. |
| `TA_1_2_1` | K | Air temperature sensor channel 2. |
| `TA_1_1_1` | K | Air temperature sensor channel 1. |
| `PA_1_1_1` | Pa | Atmospheric pressure sensor channel. |
| `RH_1_1_1` | % | Relative humidity sensor channel. |
| `TS_1_1_1` | K | Soil temperature sensor channel 1. |
| `TS_1_1_2` | K | Soil temperature sensor channel 2. |
| `G_1_1_1` | W m^-2 | Soil heat flux sensor channel. |
| `SWC_1_1_1` | % | Soil water content sensor channel 1. |
| `SWC_1_1_2` | % | Soil water content sensor channel 2. |
| `SHP_1_1_1` | W m^-2 | Soil heat-pulse or heat-flux plate channel 1. |
| `SHP_1_1_2` | W m^-2 | Soil heat-pulse or heat-flux plate channel 2. |
| `SHP_1_1_3` | W m^-2 | Soil heat-pulse or heat-flux plate channel 3. |
| `SHP_1_1_4` | W m^-2 | Soil heat-pulse or heat-flux plate channel 4. |
| `P_1_1_1` | mm | Precipitation sensor channel. |
| `SWC` | % | Soil water content matched to leaf-level measurements. |
| `P_cum` | m | Cumulative precipitation variable. |
| `time_since_last_event_s` | s | Time since last precipitation event, in seconds. |
| `P_cum_mm` | mm | Cumulative precipitation, in mm. |
| `day_night` | day/night flag | Day/night flag. |
| `nee` | umol CO2 m^-2 s^-1 | Net ecosystem exchange. |
| `reco` | umol CO2 m^-2 s^-1 | Ecosystem respiration. |
| `gpp_umol_m2_s1` | umol CO2 m^-2 s^-1 | Gross primary productivity, in umol m^-2 s^-1. |
| `WUE.g_kg` | g kg^-1 | Water-use efficiency, in g kg^-1. |
