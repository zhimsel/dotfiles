" <Tab> will close NERDTree when it's the active window
nnoremap <buffer> <Tab> :NERDTreeClose<CR>

" editorconfig-vim
let b:EditorConfig_disable = 1
let b:undo_ftplugin .= '| unlet b:EditorConfig_disable'
