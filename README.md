# Overview

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.6686873.svg)](https://doi.org/10.5281/zenodo.6686873)

Here we provide the analysis of the environmental impact of a "run-of-river" hydropower plant on the riverine ecosystem of the Saldur stream, a glacier-fed stream located in the Italian Central-Eastern Alps. 

This analysis is associated with the paper: [Small hydropower – small ecological footprint? A multi-annual environmental impact analysis using aquatic macroinvertebrates as bioindicators. Part 1: effects on community structure][1].

[1]: https://www.frontiersin.org/articles/10.3389/fenvs.2022.902603/abstract

## How to use this repository

You can view the analysis HTML reports at [this GitHub Pages link][2].

Alternatively, you can [download][3] or clone the repository then run the scripts using the *Saldur-ROR-analysis.Rproj* file ([R][4] and [R Studio][5] are needed).

For cloning, run the following command in a terminal (first, git should be [installed][6]):

```
git clone https://github.com/valentinitnelav/Saldur-ROR-analysis
```

[2]: https://valentinitnelav.github.io/Saldur-ROR-analysis/
[3]: https://github.com/valentinitnelav/Saldur-ROR-analysis/archive/main.zip
[4]: https://www.r-project.org/
[5]: https://www.rstudio.com/products/rstudio/download/
[6]: https://git-scm.com/downloads

## Data

The original data are hosted by "PANGAEA - Data Publisher for Earth & Environmental Science". The data repository is located [here][7].

From this original file we derived all the data files included and stored in our GitHub repository in the `./data` folder.

[7]: https://doi.pangaea.de/10.1594/PANGAEA.922524

## Analysis

You can either read the analysis at [this GitHub Pages link][2], or if you prefer to download or clone the repository, then:

- the analysis of similarities, spatial and temporal beta-diversity calculations, and indicator taxa analysis are presented in the script `analysis/anosim_beta_multipatt.R`.
- the Before-After-Control-Impact (BACI) analysis using the GLMM framework is documented in the directory `analysis/baci_glmm`. You can open and read the html reports in your browser. Each HTML report corresponds to the following variables of interest:

  - taxonomic richness (N0), [baci-n0.html][8] (generated from baci-n0.Rmd);
  - density (individuals/m2), [baci-density.html][9] (generated from baci-density.Rmd);
  - % Ephemeroptera–Plecoptera–Tricoptera (% EPT), [baci-ept.html][10] (generated from baci-ept.Rmd);
  - Shannon evenness (Hill’s ratio, E10), [baci-e10.html][11] (generated from baci-e10.Rmd);
  - Simpson evenness (Hill’s ratio, E20), [baci-e20.html][12] (generated from baci-e20.Rmd).

[8]: https://valentinitnelav.github.io/Saldur-ROR-analysis/baci-n0.html
[9]: https://valentinitnelav.github.io/Saldur-ROR-analysis/baci-density.html
[10]: https://valentinitnelav.github.io/Saldur-ROR-analysis/baci-ept.html
[11]: https://valentinitnelav.github.io/Saldur-ROR-analysis/baci-e10.html
[12]: https://valentinitnelav.github.io/Saldur-ROR-analysis/baci-e20.html

## License - MIT

See LICENSE file in this repository.
