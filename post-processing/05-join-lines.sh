#!/bin/zsh

# join lines, so that all fields occupy a single line, e.g.:
# 
#   TITLE = {very long title
#           that originally spans
#           multiple lines}
# 
# ~~~>
# 
#   TITLE = {very long title that originally spans multiple lines}

f=$1
[[ -n $f ]] || exit 2

[[ $f == '-' ]] && f="/dev/stdin"

cmds=\
'set nojoinspaces | '\
'global /\v^\s*[A-Z]+/ normal f{ma%mb'":'a,'b join"

vim -i NONE -Nnes -c $cmds -c 'wq! /dev/stdout' -- $f

# -i NONE
#   don't use .viminfo
#
# -N
#   no compatibility mode
#   
# -n
#   no swap file
#   
# -e
#   start in Ex mode
#   
# -s
#   silent
#   
# -c CMD
#   execute CMD after file has been read;
#   careful: --cmd is something else!
