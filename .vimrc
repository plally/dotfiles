set tabstop=4
set softtabstop=4
set expandtab
set number
set showcmd
set autoindent
set shiftwidth=4

filetype indent on

autocmd Filetype go setlocal noexpandtab                  " tabs instead of spaces
autocmd Filetype ruby setlocal softtabstop=2 shiftwidth=2 " 2 space tabs

syntax enable
colorscheme monokai

" vim-airlien config
let g:airline_powerline_fonts = 1

" vim-signify config
set updatetime=100

" ycm config
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_enable_diagnostic_highlighting = 0
let g:enable_ycm_at_startup = 0
syntax enable
