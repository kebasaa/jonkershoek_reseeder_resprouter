# Metadata for li600_dataset.csv

Full LI-COR LI-600/LI-600F porometer/fluorometer dataset of leaf-level measurements for *Protea nitida* adults, *P. nitida* seedlings, and *P. repens* seedlings. Contains stomatal conductance, transpiration-related variables, chlorophyll fluorescence metrics, leaf and sampling metadata, and matched meteorological and Eddy Covariance-derived variables.

Measurements were made with a LI-COR LI-600/LI-600F Porometer/Fluorometer, a compact handheld instrument for rapid ambient leaf-level stomatal conductance and chlorophyll a fluorescence measurements.

LI-600 instrument labels and value types follow the official LI-COR data-file structure documentation: https://shop.licor.com/env/support/LI-600/topics/data-file-descriptions.html

## Columns

Physical units, formats, or value types are provided where they can be assigned from the instrument documentation, Eddy Covariance conventions, column names, or project processing context.

| Column | Unit | Description |
| --- | --- | --- |
| `timestamp` | date-time format | Date and time of the matched observation, formatted as YYYY-mm-dd HH:MM:SS. |
| `species` | category | Plant type: Nit-A is Protea nitida adult, Nit-S is Protea nitida seedling, and Rep-S is Protea repens seedling. |
| `specimen` | identifier | Individual plant or specimen identifier. |
| `leaf_age` | category | Leaf cohort, defined as Yng, Mid, or Old. |
| `season` | category | Sampling season, defined as autumn, winter, spring, or summer. |
| `daytime` | category | Sampling period, defined as morning, noon, or afternoon. |
| `Obs#` | record number | LI-600 observation number within a measurement file or sequence. |
| `barcode` | identifier | Leaf/sample barcode used to link repeated measurements. |
| `gsw` | mol H2O m^-2 s^-1 | Stomatal conductance to water vapour, in mol m^-2 s^-1. |
| `gbw` | mol H2O m^-2 s^-1 | Boundary layer conductance to water vapour. |
| `gtw` | mol H2O m^-2 s^-1 | Total conductance to water vapour. |
| `E_apparent` | mmol H2O m^-2 s^-1 | Apparent transpiration rate reported by the LI-600. |
| `VPcham` | kPa | Water vapour pressure in the chamber. |
| `VPref` | kPa | Reference water vapour pressure. |
| `VPleaf` | kPa | Estimated leaf water vapour pressure. |
| `VPDleaf` | kPa | Leaf vapour pressure deficit. |
| `H2O_r` | mmol H2O mol^-1 | Reference H2O mole fraction or concentration from the instrument. |
| `H2O_s` | mmol H2O mol^-1 | Sample H2O mole fraction or concentration from the instrument. |
| `H2O_leaf` | mmol H2O mol^-1 | Estimated leaf H2O value used by the instrument calculation. |
| `leaf_area` | cm^2 | Leaf area used for instrument calculations. |
| `Fo` | relative fluorescence yield | Minimum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fm` | relative fluorescence yield | Maximum fluorescence from the dark- or light-adapted fluorescence protocol. |
| `Fv/Fm` | dimensionless ratio | Maximum quantum efficiency of photosystem II. |
| `Fs` | relative fluorescence yield | Steady-state fluorescence. |
| `Fm'` | relative fluorescence yield | Maximum fluorescence in the light-adapted state. |
| `PhiPS2` | dimensionless quantum efficiency | Operating efficiency of photosystem II. |
| `PS2/1` | dimensionless ratio | Photosystem II/one allocation or instrument fluorescence ratio. |
| `abs` | dimensionless fraction | Leaf absorptance setting or value used for ETR calculations. |
| `ETR` | umol electrons m^-2 s^-1 | Electron transport rate. |
| `rh_s` | % | Sample relative humidity. |
| `rh_r` | % | Reference relative humidity. |
| `Tref` | deg C | Reference air temperature. |
| `Tleaf` | deg C | Leaf temperature. |
| `P_atm` | kPa | Atmospheric pressure measured by the instrument. |
| `flow` | umol s^-1 | Instrument flow rate. |
| `flow_s` | umol s^-1 | Sample-side flow rate. |
| `leak_pct` | % | Estimated leak percentage. |
| `Qamb` | instrument export value | Ambient photosynthetically active radiation or quantum flux measured by the instrument. |
| `batt` | V | Instrument battery voltage or status. |
| `pitch_x` | degrees | LI-600 pitch/orientation diagnostic. |
| `roll_x` | degrees | LI-600 roll/orientation diagnostic. |
| `heading` | degrees | Instrument compass heading. |
| `angle_inc_leaf` | degrees | Estimated leaf angle of incidence. |
| `direct_pct` | % | Estimated percentage of direct radiation. |
| `slope_leaf` | degrees | Leaf slope angle. |
| `az_leaf` | degrees | Leaf azimuth angle. |
| `dec_solar` | degrees | Solar declination. |
| `az_solar` | degrees | Solar azimuth. |
| `zenith_solar` | degrees | Solar zenith angle. |
| `gps_time` | time format | GPS time recorded by the instrument. |
| `gps_date` | date format | GPS date recorded by the instrument. |
| `latitude` | decimal degrees | GPS latitude. |
| `longitude` | decimal degrees | GPS longitude. |
| `altitude` | m | GPS altitude. |
| `gps_sats` | satellite count | Number of GPS satellites used. |
| `gps_HDOP` | dimensionless precision index | GPS horizontal dilution of precision. |
| `match_time` | time format | Time of the matched environmental/EC record. |
| `match_date` | date format | Date of the matched environmental/EC record. |
| `rh_adj` | % | Relative-humidity adjustment applied by the instrument. |
| `gsw1sec` | mol H2O m^-2 s^-1 | One-second stomatal conductance stability metric. |
| `gsw2sec` | mol H2O m^-2 s^-1 | Two-second stomatal conductance stability metric. |
| `gsw4sec` | mol H2O m^-2 s^-1 | Four-second stomatal conductance stability metric. |
| `flr1sec` | fluorescence stability value | One-second fluorescence stability metric. |
| `flr2sec` | fluorescence stability value | Two-second fluorescence stability metric. |
| `flr4sec` | fluorescence stability value | Four-second fluorescence stability metric. |
| `auto` | 0/1 flag | Instrument auto-measurement flag. |
| `flow_set` | umol s^-1 | Instrument flow set point. |
| `gsw_limit` | mol H2O m^-2 s^-1 per stability period | Stomatal conductance stability limit used by the instrument. |
| `gsw_period` | s | Stomatal conductance stability period used by the instrument. |
| `dark` | 0/1 flag | Dark-adaptation or dark-measurement flag. |
| `flash_intensity` | umol photons m^-2 s^-1 | Fluorescence saturating-flash intensity setting. |
| `modrate` | Hz | Fluorescence modulation rate setting. |
| `flr_limit` | fluorescence slope limit | Fluorescence stability limit used by the instrument. |
| `flr_period` | s | Fluorescence stability period used by the instrument. |
| `P1_dur` | ms | Duration of fluorescence protocol phase P1. |
| `P2_dur` | ms | Duration of fluorescence protocol phase P2. |
| `P3_dur` | ms | Duration of fluorescence protocol phase P3. |
| `P1_Fmax` | relative fluorescence yield | Maximum fluorescence value from phase P1. |
| `P2_ramp` | flash-ramp setting | Ramp setting or value from phase P2. |
| `P2_slp` | fluorescence regression slope | Slope value from phase P2. |
| `P3_Fmax` | relative fluorescence yield | Maximum fluorescence value from phase P3. |
| `P3_Pred` | relative fluorescence yield | Predicted fluorescence value from phase P3. |
| `P3_DeltaF` | relative fluorescence yield | Fluorescence change from phase P3. |
| `v_humA` | V | Instrument humidity sensor A voltage or diagnostic. |
| `v_humB` | V | Instrument humidity sensor B voltage or diagnostic. |
| `v_flowIn` | V | Instrument inlet-flow voltage or diagnostic. |
| `v_flowOut` | V | Instrument outlet-flow voltage or diagnostic. |
| `v_temp` | V | Instrument temperature voltage or diagnostic. |
| `v_irt` | V | Infrared temperature sensor voltage or diagnostic. |
| `v_pres` | V | Pressure sensor voltage or diagnostic. |
| `v_par` | V | PAR sensor voltage or diagnostic. |
| `v_F` | V | Fluorescence sensor voltage or diagnostic. |
| `i_LED` | A | Fluorescence LED current diagnostic. |
| `b_rhr` | calibration intercept | Reference relative-humidity calibration intercept. |
| `m_rhr` | calibration slope | Reference relative-humidity calibration slope. |
| `span_rhr` | calibration span | Reference relative-humidity calibration span. |
| `b_rhs` | calibration intercept | Sample relative-humidity calibration intercept. |
| `m_rhs` | calibration slope | Sample relative-humidity calibration slope. |
| `span_rhs` | calibration span | Sample relative-humidity calibration span. |
| `z_flowIn` | sensor zero value | Inlet-flow zero calibration value. |
| `z_flowOut` | sensor zero value | Outlet-flow zero calibration value. |
| `z_quantum` | sensor zero value | Quantum sensor zero calibration value. |
| `z_flr` | sensor zero value | Fluorescence sensor zero calibration value. |
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
| `pitch_y` | degrees | Sonic-anemometer pitch angle. |
| `roll_y` | degrees | Sonic-anemometer roll angle. |
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
