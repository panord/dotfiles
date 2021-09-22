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

Plug 'aliou/bats.vim'
Plug 'vim-scripts/grep.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'rust-lang/rust.vim'
call plug#end()

"*****************************************************************************
"" Vim Config
"*****************************************************************************
set colorcolumn=80
set termguicolors
set clipboard=unnamed
let g:rustfmt_autosave		= 1
let g:rust_recommended_style 	= 1
let g:rust_fold 		= 1
let g:EasyClipAutoFormat	= 1
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'

let Grep_Default_Options = '-IR'

"" Map leader to ,
let mapleader=','
map <leader>e 		:e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>q 		:q <CR>
map <leader>t 		:tabe <C-R>=expand("%:p:h") . "/" <CR>
map <leader>v 		:vsp <CR>
map <leader>s 		:split <C-R>=expand("%:p:h") . "/" <CR>
map <leader><space> 	:noh <CR>
map <leader>n		:set nu! <CR>
map <leader>r		:set relativenumber! <CR>
map <leader>b		:Buffers <CR>
map <leader>f		:Grep <CR>
map <C-\> 		:tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> 		:vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <S-T>		:tabe <CR>
map <S-Tab>		:tabprevious <CR>
map <Tab>		:tabnext <CR>

nnoremap gm m

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv
nnoremap <leader>e  :GFiles <CR>
nnoremap <leader>g  :Files <CR>

" Commands
command! FixWhitespace :%s/\s\+$//e
command! FWS FixWhitespace
command! Hex :%!xxd

syntax on
colorscheme onedark
