setlocal
      \ spell
      \ commentstring=\%%s
      \ colorcolumn=+1,51
      \ textwidth=72
      \ bufhidden=delete
let b:undo_ftplugin .= '| setlocal spell< commentstring< colorcolumn< textwidth<'

" editorconfig-vim
let b:EditorConfig_disable = 1
let b:undo_ftplugin .= '| unlet b:EditorConfig_disable'
