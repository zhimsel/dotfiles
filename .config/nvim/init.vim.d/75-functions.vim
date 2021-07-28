" vim: set foldmethod=marker

" Insert useful 'ThreeFingerClaw' shell functions
function! ThreeFingerClaw() " {{{
  exe "normal! oyell() { echo \"$0: $*\" >&2; }"
  exe "normal! odie() { yell \"$*\"; exit 111; }"
  exe "normal! otry() { \"$@\" || die \"cannot $*\"; }"
endfunction " }}}
command! ThreeFingerClaw call ThreeFingerClaw()

" Show highlight group for what's under the cursor
function! ShowHiCursor() " {{{
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction " }}}
command! ShowHiCursor call ShowHiCursor()

function! Dot() " {{{
  let $GIT_DIR = $HOME . "/.git_dotfiles"
  let $GIT_WORK_TREE = $HOME
endfunction " }}}
command! Dot call Dot()

function! Ldot() " {{{
  let $GIT_DIR = $HOME . "/.git_dotfiles_local"
  let $GIT_WORK_TREE = $HOME
endfunction " }}}
command! Ldot call Ldot()
