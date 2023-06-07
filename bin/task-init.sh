set -e
. $MVIM_HOME/bin/functions.sh
PROJECT_MVIM_CONFIG=$VIM_CWD/.mvim.sh
if [[ -f $PROJECT_MVIM_CONFIG ]];then
    . $PROJECT_MVIM_CONFIG
fi
if [[ -n $ROOT ]];then
  ROOT_MVIM=$ROOT/.mvim/init.sh
  if [[ -f $ROOT_MVIM ]];then
    . $ROOT_MVIM
  fi
fi

