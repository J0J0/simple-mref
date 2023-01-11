#!/bin/zsh

# Don't "protect" capitals, mostly in the TITLE field, e.g.:
# 
#   TITLE = {Paper about {A}bstract {S}tuff}
# 
# ~~~>
# 
#   TITLE = {Paper about Abstract Stuff}

f=$1
[[ -n $f ]] || exit 2

sed -re 's~([{ ])\{([[:upper:]])\}([[:lower:]])~\1\2\3~g' -- $f
