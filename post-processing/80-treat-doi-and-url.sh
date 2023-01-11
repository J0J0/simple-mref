#!/bin/zsh

# If URL is just "https://doi.org/<DOI>", remove URL field, e.g.:
# 
#   DOI = {x.y.42}
#   URL = {https://doi.org/x.y.42}
# 
# ~~~>
# 
#   DOI = {x.y.42}

f=$1
[[ -n $f ]] || exit 2

gawk -f "${0:h}/treat-doi-and-url.awk" -- $f
