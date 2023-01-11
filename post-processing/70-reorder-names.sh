#!/bin/zsh

# Change the naming scheme from "family, given" to "given family", e.g:
# 
#   AUTHOR = {Mustermann, Max}
#
# ~~~>
# 
#   AUTHOR = {Max Mustermann}

f=$1
[[ -n $f ]] || exit 2

[[ $f == '-' ]] && f="/dev/stdin"

cmds=\
"source ${0:h}/reorder-names.ex"

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
