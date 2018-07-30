# Load required packages
library(tidyverse)
library(foreach)
library(stringr)
library(ggplot2)
library(RColorBrewer)
library(DESeq2)
library(dendextend)

# set directories
DATDIR <- "/data/hts2018_pilot/star_counts"
CURDIR <- "/home/jovyan/work/scratch/analysis_output"
OUTDIR <- file.path(CURDIR, "out")
IMGDIR <- file.path(CURDIR, "img")

# Metadata (metadtfile)
METADTFILE <- "/home/jovyan/work/HTS2018-notebooks/josh/info/2018_pilot_metadata_anon.tsv"

