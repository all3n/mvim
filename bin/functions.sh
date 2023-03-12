LINUX_NVIM=$NVIM_HOME/bin/nvim83
MAC_NVIM=nvim


function get_os(){
    if [[ "$(uname)"=="Darwin" ]];then
        echo "MAC"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]];then   
        echo "LINUX"
    fi
}

OS=$(get_os)
function get_nvim(){
    if [[ "$OS" == "MAC" ]];then
        echo "$MAC_NVIM"
    else
        echo "$LINUX_NVIM"
    fi
}
