" Plugin manager setup
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Plugins
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'gruvbox-community/gruvbox' 
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular' 
Plug 'plasticboy/vim-markdown'
"Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'lervag/vimtex'
Plug 'ycm-core/YouCompleteMe'
"Plug 'vim-syntastic/syntastic'
Plug 'jez/vim-better-sml'

call plug#end()


" Terminal stuff
set lazyredraw
set linebreak
set number
set cursorline
set background=dark
colorscheme gruvbox


" Text editing
set tabstop=4
set shiftwidth=4
set expandtab


" Search
"set spell spelllang=en_us
set ignorecase
set smartcase
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>


" Airline
let g:airline_powerline_fonts = 1


" Vim markdown
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1


" Vim-tex
"let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_enabled = 1
let g:vimtex_view_general_viewer="sumatrapdf.exe"


" Deoplete
"if has('nvim')
"    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"endif

"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#var('omni', 'input_patterns', {
"          \ 'tex': g:vimtex#re#deoplete
"          \})


" YCM settings
 if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
 endif
 au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme






"SML Config
"augroup mySyntastic
	" tell syntastic to always stick any detected errors into the location-list
"	au FileType sml let g:syntastic_always_populate_loc_list = 1

	" automatically open and/or close the location-list
"	au FileType sml let g:syntastic_auto_loc_list = 1
"augroup END

" press <Leader>S (i.e., \S) to not automatically check for errors
"nnoremap <Leader>S :SyntasticToggleMode<CR>


