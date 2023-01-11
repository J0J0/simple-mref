#!/bin/zsh

# Move accents /into/ the curly braces, e.g.:
# 
#   AUTHOR = {M\"{a}x M\"{u}st\'{e}rmann}
# 
# ~~~>
# 
#   AUTHOR = {M{\"a}x M{\"u}st{\'e}rmann}

f=$1
[[ -n $f ]] || exit 2

sed -re 's?\\([`'"'"'"H~ck=b.druvt^])\{?{\\\1?g' -- $f
