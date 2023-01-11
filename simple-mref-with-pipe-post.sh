#!/bin/zsh
DIR=${0:h}

query=$1
[[ -n $query ]] || exit 2

$DIR/simple-mref.sh $query | $DIR/post-process-pipe.sh -
