" RHS of keybinds are provided by auto-git-diff plugin:
" https://github.com/hotwatermorning/auto-git-diff

" movement
noremap <buffer> J j
noremap <buffer> K k
let b:undo_ftplugin .= '| unmap <buffer> J'
let b:undo_ftplugin .= '| unmap <buffer> K '
map <buffer> <C-e> <Plug>(auto_git_diff_scroll_down_1)
map <buffer> <C-d> <Plug>(auto_git_diff_scroll_down_half)
map <buffer> <C-y> <Plug>(auto_git_diff_scroll_up_1)
map <buffer> <C-u> <Plug>(auto_git_diff_scroll_up_half)
let b:undo_ftplugin .= '| unmap <buffer> <C-e> '
let b:undo_ftplugin .= '| unmap <buffer> <C-d> '
let b:undo_ftplugin .= '| unmap <buffer> <C-y> '
let b:undo_ftplugin .= '| unmap <buffer> <C-u> '

" commit actions
map <buffer> <leader>p :Pick<CR>
map <buffer> <leader>r :Reword<CR>
map <buffer> <leader>e :Edit<CR>
map <buffer> <leader>s :Squash<CR>
map <buffer> <leader>f :Fixup<CR>
map <buffer> <leader>d :Drop<CR>
let b:undo_ftplugin .= '| unmap <buffer> <leader>p '
let b:undo_ftplugin .= '| unmap <buffer> <leader>r '
let b:undo_ftplugin .= '| unmap <buffer> <leader>e '
let b:undo_ftplugin .= '| unmap <buffer> <leader>s '
let b:undo_ftplugin .= '| unmap <buffer> <leader>f '
let b:undo_ftplugin .= '| unmap <buffer> <leader>d '
