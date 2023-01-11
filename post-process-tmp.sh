#!/bin/zsh
DIR=${0:h}

f=$1
[[ -n $f ]] || exit 2

function can_execute() { [[ -x $REPLY && ! -d $REPLY ]] }
filters=($DIR/post-processing/*(onN+can_execute))

# exit if there are no (executable) filters present
(( ${#filters} )) || exit 0

tmp1=$(mktemp)
tmp2=$(mktemp)

cat $f > $tmp1

for filter in $filters; do
    $filter $tmp1 > $tmp2
    mv $tmp2 $tmp1
done

cat $tmp1
