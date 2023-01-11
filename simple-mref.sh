#!/bin/zsh

query=$1
[[ -n $query ]] || exit 2
[[ $query == '-' ]] && query="$(cat)"

URL="https://mathscinet.ams.org/mathscinet-mref"

f=$(mktemp)

curl --silent \
    --get \
    --data-urlencode "dataType=bibtex" \
    --data-urlencode "ref=${query}" \
    -o $f \
    $URL

if grep --quiet --fixed-strings "No Unique Match Found" $f; then
    exit 1
else
    awk --field-separator '@' \
        --assign 'q=0' \
        '/<pre>/{q=1; print "@" $2; next}; /<\/pre>/{print "}"; exit}; q' \
        < $f
fi
