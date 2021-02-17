# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Accompanying code for the paper "xxx", authored by
# Alberto Scotti, Dean Jacobsen, Valentin Stefan, Ulrike Tappeiner, and Roberta Bottarin.
#
# Script authored by Alberto Scotti.
# Please refer to the article for detailed methodological explanations and relevant citations.
#
# This script contains the analysis for:
# - Analysis of similarities (ANOSIM);
# - Spatial beta-diversity;
# - Temporal beta-diversity;
# - Multi-level pattern analysis (individual analysis)
#
# The BACI analysis using the GLMM framework is documented in analysis/baci_glmm
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Load packages -----------------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

library(ade4)
library(adespatial)
library(indicspecies)
library(lme4)
library(stats)
library(vegan)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Calculation of faunal metrics -------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load pre-prepared file of faunal data as input
spe <- read.csv("data/spehydro.csv", row.names=1)

# Calculate metrics
N0 <- rowSums(spe > 0)          # Taxonomic richness
H <- diversity(spe)             # Shannon entropy (base "e")
N1 <- exp(H)                    # Shannon diversity (base "e")
N2 <- diversity(spe, "inv")     # Simpson diversity
E10 <- N1 / N0                  # Shannon evenness (Hill's ratio), E10
E20 <- N2 / N0                  # Simpson evenness (Hill's ratio), E20

# density per square metre at sub-sample level is calculated dividing each cell
# of "spe" by /0.2024

# % EPT (Ephemeroptera-Plecoptera-Trichoptera) is calculated on the total of the
# organisms.

# In "spe" file relevant organisms for calculation are:
# - Ephemeroptera: from column 24 to column 27 included;
# - Plecoptera: from column 34 to column 44 included;
# - Trichoptera: from column 45 to column 63 included.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ANOSIM ------------------------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load pre-prepared file of faunal data as input (in this analysis, each site is
# tested separately, grouping variable is the year)

spesite1 <- read.csv("data/ANOSIM_inputspe_site1.csv")
inputyears <- read.csv("data/ANOSIM_inputyears.csv")

# Years as factors

inputyears$Year <- as.factor(inputyears$Year)

#compute ANOSIM on each site separately
(anosite1 <- anosim(spesite1, inputyears$Year, distance = "bray", permutations = 9999))
summary(anosite1)

# Repeat the analysis for the all sites changing the input data file "ANOSIM_inputspe_siteX.csv"

# ~~~~~

# Load pre-prepared file of faunal data as input (in this analysis, each year is
# tested separately, grouping variable is the site)

speyear2015 <- read.csv("data/ANOSIM_inputspe_2015.csv")
inputsites <- read.csv("data/ANOSIM_inputsites.csv")

# Sites as factors

inputsites$Site <- as.factor(inputsites$Site)

# Compute ANOSIM on each year separately
(anoyear2015 <- anosim(speyear2015, inputsites$Site, distance = "bray", permutations = 9999))
summary(anoyear2015)

# Repeat the analysis for the all years changing the input data file "ANOSIM_inputspe_X.csv"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SPATIAL BETA-DIVERSITY --------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load pre-prepared file of faunal data as input
spebetadiv15 <- read.csv("data/betadiv_15.csv", row.names=1)

# Sørensen-based Podani indices (quantitative form = percentage difference index)
(macro.pod.pd <- beta.div.comp(spebetadiv15, coef = "S", quant = TRUE))

macro.rich <- as.matrix(macro.pod.pd$rich)         # Richness difference matrix
macro.repl <- as.matrix(macro.pod.pd$repl)         # Replacement matrix
macro.diss <- as.matrix(macro.pod.pd$D)            # Dissimilarity matrix (sum of former two)

# Extract values with pair-comparison to control site 1
macro.rich.ctrl <- macro.rich[,1]
macro.repl.ctrl <- macro.repl[,1]
macro.diss.ctrl <- macro.diss[,1]

(macro.rich.ctrl <- macro.rich.ctrl[-(1)])         # Richness difference
(macro.repl.ctrl <- macro.repl.ctrl[-(1)])         # Replacement
(macro.diss.ctrl <- macro.diss.ctrl[-(1)])         # Total dissimilarity (percentage difference)

# Repeat the analysis for the all years changing the input data file "betadiv_XX.csv"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# TEMPORAL BETA-DIVERSITY -------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load pre-prepared file of faunal data as input
data <- read.csv("data/TBIinput.csv", row.names =1)

# Assign sampling years
survey15 = c(1:6)
survey16 = c(7:12)
survey17 = c(13:18)
survey18 = c(19:24)
survey19 = c(25:30)

# ABUNDANCE ANALYSIS

# Compute temporal beta-diversity (abundance) for each pair of years in relation
# to "before" year 2015
( res15_16a <- TBI(data[survey15,], data[survey16,], method="%diff",
                   nperm=9999, BCD=TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_17a <- TBI(data[survey15,], data[survey17,], method="%diff",
                  nperm=9999, BCD=TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_18a <- TBI(data[survey15,], data[survey18,], method="%diff",
                  nperm=9999, BCD=TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_19a <- TBI(data[survey15,], data[survey19,], method="%diff",
                  nperm=9999, BCD=TRUE, test.t.perm=TRUE, clock=TRUE) )

# PRESENCE/ABSENCE ANALYSIS

# Compute temporal beta-diversity (presence/absence) for each pair of years in
# relation to "before" year 2015
( res15_16pa <- TBI(data[survey15,], data[survey16,], method="sorensen",
                  nperm=9999, BCD=TRUE, test.BC = TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_17pa <- TBI(data[survey15,], data[survey17,], method="sorensen",
                  nperm=9999, BCD=TRUE, test.BC = TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_18pa <- TBI(data[survey15,], data[survey18,], method="sorensen",
                  nperm=9999, BCD=TRUE, test.BC = TRUE, test.t.perm=TRUE, clock=TRUE) )

( res15_19pa <- TBI(data[survey15,], data[survey19,], method="sorensen",
                  nperm=9999, BCD=TRUE, test.BC = TRUE, test.t.perm=TRUE, clock=TRUE) )

# Identify taxa whose abundance change significantly for each pair of years in
# relation to "before" year 2015
(rest15_16 <- tpaired.krandtest(data[survey15,],data[survey16,]))
p.adjust(rest15_16$t.test$p.perm, method = "fdr")                  # Correction for multiple testing

(rest15_17 <- tpaired.krandtest(data[survey15,],data[survey17,]))
p.adjust(rest15_17$t.test$p.perm, method = "fdr")                  # Correction for multiple testing

(rest15_18 <- tpaired.krandtest(data[survey15,],data[survey18,]))
p.adjust(rest15_18$t.test$p.perm, method = "fdr")                  # Correction for multiple testing

(rest15_19 <- tpaired.krandtest(data[survey15,],data[survey19,]))
p.adjust(rest15_19$t.test$p.perm, method = "fdr")                  # Correction for multiple testing

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# INDVAL ANALYSIS ---------------------------------------------------------
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load pre-prepared file of faunal data as input
indval.spe.years <- read.csv("data/INDVAL_inputspeyears.csv")

# Group the sub-samples by year ("early" and "late" periods together)
groupyears <- c(rep(1,36), rep(2,36), rep(3,36), rep(4,36), rep(5,36))

# Compute Indval for each single, pair and/or combination of year(s)
indval.years <- multipatt(indval.spe.years, groupyears, control = how(nperm=999))
summary(indval.years, indvalcomp = TRUE)
(p.val.adj <- p.adjust(indval.years$sign$p.value, method = "fdr"))    # Correction for multiple testing

# ~~~~

# Load pre-prepared file of faunal data as input
indval.spe.sites <- read.csv("data/INDVAL_inputspesites.csv")

# Group the sub-samples by sites
groupsites <- c(rep(1,30), rep(2,30), rep(2,30), rep(4,30), rep(5,30), rep(6,30))

# Compute Indval for each single, pair and/or combination of site(s)
indval.sites <- multipatt(indval.spe.sites, groupsites, control = how(nperm=999))
summary(indval.sites, indvalcomp = TRUE)
(p.val.adj <- p.adjust(indval.sites$sign$p.value, method = "fdr"))   # Correction for multiple testing
