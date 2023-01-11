#!/bin/zsh

# Remove dot after initials, e.g.:
# 
#   AUTHOR = {Max M. Mustermann}
# 
# ~~~> 
# 
#   AUTHOR = {Max M Mustermann}

f=$1
[[ -n $f ]] || exit 2

sed -re '/^\s*AUTHOR =/ s~([[:upper:]])\. ~\1 ~g' -- $f
