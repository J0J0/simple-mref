#!/bin/zsh

query=$1
[[ -n $query ]] || exit 2
[[ $query == '-' ]] && query="$(cat)"

isbn="$(print -r $query | tr --delete --complement '0-9')"

curl --silent "https://openlibrary.org/api/books?bibkeys=ISBN:${isbn}&jscmd=data&format=json" \
    | jq --raw-output --join-output \
      '.[]|( if has("by_statement") then .by_statement else .authors|map(.name)|join(", ") end
           , ". "
           , .title
           , ". "
           , .publishers[0].name
           , ". "
           , .publish_date
           , "\n"
           )'
