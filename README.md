# Archaeological Data Analysis of the Finglesham Cemetery (RStudio)

## Project Overview
This project uses **RStudio** to analyse excavation data from **Finglesham**, an Anglo-Saxon cemetery in East Kent. The aim of the analysis is to address the research question:

> *Is there evidence of a significant imbalance between male and female representation in the cemetery during 500–600 CE, and does this change in 600–700 CE?*

The project applies statistical and visual methods to explore demographic representation across two chronological phases of burial activity.

---

## Data and Variables
The dataset includes individuals dated to two periods:
- **500–600 CE**
- **600–700 CE**

Sex categories used in the analysis:
- Male  
- Probable Male  
- Female  
- Probable Female  

Individuals of **unknown sex were excluded** to focus on remains with reasonably identifiable biological sex.

To address uncertainty in osteological identification, sexes were also grouped into:
- **Total Male** (Male + Probable Male)
- **Total Female** (Female + Probable Female)

This allowed exploration of both **minimum and maximum possible representations** of each sex.

---

## Methodology
To explore demographic patterns and test for imbalance, three main exploratory approaches were used:

### 1. Tabular Analysis
- A table was created showing counts of males, probable males, females, and probable females for each period.
- A contingency table of **total males vs total females** was also produced to support hypothesis testing.

### 2. Visualisation
- A **bar plot** was generated to display the distribution of certain and probable sex identifications.
- This helped visualise uncertainty within the dataset and compare proportional representation.
- A **cemetery plan** was created showing:
  - Unsampled graves
  - Unknown sexes
  - Total males
  - Total females  
  This was used to assess whether spatial clustering or positioning bias affected sex distribution.

### 3. Statistical Testing
- A **one-sample chi-squared test** was applied to test whether observed sex ratios differed significantly from an expected **50:50 distribution**.
- Tests were run for both periods using the highest and lowest possible sex estimates.

---

## Results
Across all tests, the **p-values exceeded the chosen significance threshold**, meaning the null hypothesis could not be rejected.

This indicates:
- No statistically significant imbalance between male and female representation in **500–600 CE**
- No statistically significant change in this balance during **600–700 CE**

Observed differences are therefore more likely due to **random variation** than deliberate cultural or burial practices.

---

## Interpretation
The results suggest that burials at Finglesham between 500–700 CE:
- Did not preferentially focus on one sex
- Showed mixed burial patterns across the cemetery
- Likely reflect **similar burial rites and social treatment** for males and females

This supports the interpretation of a relatively **egalitarian burial practice**, where both sexes held comparable social importance in funerary contexts.

---

## Tools Used
- **RStudio**
- Data tables and contingency tables
- Bar plots and spatial visualisation
- Chi-squared hypothesis testing

---

## Future Work
Further analysis could explore:
- Spatial relationships between individuals (e.g. proximity of male–female burials)
- Directionality or clustering patterns that may indicate family or social groupings
- Finer chronological divisions to assess demographic shifts during periods of conflict or social change

---
