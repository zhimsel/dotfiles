setlocal noexpandtab
let b:undo_ftplugin .= '| setlocal expandtab<'

" Use Omni completion for Golang
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

iabbrev iferr if err != nil }
let b:undo_ftplugin .= '| iunabbrev iferr'
