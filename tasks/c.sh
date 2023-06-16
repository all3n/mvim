. $MVIM_HOME/bin/task-init.sh

C_ENV=$VIM_FILEDIR/.c_env.sh
if [[ -f $C_ENV ]];then
  . $C_ENV
fi
SCRIPT=$1
CFLAGS=$(cat $SCRIPT | grep '// CFLAGS:' | awk -F: '{print $2}')
LIBS=$(cat $SCRIPT | grep '// LIBS:' | awk -F: '{print $2}')
if [[ -z "$SOURCES" ]];then
  SOURCES=$(cat $SCRIPT | grep '// SOURCES:' | awk -F: '{print $2}')
else
  SOURCES=""
fi
BUILD_RIR=$(cat $SCRIPT | grep '// BUILD_DIR:' | awk -F: '{print $2}')

if [[ -f $TASK_GCC ]];then
    GCC=$TASK_GCC
else
    GCC=$(which gcc)
fi

if [[ -z $ROOT ]];then
  cd $VIM_FILEDIR
fi

if [[ -z $BUILD_RIR ]];then
  TMP_OUTPUT=$(get_temp_file_path)
  DELETE=1
else
  BUILD_DIR=$VIM_FILEDIR/$BUILD_DIR
  mkdir -p $BUILD_RIR
  NAME=$(basename $SCRIPT)
  NAME=${NAME%.*}
  TMP_OUTPUT=$BUILD_RIR/$NAME
  DELETE=0
fi
CMD="$GCC -g $CFLAGS -o $TMP_OUTPUT $@ $SOURCES $LIBS"
echo $CMD
echo "--------------------------------------------------------"
$CMD
ulimit -c unlimited

$TMP_OUTPUT
if [[ $DELETE -eq 1 ]];then
  rm -f $TMP_OUTPUT
fi 
