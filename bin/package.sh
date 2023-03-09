#!/usr/bin/env bash
TYPE=$1
BIN=$(dirname $0)
APP_DIR=$(cd $BIN/..;pwd)
OUT_DIR=$(cd $BIN/../..;pwd)
NAME=$(basename $APP_DIR)
cd $OUT_DIR
if [[ "$TYPE" == "clean" ]];then
  tar -czvf $NAME-linux-clean.tar.gz --exclude=$NAME/data --exclude $NAME/cache --exclude $NAME/state --exclude $NAME/venv --exclude .setup $NAME
else
  tar -czvf $NAME-linux.tar.gz --exclude .setup $NAME
fi
cd $APP_DIR
