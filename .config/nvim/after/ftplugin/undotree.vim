nnoremap <buffer> <leader>u :UndotreeHide<CR>

" editorconfig-vim
let b:EditorConfig_disable = 1
let b:undo_ftplugin .= '| unlet b:EditorConfig_disable'
