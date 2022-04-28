set nocompatible              " required
filetype off                  " required

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" All Plugins

Plug 'zxqfl/tabnine-vim'
Plug 'tabnine/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/indentpython.vim'
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'zxqfl/tabnine-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'davidhalter/jedi-vim'
Plug 'aquach/vim-http-client'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'


call plug#end()            " required
filetype plugin indent on    " required

let g:jedi#force_py_version = 39
" setting horizontal and vertical splits
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Setting up indendation

au BufNewFile, BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile, BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

" setting up pyflakes

let python_highlight_all=1
syntax on

" setting up line numbering
set nu

" Gruvbox settings
colorscheme gruvbox
set bg=dark

" Ale settings
let g:ale_fixers = {
\       '*': ['remove_trailing_lines', 'trim_whitespace'],
\       'python': ['black'],
\}
nnoremap <Leader>F :ALEFix<CR>

" jedi-vim setting
autocmd FileType python setlocal completeopt-=preview
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = "<leader>]"
let g:jedi#documentation_command = "<leader>K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" Colin's special adds
nnoremap <Leader>f :edit <c-r>=expand("%:h")<cr>/<CR>
nnoremap <Space><Space> :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap J <PageDown>
nnoremap K <PageUp>
nnoremap <Leader>t :exec &nu==&rnu? "se nu!" : "se rnu!"<CR> 
nnoremap <Leader>R :YcmRestartServer<CR>
:au BufReadPost * exe "norm! g`\""
let g:netrw_banner = 0

" Improve file creation handling
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <leader>T :ZoomToggle<CR>
