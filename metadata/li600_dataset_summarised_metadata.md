# Metadata for li600_dataset_summarised.csv

Summarised LI-COR LI-600/LI-600F dataset aggregated by timestamp, species, season, daytime, and leaf age.

Measurements were made with a LI-COR LI-600/LI-600F Porometer/Fluorometer. Columns ending in `_median` and `_std` are the group median and standard deviation of the corresponding base variable.

LI-600 instrument labels and value types follow the official LI-COR data-file structure documentation: https://shop.licor.com/env/support/LI-600/topics/data-file-descriptions.html

## Columns

Physical units, formats, or value types are provided where they can be assigned from the instrument documentation, Eddy Covariance conventions, column names, or project processing context.

| Column | Unit | Description |
| --- | --- | --- |
| `timestamp` | date-time format | Date and time of the matched observation, formatted as YYYY-mm-dd HH:MM:SS. |
| `species` | category | Plant type: Nit-A is Protea nitida adult, Nit-S is Protea nitida seedling, and Rep-S is Protea repens seedling. |
| `season` | category | Sampling season, defined as autumn, winter, spring, or summer. |
| `daytime` | category | Sampling period, defined as morning, noon, or afternoon. |
| `leaf_age` | category | Leaf cohort, defined as Yng, Mid, or Old. |
| `gsw_median` | mol H2O m^-2 s^-1 | Group median of stomatal conductance to water vapour, in mol m^-2 s^-1. |
| `gsw_std` | mol H2O m^-2 s^-1 | Group standard deviation of stomatal conductance to water vapour, in mol m^-2 s^-1. |
| `gbw_median` | mol H2O m^-2 s^-1 | Group median of boundary layer conductance to water vapour. |
| `gbw_std` | mol H2O m^-2 s^-1 | Group standard deviation of boundary layer conductance to water vapour. |
| `gtw_median` | mol H2O m^-2 s^-1 | Group median of total conductance to water vapour. |
| `gtw_std` | mol H2O m^-2 s^-1 | Group standard deviation of total conductance to water vapour. |
| `E_apparent_median` | mmol H2O m^-2 s^-1 | Group median of apparent transpiration rate reported by the LI-600. |
| `E_apparent_std` | mmol H2O m^-2 s^-1 | Group standard deviation of apparent transpiration rate reported by the LI-600. |
| `VPcham_median` | kPa | Group median of water vapour pressure in the chamber. |
| `VPcham_std` | kPa | Group standard deviation of water vapour pressure in the chamber. |
| `VPref_median` | kPa | Group median of reference water vapour pressure. |
| `VPref_std` | kPa | Group standard deviation of reference water vapour pressure. |
| `VPleaf_median` | kPa | Group median of estimated leaf water vapour pressure. |
| `VPleaf_std` | kPa | Group standard deviation of estimated leaf water vapour pressure. |
| `VPDleaf_median` | kPa | Group median of leaf vapour pressure deficit. |
| `VPDleaf_std` | kPa | Group standard deviation of leaf vapour pressure deficit. |
| `H2O_r_median` | mmol H2O mol^-1 | Group median of reference H2O mole fraction or concentration from the instrument. |
| `H2O_r_std` | mmol H2O mol^-1 | Group standard deviation of reference H2O mole fraction or concentration from the instrument. |
| `H2O_s_median` | mmol H2O mol^-1 | Group median of sample H2O mole fraction or concentration from the instrument. |
| `H2O_s_std` | mmol H2O mol^-1 | Group standard deviation of sample H2O mole fraction or concentration from the instrument. |
| `H2O_leaf_median` | mmol H2O mol^-1 | Group median of estimated leaf H2O value used by the instrument calculation. |
| `H2O_leaf_std` | mmol H2O mol^-1 | Group standard deviation of estimated leaf H2O value used by the instrument calculation. |
| `leaf_area_median` | cm^2 | Group median of leaf area used for instrument calculations. |
| `leaf_area_std` | cm^2 | Group standard deviation of leaf area used for instrument calculations. |
| `Fo_median` | relative fluorescence yield | Group median of minimum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fo_std` | relative fluorescence yield | Group standard deviation of minimum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fm_median` | relative fluorescence yield | Group median of maximum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fm_std` | relative fluorescence yield | Group standard deviation of maximum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fv/Fm_median` | dimensionless ratio | Group median of maximum quantum efficiency of photosystem II. |
| `Fv/Fm_std` | dimensionless ratio | Group standard deviation of maximum quantum efficiency of photosystem II. |
| `Fs_median` | relative fluorescence yield | Group median of steady-state fluorescence. |
| `Fs_std` | relative fluorescence yield | Group standard deviation of steady-state fluorescence. |
| `Fm'_median` | relative fluorescence yield | Group median of maximum fluorescence in the light-adapted state. |
| `Fm'_std` | relative fluorescence yield | Group standard deviation of maximum fluorescence in the light-adapted state. |
| `PhiPS2_median` | dimensionless quantum efficiency | Group median of operating efficiency of photosystem II. |
| `PhiPS2_std` | dimensionless quantum efficiency | Group standard deviation of operating efficiency of photosystem II. |
| `PS2/1_median` | dimensionless ratio | Group median of photosystem II/one allocation or instrument fluorescence ratio. |
| `PS2/1_std` | dimensionless ratio | Group standard deviation of photosystem II/one allocation or instrument fluorescence ratio. |
| `abs_median` | dimensionless fraction | Group median of leaf absorptance setting or value used for ETR calculations. |
| `abs_std` | dimensionless fraction | Group standard deviation of leaf absorptance setting or value used for ETR calculations. |
| `ETR_median` | umol electrons m^-2 s^-1 | Group median of electron transport rate. |
| `ETR_std` | umol electrons m^-2 s^-1 | Group standard deviation of electron transport rate. |
| `rh_s_median` | % | Group median of sample relative humidity. |
| `rh_s_std` | % | Group standard deviation of sample relative humidity. |
| `rh_r_median` | % | Group median of reference relative humidity. |
| `rh_r_std` | % | Group standard deviation of reference relative humidity. |
| `Tref_median` | deg C | Group median of reference air temperature. |
| `Tref_std` | deg C | Group standard deviation of reference air temperature. |
| `Tleaf_median` | deg C | Group median of leaf temperature. |
| `Tleaf_std` | deg C | Group standard deviation of leaf temperature. |
| `P_atm_median` | kPa | Group median of atmospheric pressure measured by the instrument. |
| `P_atm_std` | kPa | Group standard deviation of atmospheric pressure measured by the instrument. |
| `flow_median` | umol s^-1 | Group median of instrument flow rate. |
| `flow_std` | umol s^-1 | Group standard deviation of instrument flow rate. |
| `flow_s_median` | umol s^-1 | Group median of sample-side flow rate. |
| `flow_s_std` | umol s^-1 | Group standard deviation of sample-side flow rate. |
| `leak_pct_median` | % | Group median of estimated leak percentage. |
| `leak_pct_std` | % | Group standard deviation of estimated leak percentage. |
| `Qamb_median` | instrument export value | Group median of ambient photosynthetically active radiation or quantum flux measured by the instrument. |
| `Qamb_std` | instrument export value | Group standard deviation of ambient photosynthetically active radiation or quantum flux measured by the instrument. |
| `batt_median` | V | Group median of instrument battery voltage or status. |
| `batt_std` | V | Group standard deviation of instrument battery voltage or status. |
| `heading_median` | degrees | Group median of instrument compass heading. |
| `heading_std` | degrees | Group standard deviation of instrument compass heading. |
| `angle_inc_leaf_median` | degrees | Group median of estimated leaf angle of incidence. |
| `angle_inc_leaf_std` | degrees | Group standard deviation of estimated leaf angle of incidence. |
| `direct_pct_median` | % | Group median of estimated percentage of direct radiation. |
| `direct_pct_std` | % | Group standard deviation of estimated percentage of direct radiation. |
| `slope_leaf_median` | degrees | Group median of leaf slope angle. |
| `slope_leaf_std` | degrees | Group standard deviation of leaf slope angle. |
| `az_leaf_median` | degrees | Group median of leaf azimuth angle. |
| `az_leaf_std` | degrees | Group standard deviation of leaf azimuth angle. |
| `dec_solar_median` | degrees | Group median of solar declination. |
| `dec_solar_std` | degrees | Group standard deviation of solar declination. |
| `az_solar_median` | degrees | Group median of solar azimuth. |
| `az_solar_std` | degrees | Group standard deviation of solar azimuth. |
| `zenith_solar_median` | degrees | Group median of solar zenith angle. |
| `zenith_solar_std` | degrees | Group standard deviation of solar zenith angle. |
| `latitude_median` | decimal degrees | Group median of gPS latitude. |
| `latitude_std` | decimal degrees | Group standard deviation of gPS latitude. |
| `longitude_median` | decimal degrees | Group median of gPS longitude. |
| `longitude_std` | decimal degrees | Group standard deviation of gPS longitude. |
| `altitude_median` | m | Group median of gPS altitude. |
| `altitude_std` | m | Group standard deviation of gPS altitude. |
| `gps_sats_median` | satellite count | Group median of number of GPS satellites used. |
| `gps_sats_std` | satellite count | Group standard deviation of number of GPS satellites used. |
| `gps_HDOP_median` | dimensionless precision index | Group median of gPS horizontal dilution of precision. |
| `gps_HDOP_std` | dimensionless precision index | Group standard deviation of gPS horizontal dilution of precision. |
| `rh_adj_median` | % | Group median of relative-humidity adjustment applied by the instrument. |
| `rh_adj_std` | % | Group standard deviation of relative-humidity adjustment applied by the instrument. |
| `gsw1sec_median` | mol H2O m^-2 s^-1 | Group median of one-second stomatal conductance stability metric. |
| `gsw1sec_std` | mol H2O m^-2 s^-1 | Group standard deviation of one-second stomatal conductance stability metric. |
| `gsw2sec_median` | mol H2O m^-2 s^-1 | Group median of two-second stomatal conductance stability metric. |
| `gsw2sec_std` | mol H2O m^-2 s^-1 | Group standard deviation of two-second stomatal conductance stability metric. |
| `gsw4sec_median` | mol H2O m^-2 s^-1 | Group median of four-second stomatal conductance stability metric. |
| `gsw4sec_std` | mol H2O m^-2 s^-1 | Group standard deviation of four-second stomatal conductance stability metric. |
| `flr1sec_median` | fluorescence stability value | Group median of one-second fluorescence stability metric. |
| `flr1sec_std` | fluorescence stability value | Group standard deviation of one-second fluorescence stability metric. |
| `flr2sec_median` | fluorescence stability value | Group median of two-second fluorescence stability metric. |
| `flr2sec_std` | fluorescence stability value | Group standard deviation of two-second fluorescence stability metric. |
| `flr4sec_median` | fluorescence stability value | Group median of four-second fluorescence stability metric. |
| `flr4sec_std` | fluorescence stability value | Group standard deviation of four-second fluorescence stability metric. |
| `auto_median` | 0/1 flag | Group median of instrument auto-measurement flag. |
| `auto_std` | 0/1 flag | Group standard deviation of instrument auto-measurement flag. |
| `flow_set_median` | umol s^-1 | Group median of instrument flow set point. |
| `flow_set_std` | umol s^-1 | Group standard deviation of instrument flow set point. |
| `flr_period_median` | s | Group median of fluorescence stability period used by the instrument. |
| `flr_period_std` | s | Group standard deviation of fluorescence stability period used by the instrument. |
| `P1_dur_median` | ms | Group median of duration of fluorescence protocol phase P1. |
| `P1_dur_std` | ms | Group standard deviation of duration of fluorescence protocol phase P1. |
| `P2_dur_median` | ms | Group median of duration of fluorescence protocol phase P2. |
| `P2_dur_std` | ms | Group standard deviation of duration of fluorescence protocol phase P2. |
| `P3_dur_median` | ms | Group median of duration of fluorescence protocol phase P3. |
| `P3_dur_std` | ms | Group standard deviation of duration of fluorescence protocol phase P3. |
| `P1_Fmax_median` | relative fluorescence yield | Group median of maximum fluorescence value from phase P1. |
| `P1_Fmax_std` | relative fluorescence yield | Group standard deviation of maximum fluorescence value from phase P1. |
| `P2_ramp_median` | flash-ramp setting | Group median of ramp setting or value from phase P2. |
| `P2_ramp_std` | flash-ramp setting | Group standard deviation of ramp setting or value from phase P2. |
| `P2_slp_median` | fluorescence regression slope | Group median of slope value from phase P2. |
| `P2_slp_std` | fluorescence regression slope | Group standard deviation of slope value from phase P2. |
| `P3_Fmax_median` | relative fluorescence yield | Group median of maximum fluorescence value from phase P3. |
| `P3_Fmax_std` | relative fluorescence yield | Group standard deviation of maximum fluorescence value from phase P3. |
| `P3_Pred_median` | relative fluorescence yield | Group median of predicted fluorescence value from phase P3. |
| `P3_Pred_std` | relative fluorescence yield | Group standard deviation of predicted fluorescence value from phase P3. |
| `P3_DeltaF_median` | relative fluorescence yield | Group median of fluorescence change from phase P3. |
| `P3_DeltaF_std` | relative fluorescence yield | Group standard deviation of fluorescence change from phase P3. |
| `v_humA_median` | V | Group median of instrument humidity sensor A voltage or diagnostic. |
| `v_humA_std` | V | Group standard deviation of instrument humidity sensor A voltage or diagnostic. |
| `v_humB_median` | V | Group median of instrument humidity sensor B voltage or diagnostic. |
| `v_humB_std` | V | Group standard deviation of instrument humidity sensor B voltage or diagnostic. |
| `v_flowIn_median` | V | Group median of instrument inlet-flow voltage or diagnostic. |
| `v_flowIn_std` | V | Group standard deviation of instrument inlet-flow voltage or diagnostic. |
| `v_flowOut_median` | V | Group median of instrument outlet-flow voltage or diagnostic. |
| `v_flowOut_std` | V | Group standard deviation of instrument outlet-flow voltage or diagnostic. |
| `v_temp_median` | V | Group median of instrument temperature voltage or diagnostic. |
| `v_temp_std` | V | Group standard deviation of instrument temperature voltage or diagnostic. |
| `v_irt_median` | V | Group median of infrared temperature sensor voltage or diagnostic. |
| `v_irt_std` | V | Group standard deviation of infrared temperature sensor voltage or diagnostic. |
| `v_pres_median` | V | Group median of pressure sensor voltage or diagnostic. |
| `v_pres_std` | V | Group standard deviation of pressure sensor voltage or diagnostic. |
| `v_par_median` | V | Group median of pAR sensor voltage or diagnostic. |
| `v_par_std` | V | Group standard deviation of pAR sensor voltage or diagnostic. |
| `v_F_median` | V | Group median of fluorescence sensor voltage or diagnostic. |
| `v_F_std` | V | Group standard deviation of fluorescence sensor voltage or diagnostic. |
| `i_LED_median` | A | Group median of fluorescence LED current diagnostic. |
| `i_LED_std` | A | Group standard deviation of fluorescence LED current diagnostic. |
| `b_rhr_median` | calibration intercept | Group median of reference relative-humidity calibration intercept. |
| `b_rhr_std` | calibration intercept | Group standard deviation of reference relative-humidity calibration intercept. |
| `m_rhr_median` | calibration slope | Group median of reference relative-humidity calibration slope. |
| `m_rhr_std` | calibration slope | Group standard deviation of reference relative-humidity calibration slope. |
| `span_rhr_median` | calibration span | Group median of reference relative-humidity calibration span. |
| `span_rhr_std` | calibration span | Group standard deviation of reference relative-humidity calibration span. |
| `b_rhs_median` | calibration intercept | Group median of sample relative-humidity calibration intercept. |
| `b_rhs_std` | calibration intercept | Group standard deviation of sample relative-humidity calibration intercept. |
| `m_rhs_median` | calibration slope | Group median of sample relative-humidity calibration slope. |
| `m_rhs_std` | calibration slope | Group standard deviation of sample relative-humidity calibration slope. |
| `span_rhs_median` | calibration span | Group median of sample relative-humidity calibration span. |
| `span_rhs_std` | calibration span | Group standard deviation of sample relative-humidity calibration span. |
| `z_flowIn_median` | sensor zero value | Group median of inlet-flow zero calibration value. |
| `z_flowIn_std` | sensor zero value | Group standard deviation of inlet-flow zero calibration value. |
| `z_flowOut_median` | sensor zero value | Group median of outlet-flow zero calibration value. |
| `z_flowOut_std` | sensor zero value | Group standard deviation of outlet-flow zero calibration value. |
| `z_quantum_median` | sensor zero value | Group median of quantum sensor zero calibration value. |
| `z_quantum_std` | sensor zero value | Group standard deviation of quantum sensor zero calibration value. |
| `z_flr_median` | sensor zero value | Group median of fluorescence sensor zero calibration value. |
| `z_flr_std` | sensor zero value | Group standard deviation of fluorescence sensor zero calibration value. |
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
