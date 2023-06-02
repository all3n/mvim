. $MVIM_HOME/bin/functions.sh
MY_CONFIG=$HOME/.config/mvim/config.sh
if [[ -f $MY_CONFIG ]];then
    . $MY_CONFIG
fi

export XDG_CONFIG_HOME=$MVIM_HOME/conf
MVIM_DATA_DIR=$HOME/.mvim
mkdir -p $MVIM_DATA_DIR
export XDG_DATA_HOME=$MVIM_DATA_DIR/data
export XDG_STATE_HOME=$MVIM_DATA_DIR/state
export XDG_RUNTIME_HOME=$MVIM_DATA_DIR/runtime
export XDG_CACHE_HOME=$MVIM_DATA_DIR/cache


if [[ ! -d $MVIM_DATA_DIR/venv ]];then
    python3 -m venv $MVIM_DATA_DIR/venv
    . $MVIM_DATA_DIR/venv/bin/activate
    pip install --upgrade pip
    pip install neovim
else
    . $MVIM_DATA_DIR/venv/bin/activate
fi
