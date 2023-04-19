return {

  -- better themes
  {
    -- https://github.com/RRethy/nvim-base16
    'RRethy/nvim-base16',
    lazy = false, -- this should be loaded at startup
    priority = 999, -- and it should be loaded FIRST
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('base16-eighties')
    end,
  },

  -- better statusbar
  {
    -- https://github.com/vim-airline/vim-airline
    'vim-airline/vim-airline',
    lazy = false,
    priority = 888, -- load after main theme
    init = function()
      vim.g['airline_theme'] = "base16_eighties_custom" -- defined in autoload/airline/themes/
    end,
    dependencies = {
      'tpope/vim-fugitive'
    },
    config = function()
      -- TODO: rewrite this in Lua
      vim.cmd([[
        let g:airline_powerline_fonts = 1
        let g:airline_inactive_collapse = 0

        let g:airline#extensions#branch#format = 2 " truncate git branch paths

        let g:airline#extensions#default#section_truncate_width = {}

        let g:airline#extensions#hunks#non_zero_only = 1

        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#formatter = "unique_tail_improved"
        let g:airline#extensions#tabline#show_buffers = 1
        let g:airline#extensions#tabline#show_tab_nr = 1 " show tab numbers
        let g:airline#extensions#tabline#tab_nr_type = 1 " show only tab number

        let g:airline#extensions#whitespace#enabled = 1

        let g:airline#extensions#wordcount#enabled = 0

        let g:airline_mode_map = {
              \ '__'     : '-',
              \ 'c'      : 'C',
              \ 'i'      : 'I',
              \ 'ic'     : 'I',
              \ 'ix'     : 'I',
              \ 'n'      : 'N',
              \ 'multi'  : 'M',
              \ 'ni'     : 'N',
              \ 'no'     : 'N',
              \ 'R'      : 'R',
              \ 'Rv'     : 'R',
              \ 's'      : 'S',
              \ 'S'      : 'SL',
              \ ''     : 'SB',
              \ 't'      : 'T',
              \ 'v'      : 'V',
              \ 'V'      : 'VL',
              \ ''     : 'VB',
              \ }

        let g:airline_filetype_overrides = {
              \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
              \ 'gundo': [ 'Gundo', '' ],
              \ 'help':  [ 'Help', '%f' ],
              \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
              \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
              \ 'startify': [ 'startify', '' ],
              \ 'vim-plug': [ 'Plugins', '' ],
              \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
              \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
              \ }

        if !exists('g:airline_symbols')
          let g:airline_symbols = {}
        endif
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.dirty=''
        let g:airline_symbols.notexists=''
        let g:airline_symbols.readonly = ' '

        function! AirlineSectionInit()
          let g:airline_section_b = airline#section#create(['windowswap', 'file', 'readonly'])
          let g:airline_section_c = airline#section#create(['filetype'])
          let g:airline_section_x = airline#section#create(['%3p%%'])
          let g:airline_section_y = airline#section#create(['hunks'])
          let g:airline_section_z = airline#section#create(['branch'])
        endfunction

        autocmd User AirlineAfterInit call AirlineSectionInit()
      ]])
    end
  },

  -- automatically highlight color codes with their color
  -- https://github.com/chrisbra/Colorizer
  {
    'chrisbra/Colorizer',
    event = "VeryLazy",
  },

  -- visual marker for indent level
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
    }
  },

}
