set nocompatible              " required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" All Plugins

Plugin 'morhetz/gruvbox'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'dense-analysis/ale'
Plugin 'nvie/vim-flake8'
Plugin 'zxqfl/tabnine-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'aquach/vim-http-client'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'


call vundle#end()            " required
filetype plugin indent on    " required

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

let g:ycm_autoclose_preview_window_after_completion=1

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
\       'python': ['black', 'isort'],
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
