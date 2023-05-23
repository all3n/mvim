: ${NVIM_BIN:=}
LINUX_NVIM=$NVIM_HOME/bin/nvim83
MAC_NVIM=nvim


function get_os(){
    if [[ "$(uname)" == "Darwin" ]];then
        echo "MAC"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]];then
        echo "LINUX"
    fi
}

function get_nvim(){
    local OS=$(get_os)
    if [[ -n "${NVIM_BIN}" ]];then
        echo "$NVIM_BIN"
    elif [[ "$OS" == "MAC" ]];then
        echo "$MAC_NVIM"
    else
        echo "$LINUX_NVIM"
    fi
}
