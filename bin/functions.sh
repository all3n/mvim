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
    if [[ "$OS" == "MAC" ]];then
        echo "$MAC_NVIM"
    else
        echo "$LINUX_NVIM"
    fi
}
