set -u
TARGET_DIR=${1:-hts2018}

WORK_DIR=$TARGET_DIR/jovyan/work
DATA_DIR=$TARGET_DIR/data/hts2018_pilot
JUPYTER_DIR=$TARGET_DIR/jupyter-HTS-2018
NOTEBOOK_DIR=$WORK_DIR/HTS2018-notebooks



mkdir -p $WORK_DIR $DATA_DIR
JUPYTER_PASWORD="dklf8FHidsah98gdpoadjsf"

DownloadData() {
    # Get data subset
    rsync -v --progress --stats vcm3:/tmp/hts2018/Granek_4837_180427A5/Granek_4837_180427A5.checksum $DATA_DIR
    rsync -v --progress --stats vcm3:/tmp/hts2018/Granek_4837_180427A5/27_MA_* $DATA_DIR
    rsync -v --progress --stats vcm3:/tmp/hts2018/Granek_4837_180427A5/35_MA_*.fastq.gz $DATA_DIR
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
      -v ${DATA_DIR}:/data \
      -v ${WORK_DIR}:/home/jovyan/work \
      -e NB_UID=1000 \
      mccahill/jupyter-hts-2018" > $TARGET_DIR/run
    bash $TARGET_DIR/run
}

BuildAndRunImage
DownloadData

# # Clone Notebook Repo
git clone git@gitlab.oit.duke.edu:HTS2018/HTS2018-notebooks.git $NOTEBOOK_DIR

echo "JUPYTER URL is <https://localhost:9999>"
echo "JUPYTER_PASWORD: $JUPYTER_PASWORD"
