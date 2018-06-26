set -u
export CUROUT=$HOME/work/scratch/2018_stresstest
export DATA_BASE="/data/hts2018_pilot"
export RAW_FASTQS="$DATA_BASE/Granek_4837_180427A5"
# CURDATA_1=$CURDATA
# export INFO=$HOME/work/myinfo
export TRIMMED=$CUROUT/trimmed_fastqs
export GENOME_DIR=$CUROUT/genome
export STAR_OUT=$CUROUT/star_out_stress
export ADAPTERS=$DATA_BASE/neb_E7600_adapters_withrc.fasta

# ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/fungi/Cryptococcus_neoformans/all_assembly_versions/GCF_000149245.1_CNA3
export ACCESSION="GCF_000149245.1_CNA3"
export PREFIX=${ACCESSION}_genomic
export GFF=${PREFIX}.gff
export GTF=${PREFIX}.gtf
export FNA=${PREFIX}.fna

export FA_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/fasta/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/dna/Cryptococcus_neoformans_var_grubii_h99.CNA3.dna.toplevel.fa.gz"
export GTF_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/gtf/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gtf.gz"
export GFF_URL="ftp://ftp.ensemblgenomes.org/pub/release-39/fungi/gff3/fungi_basidiomycota1_collection/cryptococcus_neoformans_var_grubii_h99/Cryptococcus_neoformans_var_grubii_h99.CNA3.39.gff3.gz"
export GFF=$(basename ${GFF_URL%.gz})
export GTF=$(basename ${GTF_URL%.gz})
export FA=$(basename ${FA_URL%.gz})
export THREADS=1
export MAX_JOBS=1

# echo $GFF $GTF $FA
# ls $CURDATA