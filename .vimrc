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
autocmd Filetype yaml setlocal softtabstop=2 shiftwidth=2

