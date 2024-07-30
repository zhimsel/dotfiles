setlocal noexpandtab
let b:undo_ftplugin .= '| setlocal expandtab<'

iabbrev iferr if err != nil }
let b:undo_ftplugin .= '| iunabbrev iferr'
