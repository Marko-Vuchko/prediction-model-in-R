# Library Reading Analysis — Marko_Vučković_Task6

Professional, reproducible analysis of library user behaviour. This repository contains an R script that fits a regression model to predict number of books read from member age and membership duration, builds a simple classifier for "heavy readers", creates visualisations and exports example predictions.

## Contents
- library_books_read.csv — input dataset (expected columns: `member_age`, `membership_years`, `books_read`)
- Marko_Vučković_Task6_modeling.R — single self-contained analysis script (data loading, EDA, regression, classification, plots, export)
- Marko_Vučković_Task6_predictions.csv — example predictions exported by the script
- Marko_Vučković_Task6.Rproj — RStudio project file

## Project summary
- Goal: Model and understand reading behaviour in the library dataset; predict books read and identify heavy readers.
- Primary models:
  - Linear regression: books_read ~ member_age + membership_years
  - Logistic regression classifier: heavy reader (books_read > 25) ~ member_age + membership_years
- Outputs: model summaries, MAE for regression, classification accuracy and confusion matrix, ggplot2 visualisations, CSV export of predictions for hypothetical members.

## Data schema
Expected CSV columns:
- member_age — numeric (age of the member)
- membership_years — numeric (years of library membership)
- books_read — numeric/integer (number of books read)

If the dataset differs, update column names or preprocess accordingly in the script.

## Requirements
- R >= 4.0
- Packages: readr, tidyverse, ggplot2
Install packages (one-time):
```sh
R -e "install.packages(c('readr','tidyverse','ggplot2'))"
```

## How to run
From the project root folder (Windows):
```sh
# Option A: run non-interactively
Rscript "Marko_Vučković_Task6_modeling.R"

# Option B: open in RStudio and run the script or use the project file
# c:\Users\Marko\Desktop\IT Academy\3. Python Projects\8. R for Data Science and Data Analytics\Marko_Vučković_Task6\Marko_Vučković_Task6.Rproj
```

Set working directory if needed:
```r
setwd("c:/Users/Marko/Desktop/IT Academy/3. Python Projects/8. R for Data Science and Data Analytics/Marko_Vučković_Task6")
```

## Main script behavior
- Loads CSV: `library_books_read <- read.csv("library_books_read.csv")`
- Splits data into train/test (80/20) with `set.seed(123)` for reproducibility
- Fits linear model `lm(books_read ~ member_age + membership_years, data = train_data)`
- Evaluates MAE on test set
- Generates predictions for example `novi_clanovi` and writes `Marko_Vučković_Task6_predictions.csv`
- Adds binary column `read_many_books` (books_read > 25), fits `glm(..., family = binomial)`, computes predicted probabilities, confusion table, and accuracy
- Produces two ggplot2 visualisations (regression and classification views)

## Key files produced
- Marko_Vučković_Task6_predictions.csv — predicted `books_predicted` for sample new members
- Console outputs: regression summary, classification summary, MAE, accuracy, confusion matrix
- Plots displayed in the R plotting device (save manually if needed)

## Notes, assumptions & recommendations
- Heavy-reader threshold is currently `books_read > 25` — adjust to suit domain needs.
- Current evaluation uses a single random split (seed 123). For robust performance estimates use k-fold cross-validation or repeated resampling.
- Add diagnostics for regression (residual plots, heteroscedasticity tests) and classification (ROC, AUC, precision/recall).
- Consider saving fitted models with `saveRDS()` and loading via `readRDS()` for deployment.
- If multicollinearity is a concern, compute VIFs and address correlated predictors.
- For reproducible packaging, add a DESCRIPTION or renv lockfile.

## Suggested improvements / next steps
- Use caret or tidymodels for consistent workflows, tuning and CV.
- Expand features (e.g., genre preferences, visit frequency) if available.
- Add automated unit tests for data-loading and basic model outputs.
- Create a small report (RMarkdown) summarizing methods, diagnostics and figures.

## Author & license
Author: Marko Vučković  
This repository has no license file. Add a LICENSE (e.g., MIT) before publishing if wider reuse is intended.

## Contact
For questions about the code or data, open an issue in the repository or contact the author listed above.
```// filepath: c:\Users\Marko\Desktop\IT Academy\3. Python Projects\8. R for Data Science and Data Analytics\Marko_Vučković_Task6\README.md
# Library Reading Analysis — Marko_Vučković_Task6

Professional, reproducible analysis of library user behaviour. This repository contains an R script that fits a regression model to predict number of books read from member age and membership duration, builds a simple classifier for "heavy readers", creates visualisations and exports example predictions.
