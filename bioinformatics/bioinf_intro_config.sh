set -u

# Input
export DATA_BASE="/data/hts2018_pilot"
export RAW_FASTQS="$DATA_BASE/Granek_4837_180427A5"

# Output
export CUROUT=$HOME/work/scratch/bioinf_intro
export TRIMMED=$CUROUT/trimmed_fastqs
export MYINFO=$CUROUT/myinfo