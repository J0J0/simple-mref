#!/bin/zsh
DIR=${0:h}

f=$1
[[ -n $f ]] || exit 2

function can_execute() { [[ -x $REPLY && ! -d $REPLY ]] }
filters=($DIR/post-processing/*(onN+can_execute))

# exit if there are no (executable) filters present
(( ${#filters} )) || exit 0

# quote filters
filters_q=(${(q)filters})

# append - to each filter
filters_qd=(${^filters_q}\ -)

# construct full pipeline
pipeline="cat ${(q)f} | ${(j: | :)filters_qd}"

eval $pipeline
