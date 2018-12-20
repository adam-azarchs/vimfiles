set nocompatible
filetype off

set shiftwidth=4
set expandtab
set tabstop=4
set ruler

let g:ycm_python_binary_path = 'python'
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set background=dark
colo desert
setlocal spell spelllang=en_us
set nospell
set mousemodel=popup_setpos
filetype plugin on
filetype indent on
filetype plugin indent on
syntax on
set nobackup
set writebackup
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<Enter>']

autocmd FileType html       setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType cc         setlocal shiftwidth=2 tabstop=2
autocmd FileType md         setlocal spell

" Bazel helpers

autocmd BufNewFile,BufRead BUILD,BUILD.bazel,*.bzl,WORKSPACE,WORKSPACE.bazel :setfiletype bzl
autocmd FileType bzl AutoFormatBuffer buildifier
autocmd FileType python AutoFormatBuffer autopep8
