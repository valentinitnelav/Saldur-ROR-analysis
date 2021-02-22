# Overview

R code for the analysis of the environmental impact of a "run-of-river" hydropower plant on the riverine ecosystem of the Saldur stream, a glacier-fed stream located in the Italian Central-Eastern Alps. Link to scientific article: (soon)

## How to use this repository

You can [download][1] or clone the repository then run the scripts using the *Saldur-ROR-analysis.Rproj* file ([R][2] and [R Studio][3] are needed).

For cloning, run this in a terminal (git should be [installed][4]):

```
git clone https://github.com/valentinitnelav/Saldur-ROR-analysis.git
```

Check also the readme file in the *analysis* folder with details about the scripts.

[1]: https://github.com/valentinitnelav/Saldur-ROR-analysis/archive/main.zip
[2]: https://www.r-project.org/
[3]: https://www.rstudio.com/products/rstudio/download/
[4]: https://git-scm.com/downloads

## Data

The original data are hosted by "PANGAEA - Data Publisher for Earth & Environmental Science".
Data repository at this permanent address: https://doi.pangaea.de/10.1594/PANGAEA.922524

From this original file we derived all the pre-prepared files included and stored in this repository in the "data" folder, which can be used as input files or templates for faster analyses. 

## Scripts/Analysis

The analysis of similarities, spatial and temporal beta-diversity and indicator taxa analysis are presented in the script `analysis/anosim_beta_multipatt.R`.

The Before-After-Control-Impact (BACI) analysis using the GLMM framework is documented in the directory `analysis/baci_glmm`. The reader is encouraged to follow the html reports. Each report corresponds to the following variables of interest:

<<<<<<< HEAD
- taxonomic richness (N0) -- baci-n0.html (generated from baci-n0.Rmd);
- density (individuals/m2) -- baci-density.html (generated from baci-density.Rmd);
- % Ephemeroptera–Plecoptera–Tricoptera (% EPT) -- baci-ept.html (generated from baci-ept.Rmd);
- Shannon evenness (Hill’s ratio, E10) -- baci-e10.html (generated from baci-e10.Rmd);
- Simpson evenness (Hill’s Ratio, E20) -- baci-e20.html (generated from baci-e20.Rmd).
=======
- taxonomic richness (N0) -- soon
- density (individuals/m2) -- soon
- % Ephemeroptera–Plecoptera–Tricoptera (% EPT) -- baci-ept.html (generated from baci-ept.Rmd)
- Shannon evenness (Hill’s ratio, E10) -- baci-e10.html (generated from baci-e10.Rmd)
- Simpson evenness (Hill’s Ratio, E20) -- baci-e20.html (generated from baci-e20.Rmd)
>>>>>>> 72eb7177e0490d8aabd48cb7fb8a3fdb40e1bc46
