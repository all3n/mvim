BIN=$(dirname $0)
APP_DIR=$(cd $BIN/..;pwd)
APP_ENV=$APP_DIR/venv
if [[ ! -d $APP_ENV ]];then
  python3 -m venv $APP_ENV
  . $APP_ENV/bin/activate
  pip install --upgrade pip
  pip install neovim
fi

fix_glibc(){
    $APP_DIR/bin/fix-glibc $1
}

fix_glibc $APP_DIR/data/nvim/mason/packages/clangd/clangd/bin/clangd
fix_glibc $APP_DIR/data/nvim/mason/packages/lua-language-server/extension/server/bin/lua-language-server



SHELL_TYPE=$(basename $SHELL)
SHELL_RC=$HOME/.bashrc
if [[ "$SHELL_TYPE" == "zsh" ]];then
  SHELL_RC=$HOME/.zshrc
fi

cat $SHELL_RC|grep $APP_DIR 2>/dev/null
if [[ $? -ne 0 ]];then
  echo "export MVIM_HOME=$APP_DIR" >> $SHELL_RC
  echo "export PATH=\$MVIM_HOME/bin:\$PATH" >> $SHELL_RC
fi
