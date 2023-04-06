setlocal
      \ spell
      \ commentstring=\%%s
      \ colorcolumn=+1,51
      \ textwidth=72
let b:undo_ftplugin .= '| setlocal spell< commentstring< colorcolumn< textwidth<'
