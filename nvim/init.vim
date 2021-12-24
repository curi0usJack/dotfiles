
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'ggandor/lightspeed.nvim'
Plug 'johnantoni/vim-wildignore'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'mboughaba/i3config.vim'
Plug 'morhetz/gruvbox'
Plug 'mrk21/yaml-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/completion-treesitter'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'puremourning/vimspector'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/lsp_signature.nvim'
Plug 'ray-x/navigator.lua'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}

lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach}

" https://github.com/ray-x/navigator.lua
" gr to show reference
lua require'navigator'.setup{}

lua require "lsp_signature".setup()

command! Scratch lua require'tools'.makeScratch()
"
" Vim Options
"
set nohlsearch
let g:dracula_colorterm = 0
let g:dracula_italic = 0
let g:python3_host_prog='/usr/bin/python3'
" colorscheme aurora
colorscheme onedark
" colorscheme dracula
set background=dark
set diffopt=vertical,filler
set encoding=utf-8
set laststatus=2
set nocompatible
set number
set relativenumber
set termguicolors
" set rtp+=/usr/local/opt/fzf
set shiftwidth=4
set hidden
set smarttab
set splitbelow
set splitright
set t_Co=256
set tabstop=4
set wildignore+=*/$RECYCLE.BIN/*,*DS_Store*,*/Chrome/*,*/Aperature\ Library.aplibrary/*
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
syntax on
set backspace=indent,eol,start
set backupdir=~/.local/share/nvim/backup
set completeopt=noinsert,menuone,noselect
"
" set color column indicator to specific num characters if desired. Uncomment
" the 2 below
"
" set textwidth=80
" set colorcolumn=+1
"
filetype plugin indent on    " required

"HardTime Enabled
let g:hardtime_default_on = 0

"
" Main Key Mappings
"
let mapleader=","
map <leader>w :w<cr>
map <leader>r :redraw<cr>
map <leader>ga :G add %<cr>
map <leader>gs :G status<cr>
map <leader>gc :G commit<cr>
map <leader>gp :G push origin master<cr>
map <leader>gj :diffget //3
map <leader>gf :diffget //2
map <leader>n :NERDTreeToggle<cr>
map <leader>q :bd<cr>
map <leader>q! :bd!<cr>
map <leader>p3 :w! \| :!python3 %<cr>
map <leader>p2 :w! \| :!python %<cr>
map <leader>ans :w! \| :!ansible-playbook % --step
map <leader>asyn :w! \| :!ansible-playbook % --syntax-check
map <leader>src :source ~/.config/nvim/init.vim<cr>
map <leader>vrc :e ~/.config/nvim/init.vim<cr>
map <leader>f :Files<cr>
map <leader>F :Files /home/jason<cr>
map <leader>b :Buffer<cr>
map <leader>v :vnew<cr>
map <leader>o <c-O><cr>
map <leader>i <c-I><cr>
nnoremap <leader>cd :cd %:p:h<cr>

" Add ipdb breakpoint with on insert mode
ab bp __import__('ipdb').set_trace(context=10)
"
" Airline/Powerline
"
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='onedark'
" let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

" FOR COMPLETION-TREESITTER MODULE
" Configure the completion chains
let g:completion_chain_complete_list = {
            \'default' : {
            \    'default' : [
            \        {'complete_items' : ['lsp', 'snippet']},
            \        {'mode' : 'file'}
            \    ],
            \    'comment' : [],
            \    'string' : []
            \    },
            \'vim' : [
            \    {'complete_items': ['snippet']},
            \    {'mode' : 'cmd'}
            \    ],
            \'c' : [
            \    {'complete_items': ['ts']}
            \    ],
            \'python' : [
            \    {'complete_items': ['ts']}
            \    ],
            \'lua' : [
            \    {'complete_items': ['ts']}
            \    ],
            \}

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" autocmd BufEnter * python require'completion'.on_attach()

"
" Fix Typos
"
command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e
command! W w
command! Wq wq

" Handle YAML files
autocmd FileType yaml,yml set filetype=ansible.yaml
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ansible.yaml,yaml,yml let b:ale_linters = ['ansible_lint', 'yamllint']
autocmd FileType py,python let b:ale_linters = ['pylint']
autocmd FileType py,python let b:ale_fixers = ['reorder-python-imports']
autocmd FileType sh setlocal ts=4 sts=4 sw=2 expandtab
autocmd FileType py setlocal ts=4 sts=2 sw=2 expandtab
autocmd BufWritePre *.yml silent! %s/ :/:/g " Remove spaces after bracket
autocmd BufWritePre *.yml silent! %s/\[ /\[/g " Remove spaces after bracket
autocmd BufWritePre *.yml silent! %s/ \]/\]/g " Remove spaces before bracket
" autocmd BufWritePre *.yml silent! %s/{ /{/g " Remove spaces after bracket
" autocmd BufWritePre *.yml silent! %s/ \}/\}/g " Remove spaces before bracket
" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()
" autocmd vimenter * colorscheme gruvbox

" ALE
let g:ale_enabled = 1
let g:ale_fixers = ['trim_whitespace', 'remove_trailing_lines']
let g:ale_fix_on_save = 1
let g:ale_exclude_highlights = ['line too long']

" Custom mappings
imap jk <ESC>
" vmap jk <ESC>
" tmap jk <ESC>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

" fzf functions
" Use preview when FzfFiles runs in fullscreen
"command! -nargs=? -bang -complete=dir FzfFiles
"	   \ call fzf#vim#files(<q-args>, <bang>0 ? fzf#vim#with_preview('up:60%') : {}, <bang>0)
