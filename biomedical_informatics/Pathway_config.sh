# setting
cleanup () { 
    :
}
trap "cleanup" SIGPIPE
set -u

# set directory
CURDIR="/home/jovyan/work/scratch/analysis_output"
OUTDIR="${CURDIR}/out"
IMGDIR="${CURDIR}/img"
INFODIR="info"
PATHFILE="${INFODIR}/PathwaysByGeneIds_Summary.txt"

# python script
alias get_kegg_pathway="python get_kegg_pathway.py"