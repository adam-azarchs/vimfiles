set nocompatible
set bs=2

set shiftwidth=4
set expandtab
set tabstop=4
set ruler
set guifont=Go\ Mono:h12

let g:ycm_python_binary_path = 'python'
set background=dark
colo darkblue
setlocal spell spelllang=en_us
set nospell
syntax enable
set mousemodel=popup_setpos
filetype plugin on
filetype plugin indent on
filetype indent on
set nobackup
set writebackup
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>', '<Enter>']

autocmd FileType html       setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType cc         setlocal shiftwidth=2 tabstop=2
autocmd FileType md         setlocal spell

autocmd FileType c,cc,cpp,go,md,proto,html,javascript setlocal fileencoding=utf-8

augroup autoformat_settings
  " autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  " autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  " autocmd FileType html,css,json AutoFormatBuffer js-beautify
  " autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer yapf
  autocmd FileType python AutoFormatBuffer autopep8
augroup END

" Workaround for https://github.com/google/vim-maktaba/issues/215
packloadall
call maktaba#syscall#SetUsableShellRegex('\v^/bin/sh|cmd|cmd\.exe|powershell|powershell\.exe|command\.com$')
