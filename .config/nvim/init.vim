" Plugins
" =======
call plug#begin('~/.config/nvim/plugged')

" Themes
Plug 'whatyouhide/vim-gotham'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Editing Enhancements
Plug 'junegunn/vim-easy-align'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Autocompletion / Snippets
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'tpope/vim-endwise'

" File Utilites
Plug 'kien/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" Interface / Language Support
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'peitalin/vim-jsx-typescript'
Plug 'heartsentwined/vim-emblem'
Plug 'chrisbra/csv.vim'
Plug 'elorest/vim-slang'

" Testing / Syntax Checking
Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'
Plug 'christoomey/vim-tmux-runner'
Plug 'kassio/neoterm'

" Fun
Plug 'wakatime/vim-wakatime'

call plug#end()

" Colorscheme
" ===========
colorscheme gotham
set background=dark

hi IndentGuidesOdd ctermbg=12
hi IndentGuidesEven ctermbg=0

" Custom syntax by file type
" ==========================
au BufNewFile,BufRead *.em set filetype=slim

" Enable autocomplete
" ===================
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

let g:deoplete#enable_at_startup = 1

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" airline
" =======
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" EasyAlign
" =========
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Expand Region
" =============
map { <Plug>(expand_region_expand)
map } <Plug>(expand_region_shrink)

" Ctrl-P
" ======
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files --cached --exclude-standard --others'],
    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }

" Fix tab key behavior
" ====================
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Leader
" ======
nmap <leader>n :NERDTreeToggle<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Ag shortcut
nmap <leader>a :Ag<space>

"
nmap <leader>r :CtrlPClearCache<CR>

" Adjust viewports to the same size
map <leader>= <C-w>=

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" format entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" create vertical split and switch to it
nmap <leader>vsp <C-w>v<C-w>l

" modify Ember extend to use const syntax
nmap <leader>ec /Ember\.<CR>dt.xvt."cyggo<CR>const {<CR><CR>} = Ember;<ESC>k"cp	/extend<CR>o

" run tests
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>T :TestNearest<CR>

nmap <leader>ct :call neoterm#close()<CR>

" Syntax errors
autocmd BufWrite * :Neomake

" Settings
" ========
set smartindent
set autoindent
set number
set ruler
set rulerformat=%-14.(%l,%c%V%)\ %P
set modelines=0
syntax enable

set nowrap
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set list
set backspace=indent,eol,start

set showmode
set showcmd

set listchars=""
set listchars=tab:\ \
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<

set colorcolumn=85

if has("autocmd")
  filetype indent on
endif

" Helpful keybindings
" ===================
" remove help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap ; :

" JSX
" ===
let g:jsx_ext_required = 0

" Save in normal mode with CR
" ===========================
nmap <CR> :w<CR>

" Testing
" =======
let test#strategy = "vtr"
let test#ruby#rspec#executable = 'bundle exec rspec'
let test#ruby#rspec#options = {
  \ 'nearest': '--backtrace',
  \ 'file':    '--format documentation --color',
  \}

if !empty(glob('.zeus.sock'))
  let test#ruby#minitest#executable = 'zeus test'
  let test#ruby#minitest#options = ''
endif

" Linting
" =======
let g:neomake_javascript_enabled_makers = ['eslint']

if findfile('.eslintrc', '.') ==# ''
  let g:neomake_javascript_enabled_makers = ['standard']
endif

" Python
" ======
let g:python_host_prog = '/Users/mgeorge/.virtualenvs/main/bin/python'

" Searching
" =========
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set gdefault
set smartcase

" Backup and swap files
" =====================
set backupdir^=~/.config/nvim/_backup//
set directory^=~/.config/nvim/_temp//

" Colorscheme overrides
" =====================
hi Search ctermbg=21 ctermfg=15
hi Pmenu ctermbg=31 ctermfg=15

" Set filetypes as typescript.jsx
" ===============================
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.jsx

" MacOS Sierra / Tmux Fix
set clipboard=unnamed

" Close vim if NERDTree is the only buffer
" ========================================
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
