library(tidyverse)
library(stringr)
library(pathview)
library(gage)
library(DESeq2)
library(pheatmap)

CURDIR <- "/home/jovyan/work/scratch/analysis_output"
OUTDIR <- file.path(CURDIR, "out")
IMGDIR <- file.path(CURDIR, "img")
INFODIR <- "/home/jovyan/work/HTS2018-notebooks-repo/HTS2018-notebooks/biomedical_informatics/Info"