"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'),)
" Plugins "
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
Plug 'yssl/QFEnter'
Plug 'aliou/bats.vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'https://github.com/AndrewRadev/linediff.vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'rust-lang/rust.vim'
Plug 'baabelfish/nvim-nim'
Plug 'ycm-core/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'h1mesuke/unite-outline'
Plug 'neovim/pynvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

"*****************************************************************************
"" Vim Config
"*****************************************************************************
set colorcolumn=80
set termguicolors
set clipboard=unnamed
set nu
let g:rustfmt_autosave		= 1
let g:rust_recommended_style 	= 1
let g:rust_fold 		= 1
let g:EasyClipAutoFormat	= 1
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
let g:loaded_python_provider = 0
let g:python3_host_prrog = '/usr/bin/python3'
set pyxversion=3

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:ycm_clangd_binary_path='/usr/bin/clangd'

let Grep_Default_Options = '-IR'

"" Defaults qfenter
"" let g:qfenter_keymap = {}
"" let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
"" let g:qfenter_keymap.vopen = ['<Leader><CR>']
"" let g:qfenter_keymap.hopen = ['<Leader><Space>']
"" let g:qfenter_keymap.topen = ['<Leader><Tab>'

"" Map leader to ,
let mapleader=','
map <leader>q 		:q <CR>
map <leader>v 		:vsp <CR>
map <leader>s 		:Rg <CR>
map <leader><space> 	:noh <CR>
map <leader>n		:set nu! <CR>
map <leader>r		:set relativenumber! <CR>
map <leader>b		:Buffers <CR>
map <leader>f		:exec("Rg ".expand("<cword>"))<CR>
map <A-u>              :Grep <cword> * <CR>
map <A-t>              :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-g>              :exec("tag ".expand("<cword>"))<CR>
"map <A-u>		:YcmCompleter GoToReferences<CR>
"map <A-g>		:YcmCompleter GoTo<CR>
map <S-T>		:tabe <CR>
map <C-H>              :tabprevious <CR>
map <C-L>              :tabnext <CR>
map <C-J>              :bnext<CR>
map <C-K>              :bprev<CR>

nnoremap gm m

"" Set default tab policy
set noexpandtab
set tabstop=8
set shiftwidth=8

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
nnoremap <leader>e  :GFiles <CR>
nnoremap <leader>g  :Files <CR>

" Commands
command! FixWhitespace :%s/\s\+$//e
command! FWS FixWhitespace
command! Unix set ff=unix
command! Hex :%!xxd

syntax on
colorscheme onedark
