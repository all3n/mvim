. $MVIM_HOME/bin/task-init.sh

SCRIPT=$1
cat $SCRIPT | grep '//'

if [[ -f $TASK_GCC ]];then
    GCC=$TASK_GCC
else
    GCC=$(which gcc)
fi

TMP_OUTPUT=$(get_temp_file_path)
echo "gcc:$GCC bin:$TMP_OUTPUT"

$GCC -o $TMP_OUTPUT $@
$TMP_OUTPUT
rm -f $TMP_OUTPUT
