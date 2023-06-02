. $MVIM_HOME/bin/task-init.sh

SCRIPT=$1
CWD_VENV=$VIM_CWD/venv
if [[ -d $CWD_VENV ]];then
    . $CWD_VENV/bin/activate
fi
if [[ -f $TASK_PYTHON ]];then
    PYTHON=$TASK_PYTHON
else
    PYTHON=$(which python)
fi

echo "PYTHON: $PYTHON"

$PYTHON $@
