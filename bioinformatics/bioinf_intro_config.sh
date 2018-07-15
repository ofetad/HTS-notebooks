set -u

# Input
export DATA_BASE="/data/hts2018_pilot"
export RAW_FASTQS="$DATA_BASE/Granek_4837_180427A5"

# Output
export CUROUT=$HOME/work/scratch/bioinf_intro
export TRIMMED=$CUROUT/trimmed_fastqs
export MYINFO=$CUROUT/myinfo
export GENOME_DIR=$CUROUT/genome
export STAR_OUT=$CUROUT/star_out
export FASTA=${GENOME_DIR}/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa
export GTF=${GENOME_DIR}/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf