syntax enable
set number relativenumber
set nu rnu

set mouse=

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

Plug 'folke/tokyonight.nvim'
Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'github/copilot.vim'

call plug#end()

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

au BufNewFile, BufRead *.js, *.html, *.css, *.tsx, *.ts
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

autocmd BufNewFile,BufRead *.rs set filetype=rust

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=2 shiftwidth=2 softtabstop=2

let python_highlight_all=1

colorscheme tokyonight-night

" Ale settings
let g:ale_linters = { "python": ["ruff"], "rust": ["analyzer"], 'typescript': ['tsserver'], 'typescriptreact': ['tsserver'], }
let g:ale_fixers = {
\       "*": ["remove_trailing_lines", "trim_whitespace"],
\       "python": ["ruff"],
\       "rust": ["rustfmt"],
\       "typescript": ["prettier", "eslint"],
\}
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_typecript_tsserver_use_global_binary = 1

nnoremap <Leader>D :ALEGoToDefinition<CR>
nnoremap <Leader>C :ClangFormat<CR>
nnoremap <Leader>S :Copilot setup<CR>

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

" Typescript settings
autocmd FileType typescript,typescriptreact setlocal completeopt-=preview
let g:ale#goto_definition_command = "<leader>d"
nmap <leader>d <Plug>(ale_go_to_definition)
let g:ale#goto_assignments_command = "<leader>g"
nmap <leader>g <Plug>(ale_go_to_type_definition)
let g:ale#documentation_command = "<leader>K"
nmap <leader>K <Plug>(ale_hover)
let g:ale#usages_command = "<leader>n"
nmap <leader>n <Plug>(ale_find_references)
let g:ale#rename_command = "<leader>r"
nmap <leader>r <Plug>(ale_rename)

" Colin"s special adds
nnoremap <Leader>f :edit <c-r>=expand("%:h")<cr>/<CR>
nnoremap <Space><Space> :%s/\<<C-r>=expand("<cword>")<CR>\>/
nnoremap J <PageDown>
nnoremap K <PageUp>
let g:netrw_banner = 0

" Improve file creation handling
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
