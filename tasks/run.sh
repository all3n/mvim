. $MVIM_HOME/bin/task-init.sh
export ROOT=$(find_root $VIM_FILEDIR)
cd $ROOT
if [[ -n "$ROOT" ]];then
  echo "ROOT:$ROOT"
fi


export EXEC_LIST=()
exec_dir(){
  find_exec $1
  EXEC_NUM=${#EXEC_LIST[@]}
  if [[ $EXEC_NUM -eq 1 ]];then
    echo "BIN:$EXEC_LIST"
    echo "------------------------------------------------"
    $EXEC_LIST
  else
    for idx in `seq 0 $(( EXEC_NUM -1 ))`;do
      echo "index:$idx  "${EXEC_LIST[$idx]}
    done
    echo "input index:"
    read INDEX
    EXEC=${EXEC_LIST[$INDEX]}
    echo "BIN:$EXEC"
    echo "------------------------------------------------"
    $EXEC
  fi
}


if [[ -f $ROOT/CMakeLists.txt ]];then
  exec_dir $ROOT/build
elif [[ -f $ROOT/Makefile ]] || [[ -f $ROOT/makefile ]];then
  exec_dir $ROOT
else
  EXT=${VIM_FILEPATH##*.}
  if [[ "$EXT" == "cpp" ]] || [[ "$EXP" == "cc" ]];then
    bash cpp.sh $VIM_FILEPATH
  elif [[ "$EXT" == "c" ]];then
    bash c.sh $VIM_FILEPATH
  fi
fi
