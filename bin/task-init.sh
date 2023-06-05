set -e
. $MVIM_HOME/bin/functions.sh
PROJECT_MVIM_CONFIG=$VIM_CWD/.mvim.sh
if [[ -f $PROJECT_MVIM_CONFIG ]];then
    . $PROJECT_MVIM_CONFIG
fi

