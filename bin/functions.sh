: ${NVIM_BIN:=}

function get_os(){
    if [[ "$(uname)" == "Darwin" ]];then
        echo "MAC"
    elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]];then
        echo "LINUX"
    fi
}

function get_nvim(){
    echo "$NVIM_BIN"
 }

function get_real_path() {
  local path="$1"
  local dir="$(dirname "$path")"
  local name="$(basename "$path")"
  local real_path=""
  cd "$dir" || return 1
  while [ -L "$name" ]; do
    name="$(readlink "$name")"
    cd "$(dirname "$name")" || return 1
    real_path="$(pwd -P)/$(basename "$name")"
    name="$(basename "$real_path")"
  done
  real_path="$(pwd -P)/$name"
  echo "$real_path"
}

function setup_venv(){
    echo 1

}
