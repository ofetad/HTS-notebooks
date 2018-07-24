set -u
TARGET_DIR=${1:-hts2018}

WORK_DIR=$TARGET_DIR/jovyan/work
DATA_DIR=$TARGET_DIR/data/hts2018_pilot
JUPYTER_DIR=$TARGET_DIR/jupyter-HTS-2018
NOTEBOOK_DIR=$WORK_DIR/HTS2018-notebooks


rm -rf $NOTEBOOK_DIR $JUPYTER_DIR
mkdir -p $WORK_DIR $DATA_DIR
JUPYTER_PASWORD="dklf8FHidsah98gdpoadjsf"

DownloadData() {
    # Get data subset
    # rsync  -avvzC --include="*/" --include='*.checksum' --include='35_MA_*.fastq.gz' --include='27_MA_*.fastq.gz' --exclude="*" vcm3:/tmp/hts2018/Granek_4837_180427A5 $DATA_DIR
    rsync  -avvzC --include="*/" --include='*.checksum' --include='35_MA_*.fastq.gz' --exclude="*" vcm3:/tmp/hts2018/Granek_4837_180427A5 $DATA_DIR
    # md5sum -vc Granek_4837_180427A5/Granek_4837_180427A5.checksum 
    # md5sum -vc Granek_4837_180427A5/Granek_4837_180427A5.checksum | grep -v open
}

# Build Jupyter Docker Image
BuildAndRunImage() {
    git clone git@gitlab.oit.duke.edu:HTS2018/jupyter-HTS-2018.git $JUPYTER_DIR
    docker build -t mccahill/jupyter-hts-2018 $JUPYTER_DIR
    echo "docker run --name jupyter-hts-2018 \
      -e USE_HTTPS=yes \
      -d -p 9999:8888 \
      -e PASSWORD="$JUPYTER_PASWORD" \
      -v $(dirname ${DATA_DIR}):/data \
      -v ${WORK_DIR}:/home/jovyan/work \
      -e NB_UID=1000 \
      mccahill/jupyter-hts-2018" > $TARGET_DIR/run_jupyter-hts-2018.sh
    bash $TARGET_DIR/run_jupyter-hts-2018.sh
}

BuildAndRunImage
DownloadData

# # Clone Notebook Repo
git clone git@gitlab.oit.duke.edu:HTS2018/HTS2018-notebooks.git $NOTEBOOK_DIR

printf "\n\nJUPYTER URL is <https://localhost:9999>\n"
printf "JUPYTER_PASWORD: $JUPYTER_PASWORD\n\n"
