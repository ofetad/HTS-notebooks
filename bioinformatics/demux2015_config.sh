set -u

# Input
export CURDATA="/data/HTS_2015_data/runs_combined"

# Output
export CUROUT=$HOME/work/scratch/demux_2015
export DEMUX=$CUROUT/demux_fastqs



# Hack to handle "gzip: stdout: Broken pipe" error message
cleanup () { 
    :
}

trap "cleanup" SIGPIPE