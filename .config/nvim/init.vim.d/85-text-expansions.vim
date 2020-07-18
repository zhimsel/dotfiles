" Insert a standard shebang
iabbrev ube# #!/usr/bin/env

" Automatically close brackets and quotes {{{

inoremap ""       ""<Left>
inoremap """<CR>  """<CR>"""<Esc>O
inoremap ''       ''<Left>
inoremap ```<CR>  ```<CR>```<Esc>O

inoremap ()       ()
inoremap ())      ()<Left>
inoremap ())<CR>  (<CR>)<Esc>O

inoremap <>       <>
inoremap <>>      <><Left>

inoremap []       []
inoremap []]      []<Left>
inoremap []]<CR>  [<CR>]<Esc>O

inoremap {}       {}
inoremap {}}      {}<Left>
inoremap {}}<CR>  {<CR>}<Esc>O

" }}}
