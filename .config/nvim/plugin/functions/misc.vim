" Insert useful 'ThreeFingerClaw' shell functions
function! ThreeFingerClaw()
  exe "normal! oyell() { echo \"$0: $*\" >&2; }"
  exe "normal! odie() { yell \"$*\"; exit 111; }"
  exe "normal! otry() { \"$@\" || die \"cannot $*\"; }"
endfunction
command! ThreeFingerClaw call ThreeFingerClaw()

" Show highlight group for what's under the cursor
function! ShowHiCursor()
  echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
command! ShowHiCursor call ShowHiCursor()

function! JQFormat()
  exe "%!jq ."
endfunction
command! JQFormat call JQFormat()

function! Nodot()
  unlet $GIT_DIR
  unlet $GIT_WORK_TREE
endfunction
command! Nodot call Nodot()

function! Dot()
  let $GIT_DIR = $HOME . "/.git_dotfiles"
  let $GIT_WORK_TREE = $HOME
endfunction
command! Dot call Dot()

function! Ldot()
  let $GIT_DIR = $HOME . "/.git_dotfiles_local"
  let $GIT_WORK_TREE = $HOME
endfunction
command! Ldot call Ldot()

function! Tig()
  split term://tig
endfunction
command! Tig call Tig()

function! Tigf()
  split term://tig %
endfunction
command! Tigf call Tigf()

function! Tigs()
  split term://tig status
endfunction
command! Tigs call Tigs()

function! Tiga()
  split term://tig --all
endfunction
command! Tiga call Tiga()
