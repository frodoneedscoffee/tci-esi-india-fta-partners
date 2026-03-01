# Data Folder

This folder contains raw trade data used for calculating the Trade Complementarity Index (TCI) and Export Similarity Index (ESI).

## Source

All data were downloaded from the World Integrated Trade Solution (WITS) database.

- Classification: HS 2017 Revision
- Aggregation Level: HS4
- Period: 2017–2024
- Reporter Countries:
  - India (exports)
  - Australia
  - United Arab Emirates
  - Korea, Rep.
  - New Zealand
  - United Kingdom
  - Oman

## Structure

- Raw CSV files containing:
  - Nomenclature (HS5)
  - Reporter ISO3 code
  - Reporter name
  - Product code
  - Year
  - Partner ISO3 code (WLD)
  - Partner name (World)
  - Trade flow (Import/Export)
  - Trade flow code
  - Trade value (in 1000 USD)

## Notes

- UAE reports import data for 2018–2023.
- Oman reports import data for 2017–2023.
- Trade values are converted to USD (not thousands) in the processing scripts.
- No modifications have been made to raw files in this folder.

All cleaning and transformations are performed in the `scripts/` directory.
