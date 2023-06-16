. $MVIM_HOME/bin/task-init.sh

SCRIPT=$1

CXXFLAGS=$(cat $SCRIPT | grep '// CXXFLAGS:' | awk -F: '{print $2}')
LIBS=$(cat $SCRIPT | grep '// LIBS:' | awk -F: '{print $2}')

#SOURCES=$(get_sources $SCRIPT)



if [[ -f $TASK_GXX ]];then
    GXX=$TASK_GXX
else
    GXX=$(which g++)
fi

TMP_OUTPUT=$(get_temp_file_path)

CMD="$GXX $CXXFLAGS -o $TMP_OUTPUT $@ $LIBS"
echo $CMD
echo "--------------------------------------------------------"
$CMD
$TMP_OUTPUT
rm $TMP_OUTPUT
