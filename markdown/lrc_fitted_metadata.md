# Metadata for lrc_fitted.csv

Fitted LI-COR LI-6400 light-response curve parameter table derived from Marshall-Biscoe model fits.

Parameters were derived from LI-COR LI-6400 light-response curve measurements.

LI-6400 instrument units follow the official LI-COR LI-6400/LI-6400XT operating instructions and variable tables: https://cloud.licor.com/env/support/LI-6400/manuals.html

## Columns

Physical units, formats, or value types are provided where they can be assigned from the instrument documentation, Eddy Covariance conventions, column names, or project processing context.

| Column | Unit | Description |
| --- | --- | --- |
| `k_sat` | umol CO2 m^-2 s^-1 | Saturating gross assimilation parameter from the fitted light-response model. |
| `phi_J` | mol CO2 mol photons^-1 | Initial quantum-yield parameter from the fitted light-response model. |
| `theta_J` | dimensionless curvature parameter | Curvature parameter from the fitted light-response model. |
| `Rd` | umol CO2 m^-2 s^-1 | Dark respiration parameter from the fitted light-response model. |
| `filename` | identifier | Source LI-6400 file or fitted light-response curve identifier. |
| `Asat_net` | umol CO2 m^-2 s^-1 | Net saturating assimilation rate derived from the fitted curve. |
| `Km_net` | umol photons m^-2 s^-1 | PAR at half of net saturating assimilation, derived from the fitted curve. |
