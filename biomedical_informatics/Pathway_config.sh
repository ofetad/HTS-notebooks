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
INFODIR="/home/jovyan/work/HTS2018-notebooks/biomedical_informatics"
INFODIR="/home/jovyan/work/HTS2018-notebooks-repo/HTS2018-notebooks/biomedical_informatics/Info"
PATHFILE="${INFODIR}/PathwaysByGeneIds_Summary.txt"

# python script
alias get_kegg_pathway="python get_kegg_pathway.py"