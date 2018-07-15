set -u

# Run Configs
export THREADS=2
export MAX_JOBS=8

# Input
export DATA_BASE="/data/hts2018_pilot"
export RAW_FASTQS="$DATA_BASE/Granek_4837_180427A5"
export INFO="../info"
export ADAPTERS="$INFO/neb_E7600_adapters_withrc.fasta"

# Output
export CUROUT=$HOME/work/scratch/2018_full_pilot
export TRIMMED=$CUROUT/trimmed_fastqs
export GENOME_DIR=$CUROUT/genome
export STAR_OUT=$CUROUT/star_out
export FINAL_COUNTS=$DATA_BASE/star_counts

# Genome
export FA_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/dna/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa.gz"
export GTF_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz"
export GFF_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/gff3/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gff3.gz"
export GFF=$(basename ${GFF_URL%.gz})
export GTF=$(basename ${GTF_URL%.gz})
export FA=$(basename ${FA_URL%.gz})
