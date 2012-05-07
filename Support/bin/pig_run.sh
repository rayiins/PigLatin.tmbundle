#!/usr/bin/env bash

source ~/.bash_profile

# Environment Variales needs PIG_HOME
if [ "$PIG_HOME" = "" ]; then
    echo "ERROR: PIG_HOME is not set."
    exit 1
fi

PIG_CMD=$PIG_HOME/bin/pig

case "$1" in  
	"--version" ) {
		$PIG_CMD --version
	};;
	* ) {
		$PIG_CMD $1
	};;
esac