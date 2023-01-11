" vim: ft=vim 
"
" Assumptions:
" * Author field, possibly preceeded only by whitespace, occupies a single line.
" * No author has a name part 'and' preceeded and followed by a space,
"   i.e.   Smith, John and Joe   would cause problems.

"-------------------------------
" reorder names: Smith, John ~~> John Smith

function Reorder()
  normal 0f{ma%r┣`ar┫
  
  s/ and /┣┫/ge
  
  while search('\V, ', 'z', line('.'))
    normal x"sx"gdt┣F┫"gp"sp
  endwhile

  s/┣┫/ and /ge
  normal 0f┫r{f┣r}
endfunction

global/\v^\s*AUTHOR =/ call Reorder()
