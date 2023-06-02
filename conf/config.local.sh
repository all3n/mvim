#! /bin/sh

export NVIM_BIN=~/opt/nvim-linux64/bin/nvim
export JAVA_HOME=/opt/jdk-17

export JDTLS_HOME=/opt/jdtls
export JDTLS_JVM_ARGS="-javaagent:$JDTLS_HOME/lombok.jar"
export JDTLS_CONF=/opt/jdtls/config_linux/

export PATH=$JAVA_HOME/bin:$JDTLS_HOME/bin:$PATH
