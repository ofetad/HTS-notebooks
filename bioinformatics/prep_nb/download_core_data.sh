#!/bin/bash
set -e
set -u

DEFAULT_LOCALBASE="$HOME/test"
# # ================================================================================
# # ================================================================================
# # ================================================================================
# # Do not change below here
# # ================================================================================
# # ================================================================================
# # ================================================================================

# Define Text colors
MAGENTA=$(tput setaf 5)
NORMAL=$(tput sgr0)


#### Run as:
: <<'RUN_AS_NOTE'
./download_core_data.sh SEQCORE_EMAIL OUTDIR
RUN_AS_NOTE

statusMessage() {
    printf "${MAGENTA} %s:   $1 . . .${NORMAL}\n" "$(date)" >&2
}

statusMessage "nargs: $#"


if [ "$#" -eq 2 -o "$#" -eq 3 ]; then
    EMAIL_FILE=$1
    LOCALBASE=${2:-$DEFAULT_LOCALBASE}
    if [ ! -f "$EMAIL_FILE" ]; then
	statusMessage "EMAIL_FILE is not a regular file: $EMAIL_FILE."
	exit 2
	statusMessage "EMAIL_FILE looks OK!"
    fi
else
    statusMessage "Run as: $0 EMAIL_FILE [OUTPUT_DIRECTORY]"
    exit 2
fi

USER=`awk '/Username: /{print $NF}' "$EMAIL_FILE"`
PASS=`awk '/Password: /{print $NF}' "$EMAIL_FILE"`
REMOTEDIR=`awk '/Your data is under /{print $NF}' "$EMAIL_FILE"`
URL=`awk '/sftp server name: /{print $NF}' "$EMAIL_FILE"`
REPORT=`awk '/See your report at: /{print $NF}' "$EMAIL_FILE"`
echo "USER:----${USER}----"
echo "PASS:----${PASS}----"
echo "REMOTEDIR:----${REMOTEDIR}----"
echo "URL:----${URL}----"
echo "REPORT:----${REPORT}----"

PROTOCOL="sftp"
LOCALDIR="$LOCALBASE/$(basename $REMOTEDIR)"
mkdir -p $LOCALDIR
echo "mirror $REMOTEDIR $LOCALDIR"

if [ ! -e "$LOCALDIR/$(basename $REMOTEDIR).checksum" ]; then
statusMessage "Downloading data from server . . ."
lftp  $PROTOCOL://$URL <<- DOWNLOAD
    user $USER "$PASS"
    mirror $REMOTEDIR $LOCALDIR
DOWNLOAD
fi

WORKDIR=$PWD # need to get back here after the "cd"
statusMessage "Validating downloaded data . . ."
(cd $LOCALBASE && exec md5sum -c $LOCALDIR/$(basename $REMOTEDIR).checksum >&2)
# cd $WORKDIR

statusMessage "Changing permissions on $LOCALDIR. . ."
chmod -R a-w $LOCALDIR
