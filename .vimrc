set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set confirm
set nocompatible
set ruler

set number
set relativenumber

set hlsearch
set wildmenu
set backspace=indent,eol,start
set hidden
set path+=**

filetype plugin indent on
syntax on

let g:netrw_banner = 0
let g:netrw_liststyle = 3

let mapleader=","
nnoremap <leader>e :Lex<CR>:vertical resize 30<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>v :e ~/.vimrc<CR>
nnoremap <leader>V :so %<CR>
nnoremap <leader>j i<CR><Esc>p<Esc>

" Quickfix
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>co :copen<CR>
nnoremap <leader>, :cprev<CR>
nnoremap <leader>. :cnext<CR>

nnoremap <C-u> <C-u> zz
nnoremap <C-d> <C-d> zz
vnoremap <leader>w :call WrapWith()<CR>
vnoremap <leader>/ y/<C-R>"<CR>
vnoremap <leader>z <
vnoremap <leader>x >

nnoremap <leader>Z i<
nnoremap <leader>X i>
nnoremap <leader>z a<
nnoremap <leader>x a>
noremap <leader>zz < 
noremap <leader>xx > 

call plug#begin()

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'

call plug#end()

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> <leader>i <plug>(lsp-document-format)
    nmap <buffer> <leader>a <plug>(lsp-code-action)
endfunction

function! WrapWith() 
    let character = input('Insert character: ')
    execute "normal! gv c".character.character."\<Esc>P"
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
