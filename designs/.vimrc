syntax on

"" Editor
" Indentation and Lines
set scrolloff=5
set number
set tabstop=2 shiftwidth=2 expandtab

set guifont=Monospace:h18
set background=dark
colorscheme desert

"" Languages
" Xschem file types
au BufRead,BufNewFile *.sym,*.sch set filetype=spice
