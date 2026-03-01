# Scripts Folder

This folder contains R scripts used for data cleaning, index construction, and visualization.

## Required Packages

- tidyverse
- ggrepel

## Main Tasks

1. Data Cleaning
   - Convert trade values from 1000 USD to USD
   - Filter relevant reporters and trade flows
   - Merge India exports with partner imports

2. Index Construction
   - Trade Complementarity Index (TCI)
   - Export Similarity Index (ESI)
   - Computed at HS2 and HS4 levels

3. Product-Level Analysis
   - Share calculations
   - Absolute difference computation
   - Sector and product ranking

4. Visualization
   - Time-series plots
   - Quadrant classification (High/Low TCI & ESI)

## Methodology

TCI = 100 × [1 − (Σ |Mi − Xi| / 2)]

ESI = 100 × Σ min(Xi, Yi)

Where:
- Xi = India's export share in product i
- Mi = Partner's import share in product i
- Yi = Partner's export share in product i

All computations use tidyverse in R.

## Reproducibility

To reproduce results:
1. Place raw WITS files inside the `data/` folder.
2. Run scripts in sequence.
3. Outputs will be saved automatically to `output/`.
