syntax on
set number
set cursorline
set wrap
set showcmd 
set wildmenu
set hlsearch            
exec "nohlsearch" 
set incsearch " highlook when search 
set ignorecase "ignore word up or down case
set smartcase
set mouse=

noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

call plug#begin('~/.vim/plugged')

Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'hukl/Smyck-Color-Scheme'
Plug 'liuchengxu/space-vim-theme'
Plug 'junegunn/seoul256.vim'
Plug 'tpope/vim-vividchalk'
Plug 'connorholyday/vim-snazzy'
Plug 'jiangmiao/auto-pairs'
Plug 'ycm-core/YouCompleteMe'
call plug#end()

"colorscheme vividchalk
colorscheme snazzy

set guifont=Consolas:h12

set fileencodings=ucs-bom,utf-8,chinese,cp936

autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*ha
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,n ****** <++><Esc>F*2hi
autocmd Filetype markdown inoremap ,3 ###
autocmd Filetype markdown inoremap ,t <Esc>o-----\|-----<enter>
autocmd Filetype markdown inoremap ,l [](<++>)<Esc>F]i
autocmd Filetype markdown inoremap ,W <Esc>:w<CR>:!typora %<CR>

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" 跳转快捷键
nnoremap <c-k> :YcmCompleter GoToDeclaration<CR>|
nnoremap <c-h> :YcmCompleter GoToDefinition<CR>|
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" C
autocmd Filetype c,cpp inoremap ,, <Esc>$a;
autocmd Filetype c inoremap ,c <Esc>o{}<Esc>i<Enter><Esc>O
autocmd Filetype c,cpp inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype c inoremap ,t typedef struct {<Enter><Enter>}<++>;<Enter> <++><Esc>2kO
autocmd Filetype c inoremap ,s struct {<Enter><++><Enter>}<Enter><++><Esc>3k$ha
autocmd Filetype c inoremap ,p printf("", <++>);<Esc>8hi

map <F5> :call CompileRunGcc()<CR>
 func! CompileRunGcc()
  	exec "w"
  	if &filetype == 'c'
  		exec "!gcc % -o %<"
  		exec "!time ./%<"
  	elseif &filetype == 'cpp'
  		exec "!g++ % -o %<"
  		exec "!time ./%<"
  	endif
endfunc

