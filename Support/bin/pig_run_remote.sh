#!/usr/bin/env bash

case "$1" in  
	"--version" ) {
		ssh $CLI_OPTIONS $REMOTE_USER@$REMOTE_HOST "source ~/.bash_profile;pig --version"
	};;
	* ) {
		scp $CLI_OPTIONS $1 $REMOTE_USER@$REMOTE_HOST:/tmp/source.pig
		ssh $CLI_OPTIONS $REMOTE_USER@$REMOTE_HOST "source ~/.bash_profile;pig /tmp/source.pig"
		ssh $CLI_OPTIONS $REMOTE_USER@$REMOTE_HOST "rm /tmp/source.pig"
	};;
esac