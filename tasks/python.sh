. $MVIM_HOME/bin/task-init.sh

SCRIPT=$1
CWD_VENV=$VIM_CWD/venv
if [[ -d $CWD_VENV ]];then
    echo "activate venv $CWD_VENV"
    . $CWD_VENV/bin/activate
    TASK_PYTHON=$(which python)
fi
if [[ -f $TASK_PYTHON ]];then
    PYTHON=$TASK_PYTHON
else
    PYTHON=$(which python)
fi

echo "PYTHON: $PYTHON"

$PYTHON $@
