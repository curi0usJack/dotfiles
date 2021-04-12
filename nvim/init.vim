"
" Vundle
"
set nocompatible
filetype off
call plug#begin('~/.vim/plugged')
Plug 'mboughaba/i3config.vim'
" Plug 'ncm2/ncm2'
" Plug 'ncm2/ncm2-bufword'
" Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'bps/vim-textobj-python'
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'davidhalter/jedi-vim'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'frazrepo/vim-rainbow'
Plug 'johnantoni/vim-wildignore'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'mrk21/yaml-vim'
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'
call plug#end()

"
" Vim Options
"
set nohlsearch
let g:dracula_colorterm = 0
let g:dracula_italic = 0
let g:python3_host_prog='/usr/bin/python3'
colorscheme onedark
" colorscheme dracula
set background=dark
set diffopt=vertical,filler
set encoding=utf-8
set laststatus=2
set nocompatible
set number
set relativenumber
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
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'

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
"
" ncm2 options
"
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
		\ 'name' : 'css',
		\ 'priority': 9,
		\ 'subscope_enable': 1,
		\ 'scope': ['css','scss'],
		\ 'mark': 'css',
		\ 'word_pattern': '[\w\-]+',
		\ 'complete_pattern': ':\s*',
		\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
		\ })

"
" Jedi-vim Options
"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
"
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
