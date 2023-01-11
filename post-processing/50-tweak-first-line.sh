#!/bin/zsh

# Remove empty space between entry type and curly brace (if present);
# add ID prefix for some types. E.g.:
# 
#   @book {MR31415,
# 
# ~~~>
# 
#   @book{b:<++>,

f=$1
[[ -n $f ]] || exit 2

if [[ $f != '-' && $f != '/dev/stdin' ]]; then
    exec < $f
fi

set re_match_pcre

while IFS= read -r line; do
    if [[ $line =~ '^\s*@(\S+)\s*\{\s*([^}]+)\s*,\s*$' ]]; then
        entrytype=$match[1]
        #key=$match[2]  # currently not used
        
        prefix=""
        if [[ $entrytype == "article" ]]; then
            prefix="p:"
        elif [[ $entrytype == "book" ]]; then
            prefix="b:"
        fi

        print "@${entrytype}{${prefix}<++>,"
    else
        print -r $line
    fi
done
