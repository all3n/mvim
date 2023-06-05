. $MVIM_HOME/bin/task-init.sh

SCRIPT=$1

if [[ -f $TASK_GXX ]];then
    GXX=$TASK_GXX
else
    GXX=$(which g++)
fi

TMP_OUTPUT=$(get_temp_file_path)
echo "g++:$GXX"
echo "bin:$TMP_OUTPUT"

$GXX -o $TMP_OUTPUT $@
$TMP_OUTPUT
rm $TMP_OUTPUT
