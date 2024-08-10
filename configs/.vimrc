"mouse support"
set mouse=a

"syntax highlight"
syntax on

"line numbers"
set number

"highlight current line"
set cursorline

"highlight search ppattern"
set hlsearch

"smartcase search sensitivity"
set ignorecase
set smartcase

"Spaces indentation"
set tabstop =4
set softtabstop =4
set shiftwidth =4
set textwidth =100
set expandtab
set autoindent

"show matching pairs of braces"
set showmatch

"remove trailing whitespaces from python files"
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.sh :%s/\s\+$//e

"color schemes"
set termguicolors
colorscheme catppuccin_mocha

"search into subfolders"
set path+=**

"show all matching files when tab complete"
set wildmenu

