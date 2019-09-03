if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'gruvbox-community/gruvbox' 
Plug 'vim-airline/vim-airline'
Plug 'godlygeek/tabular' 
Plug 'plasticboy/vim-markdown'
Plug 'ycm-core/YouCompleteMe'
"Plug 'scrooloose/nerdtree'
Plug 'arcticicestudio/nord-vim'
Plug 'lervag/vimtex'
"Plug 'vim-syntastic/syntastic'
Plug 'jez/vim-better-sml'

call plug#end()

set lazyredraw
set linebreak
set number
set cursorline
set background=dark
colorscheme gruvbox

set tabstop=4
set shiftwidth=4
set expandtab

"set spell spelllang=en_us
set ignorecase
set smartcase


"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

let g:airline_powerline_fonts = 1

let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

"let g:vimtex_quickfix_mode = 1
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_enabled = 0


"Old settings
"SML Config
"augroup mySyntastic
	" tell syntastic to always stick any detected errors into the location-list
"	au FileType sml let g:syntastic_always_populate_loc_list = 1

	" automatically open and/or close the location-list
"	au FileType sml let g:syntastic_auto_loc_list = 1
"augroup END

" press <Leader>S (i.e., \S) to not automatically check for errors
"nnoremap <Leader>S :SyntasticToggleMode<CR>


