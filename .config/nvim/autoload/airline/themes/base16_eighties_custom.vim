" vim-airline template by chartoin (http://github.com/chartoin)
" Base 16 Eighties Scheme by Chris Kempson (http://chriskempson.com)

" Modified to brighten the background for inactive panes.
" When also using the base16_eighties colorscheme, the statusbar blends in with folds
" and it's hard to tell where the pane boundary is.

let g:airline#themes#base16_eighties_custom#palette = {}
let s:gui00 = "#2d2d2d"
let s:gui01 = "#393939"
let s:gui02 = "#515151"
let s:gui03 = "#747369"
let s:gui04 = "#a09f93"
let s:gui05 = "#d3d0c8"
let s:gui06 = "#e8e6df"
let s:gui07 = "#f2f0ec"
let s:gui08 = "#f2777a"
let s:gui09 = "#f99157"
let s:gui0A = "#ffcc66"
let s:gui0B = "#99cc99"
let s:gui0C = "#66cccc"
let s:gui0D = "#6699cc"
let s:gui0E = "#cc99cc"
let s:gui0F = "#d27b53"

let s:cterm00 = 236
let s:cterm01 = 237
let s:cterm02 = 239
let s:cterm03 = 95
let s:cterm04 = 144
let s:cterm05 = 188
let s:cterm06 = 188
let s:cterm07 = 15
let s:cterm08 = 210
let s:cterm09 = 209
let s:cterm0A = 221
let s:cterm0B = 114
let s:cterm0C = 80
let s:cterm0D = 68
let s:cterm0E = 176
let s:cterm0F = 173

let s:N1   = [ s:gui01, s:gui0B, s:cterm01, s:cterm0B ]
let s:N2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:N3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_eighties_custom#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let s:I1   = [ s:gui01, s:gui0D, s:cterm01, s:cterm0D ]
let s:I2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:I3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_eighties_custom#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

let s:R1   = [ s:gui01, s:gui08, s:cterm01, s:cterm08 ]
let s:R2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:R3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_eighties_custom#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

let s:V1   = [ s:gui01, s:gui0E, s:cterm01, s:cterm0E ]
let s:V2   = [ s:gui06, s:gui02, s:cterm06, s:cterm02 ]
let s:V3   = [ s:gui09, s:gui01, s:cterm09, s:cterm01 ]
let g:airline#themes#base16_eighties_custom#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Change background from 01 to 02
let s:IA1   = [ s:gui05, s:gui02, s:cterm05, s:cterm02 ]
let s:IA2   = [ s:gui05, s:gui02, s:cterm05, s:cterm02 ]
let s:IA3   = [ s:gui05, s:gui02, s:cterm05, s:cterm02 ]
let g:airline#themes#base16_eighties_custom#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#base16_eighties_custom#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ s:gui07, s:gui02, s:cterm07, s:cterm02, '' ],
      \ [ s:gui07, s:gui04, s:cterm07, s:cterm04, '' ],
      \ [ s:gui05, s:gui01, s:cterm05, s:cterm01, 'bold' ])
