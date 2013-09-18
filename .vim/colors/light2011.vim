"Vim color file
"Maintainer: xiaohuyee <xiaohuyee@gmail.com>
"Last Change: Aug, 27, 2011
"Version: 1.0


set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "light2011"


hi Normal guibg=#F0FBEB  guifg=#008080
hi Comment gui=none guifg=#999999
hi Keyword gui=none guifg=#2E8B70
hi Identifier gui=none guifg=#2E8B70
hi LineNr gui=bold guifg=#008080 guibg=#E8F5FE 
hi CursorLine guibg=#E5E5E5

set laststatus=2
set statusline=
set statusline+=%1*\ %n%r%h%w\ %F%M\ 
set statusline+=%2*\ format:%{&ff}:%{&fenc!=''?&fenc:&enc}\ 
set statusline+=%3*\ type:%Y\ 
set statusline+=%4*\ rows:%03l/%L(%p%%)
set statusline+=\ \ \ \ \ \ \ \ 
set statusline+=%5*
set statusline+=\ \ \ \ \ \ \ \ 
set statusline+=%{strftime(\"date:%Y-%m-%d\ %H:%M\")}\ 
set statusline+=%6*\ blank\ 
set statusline+=%7*\ blank\ 
set statusline+=%8*\ blank\ 
set statusline+=%9*\ blank\ 
set statusline+=%0*\ blank\ 
"highlight StatusLine guifg=White guibg=#008080
"highlight StatusLineNC guifg=White guibg=#0050f5
"highlight StatusLineNC guifg=White guibg=#606060
"
hi User1 guifg=#ffdad8  guibg=#880c0e
hi User2 guifg=#391100  guibg=#d3905c
hi User3 guifg=#292b00  guibg=#f4f597
hi User4 guifg=#112605  guibg=#aefe7B
hi User5 guifg=#051d00  guibg=#7dcc7d
hi User6 guifg=#002600  guibg=#67ab6e
hi User7 guifg=#00231a  guibg=#66ad9f
hi User8 guifg=#66ad9f  guibg=#5b7fbb
hi User9 guifg=#ffffff  guibg=#810085
hi User0 guifg=#ffffff  guibg=#094afe
