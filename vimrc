set nocompatible
set bs=2
filetype off

set shiftwidth=4
set expandtab
set tabstop=4
set ruler
set guifont=Go\ Mono:h12
set encoding=utf-8

let g:ycm_python_binary_path = 'python'
" Reopen files in history at the last open line.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set background=dark
colo desert
setlocal spell spelllang=en_us
set nospell
set mousemodel=popup_setpos
autocmd BufNewFile,BufRead BUILD.bazel :setfiletype bzl
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

autocmd FileType c,cc,cpp,go,md,proto,html,javascript setlocal fileencoding=utf-8
autocmd BufNewFile,BufRead BUILD,*.bazel,*.bzl,WORKSPACE :setfiletype bzl

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType BUILD,BUILD.bazel,WORKSPACE,WORKSPACE.bazel AutoFormatBuffer buildifier
  "  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  " autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  " autocmd FileType gn AutoFormatBuffer gn
  " autocmd FileType html,css,json AutoFormatBuffer js-beautify
  " autocmd FileType java AutoFormatBuffer google-java-format
  " autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType python AutoFormatBuffer autopep8
augroup END

" Workaround for https://github.com/google/vim-maktaba/issues/215
packloadall
call maktaba#syscall#SetUsableShellRegex('\v^/bin/sh|cmd|cmd\.exe|powershell|powershell\.exe|command\.com$')
