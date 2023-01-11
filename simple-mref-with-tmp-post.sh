#!/bin/zsh
DIR=${0:h}

query=$1
[[ -n $query ]] || exit 2

tmp=$(mktemp)

$DIR/simple-mref.sh $query > $tmp

if [[ -s $tmp ]]; then
    # $tmp file not empty
    $DIR/post-process-tmp.sh $tmp
else
    print -u 2 "No MRef found."
    exit 1
fi
