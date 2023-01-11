#!/bin/zsh

# Drop some fields completly, e.g.:
# 
#   TITLE = { ... }
#   ISSN = { ... }
#   AUTHOR = { ... }
# 
# ~~~>
# 
#   TITLE = { ... }
#   AUTHOR = { ... }

blacklist=(
    ISSN
    MRCLASS
    MRNUMBER
    MRREVIEWER
)

f=$1
[[ -n $f ]] || exit 2

cat -- $f | grep --fixed-strings --invert-match ${(F)blacklist}
