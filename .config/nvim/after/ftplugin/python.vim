setlocal
      \ tabstop=4
      \ textwidth=79
let b:undo_ftplugin .= '| setlocal tabstop< textwidth<'

" Insert pdb breaks
inoremap <C-p> import pdb; pdb.set_trace()
let b:undo_ftplugin .= '| iunmap <C-p>'
inoremap <C-o> import IPython; IPython.embed()
let b:undo_ftplugin .= '| iunmap <C-o>'
