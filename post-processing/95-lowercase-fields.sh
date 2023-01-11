#!/bin/zsh

# Change field names to lowercase, e.g.:
# 
#   AUTHOR = { ... }
# 
# ~~~>
# 
#   author = { ... }

f=$1
[[ -n $f ]] || exit 2

sed -re 's~^(\s*)([A-Z]+)(\s*\=)~\1\L\2\E\3~' -- $f
