# Load required packages
library(tidyverse)
library(foreach)
library(stringr)
library(haven)

library(DESeq2)
library(tools)
library(limma)
library(qvalue)

library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(dendextend)

library(plotly)

# set directories
DATDIR <- "/data/hts2018_pilot/star_counts"
CURDIR <- "/home/jovyan/work/scratch/analysis_output"
OUTDIR <- file.path(CURDIR, "out")
IMGDIR <- file.path(CURDIR, "img")

# Metadata (metadtfile)
METADTFILE <- "/home/jovyan/work/HTS2018-notebooks/josh/info/2018_pilot_metadata_anon.tsv"


