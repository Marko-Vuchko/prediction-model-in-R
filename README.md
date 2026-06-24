# Library Reading Behavior — Predictive Modeling in R

Regression and classification analysis of library member reading habits. Predicts books read from member age and tenure, and identifies heavy readers using logistic regression.

[![R](https://img.shields.io/badge/R-4.0%2B-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)

---

## Overview

This project models how library membership duration and member age relate to reading volume. It delivers both a numeric prediction (linear regression) and a binary classifier for heavy readers (more than 25 books).

| Task | Business question | Method |
|------|-------------------|--------|
| **1** | How do age and tenure affect books read? | Linear regression (`lm`) |
| **2** | Can we predict reading volume for new members? | Hold-out test + MAE |
| **3** | Who qualifies as a heavy reader? | Logistic regression (threshold > 25) |
| **4** | How accurate is the classifier? | Confusion matrix & accuracy |

---

## Results (typical run)

| Model | Metric | Value |
|-------|--------|-------|
| Linear regression | MAE on test set | ~3.5 books (varies by split) |
| Logistic classifier | Accuracy | ~85–95% (depends on class balance) |
| Regression insight | Stronger predictor | `membership_years` vs. `member_age` |

Run `Rscript analysis.R` locally to reproduce exact metrics with `set.seed(123)`.

---

## Repository structure

```
.
├── analysis.R              # Full analysis pipeline
├── library_books_read.csv  # Input dataset
├── predictions.csv         # Exported predictions for sample members
├── LICENSE
└── README.md
```

---

## Data schema

| Column | Type | Description |
|--------|------|-------------|
| `member_age` | numeric | Member age |
| `membership_years` | numeric | Years of library membership |
| `books_read` | numeric | Total books read |

---

## Quick start

```bash
git clone https://github.com/Marko-Vuchko/prediction-model-in-R.git
cd prediction-model-in-R
```

Install packages:

```r
install.packages(c("readr", "tidyverse", "ggplot2"))
```

Run:

```bash
Rscript analysis.R
```

---

## Methodology

1. 80/20 train/test split with `set.seed(123)`.
2. Fit `books_read ~ member_age + membership_years` (linear model); evaluate MAE.
3. Export sample predictions to `predictions.csv`.
4. Create binary `read_many_books` flag; fit `glm(..., family = binomial)`.
5. Report confusion matrix, accuracy, and ggplot2 visualizations.

---

## Tech stack

**R:** readr, tidyverse, ggplot2

---

## Author

**Marko Vučković** — Data Analyst & Developer  
[GitHub](https://github.com/Marko-Vuchko) · [Email](mailto:markovucko12@gmail.com)

---

## License

This project is released under the [MIT License](LICENSE).
