# Must be loaded after FZF completions and keybindings are sourced

# Only set these if fzf is actually loaded
if which __fzfcmd >/dev/null; then

  # Use tmux panes, if not already explicitly disabled {{{
  export FZF_TMUX="${FZF_TMUX:-1}"
  export FZF_TMUX_HEIGHT='60%'
  # }}}

  # Set default options {{{
  export FZF_DEFAULT_OPTS='-m --height=40% --reverse -0 -1 --ansi'
  export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"  # enable file preview
  export FZF_CTRL_R_OPTS="--sort --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"  # press ? to show truncated results
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"  # show folder preview
  # }}}

  # Create "git-files" widget and binding {{{
  fzf-git-file-widget() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
      FZF_CTRL_T_COMMAND='git ls-files' fzf-file-widget
    fi
  }
  zle -N fzf-git-file-widget
  bindkey '^G' fzf-git-file-widget
  # }}}

  # Use tab-tab to use fzf for all arg completions {{{
  export FZF_COMPLETION_TRIGGER=''  # turn off '**' completion
  bindkey '^I' expand-or-complete  # default zsh completion
  bindkey '^I^I' fzf_completion  # completion piped through fzf
  # }}}

  # Set fzf-tab-completion options {{{
  zstyle ':completion:*' fzf-search-display true  # search display-strings by default
  # }}}

fi
