# Trade Complementarity and Export Similarity: India and Selected FTA Partners (HS 2017, 2017–2024)

This repository analyzes trade structure alignment between India and its recent or prospective Free Trade Agreement (FTA) partners using:

- **Trade Complementarity Index (TCI)**
- **Export Similarity Index (ESI)**

The objective is to evaluate whether India's export profile aligns with partner import demand (complementarity) and whether export baskets overlap (competition / intra-industry potential).

---

## Countries Covered

- Australia  
- United Arab Emirates  
- Korea, Rep.  
- New Zealand  
- United Kingdom  
- Oman  

Period: **2017–2024**  
Classification: **HS 2017 Revision**  
Aggregation levels: **HS2 (sector-level)** and **HS4 (product-level)**  

Data source: World Integrated Trade Solution (WITS)

---

## Conceptual Framework

### Trade Complementarity Index (TCI)

Measures how well India's export structure matches a partner's import demand.
TCI = 100 × [1 − (Σ |Mi − Xi| / 2)]
- Higher TCI → Greater structural alignment  
- Captures **potential for inter-industry trade**

---

### Export Similarity Index (ESI)

Measures similarity between export baskets.

ESI = 100 × Σ min(Xi, Yi)
- Higher ESI → Greater export overlap  
- Indicates **competition or intra-industry trade potential**

---

## Interpretation Strategy

| High TCI | Low ESI | Complementary trade potential |
| High TCI | High ESI | Intra-industry & supply chain integration potential |
| Low TCI | Low ESI | Structurally dissimilar trade |
| Low TCI | High ESI | Competitive overlap without demand alignment |

Both indices are computed at:
- **HS2** → Sector structure
- **HS4** → Product specialization

---

## Reproducibility (Run in Order)

1. `01_tci_HS4.R`  
   → Cleans data and computes TCI  

2. `02_esi_HS4.R`  
   → Computes ESI  

3. `03_merge_and_visualize.R`  
   → Merges indices and generates plots  

Outputs are automatically saved in the `/output` folder.
