#!/bin/zsh

# Treat some fields as "second class" and group them after
# the others, e.g.:
# 
#   AUTHOR = { ... }
#     ISBN = { ... }
#    TITLE = { ... }
# 
# ~~~>
# 
#   AUTHOR = { ... }
#    TITLE = { ... }
#         %
#     ISBN = { ... }

f=$1
[[ -n $f ]] || exit 2

if [[ $f != '-' && $f != '/dev/stdin' ]]; then
    exec < $f
fi

set re_match_pcre

second_class_fields=(ISBN DOI URL)  # ordering determines output
second_class_fields_book=(PAGES SERIES VOLUME)

filter_fields=()
declare -A found_fields

while IFS= read -r line; do
    # watch for entry start
    if [[ $line =~ '^\s*@(\S+)\s*\{' ]]; then
        entrytype=$match[1]
        
        filter_fields=($second_class_fields)
        if [[ $entrytype == "book" ]]; then
            filter_fields+=($second_class_fields_book)
        fi
        
        found_fields=()
    # … or for fields
    elif [[ $line =~ '^\s*(\S+)\s*=' ]]; then
        fieldname=$match[1]
        
        if (( $filter_fields[(Ie)$fieldname] )); then
            found_fields[${fieldname}]=$line
            continue
        fi
    # … or for entry end
    elif [[ $line =~ '^\s*\}' ]]; then
        if (( $#found_fields )); then
            any_filtered_field=$found_fields[${${(@k)found_fields}[1]}]
            printf '%*s\n' ${#${any_filtered_field%%=*}} '%'
            
            for fn in $filter_fields; do
                if [[ $found_fields[$fn] != "" ]]; then
                    print -r $found_fields[$fn]
                fi
            done
        fi
    fi
    
    print -r $line
done
