" vim tips
" 1. :scriptnames            : list all plugins, _vimrcs loaded (super)  
" 2. :verbose set history?   : reveals value of history and where set  
" 3. :function               : list functions  
" 4. :func SearchCompl       : List particular function
" 5. :colorscheme <Space> <TAB> : to choose among colour scheme
" 6. :@: 			:repeat last colon command
" 7. plugin: YOUCOMPLETEME
" vim path: /usr/share/vim/vim82
" to see how to use package (plugin) -> :h packages
" exmaple of plugin: :h write-plugin 
" check runtimepath -> :set rtp? -> :h rtp 
" end of vim tips


" VIM basic
filetype on

" set noerrorbells


filetype indent plugin on 

syntax enable 
" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use:syntax on

set background=dark
colorscheme default  " can use gruvbox if installed

set relativenumber number numberwidth=1

set expandtab " tab expand as spaces 
let b:indent_width = 4 " local variable for indent width
let &tabstop=b:indent_width " tab = 4 space in all files
let &shiftwidth=b:indent_width

set nowrap
set smartindent
set smartcase  " case insensive searching
" set autoindent

set hlsearch incsearch " highlight when performing search
set foldcolumn=1  cursorline  showmatch  


" recommended plug-ins
" gruvbox -> color scheme
" vim-man -> man pages
" rtags -> great for cpp
" ctrlp vim -> nice file finding
" YouCompleteMe -> autocomplete
" undo tree -> ??
" end of recommended plug-ins



" mapleader {{{ 
let mapleader = "-"
let localleader = ","
nnoremap <leader>config  :vsplit $MYVIMRC<cr> 
nnoremap <leader>fconfig :source $MYVIMRC<cr>
"}}}




" mapping {{{
nnoremap <C-j> yyddp
nnoremap <C-k> yydd<Up><Up>p
nnoremap <S-j> v<Down>
nnoremap <S-k> v<Up>
nnoremap <Space> viw
inoremap <C-d> <Esc>ddi
inoremap <S-Tab> <C-d>
inoremap <C-l> <ESC>$i<Right>
inoremap <C-h> <ESC>0i
" inoremap < <><Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
xnoremap <C-c> "*y
""inoremap ' ''<Left>
""inoremap " ""<Left>
"}}}



" auto command {{{

augroup loggroup
	autocmd BufWrite * :echom "Writing buffer!"
augroup END



augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

"}}}




" statusline {{{
set laststatus=2

" TODO: reset git branch display after making my plugin
"if exists('g:loaded_gitbranch') || v:version < 700
"  finish
"endif
"let g:loaded_gitbranch = 1
"
"
"
"

let b:get_git_name  = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
let b:git_name = strlen(b:get_git_name) > 0?' '.b:get_git_name.' ':' _'

set statusline=%f " relative path
set statusline+=%#LineNr# "syntax highlighting
set statusline+=\ -\ " separator 
set statusline+=ft: " Label
set statusline+=%y        " Filetype of the file
set statusline+=\ -\ " separator 
set statusline+=loc_branch: 
set statusline+=%{b:git_name}
set statusline+=%=        " Switch to the right side
set statusline+=%#Folded# " highlight group
set statusline+=Lines:\ 
set statusline+=%l " Current line
set statusline+=/
set statusline+=%L "total line
"}}}




" branching {{{
" ==# is the case-sensitive comparison no matter what the user has set
" ==? is the case-insensitive comparison no matter what the user has set
"}}}




" function  {{{

"nnoremap <leader>f :call foldcolumntoggle()<cr>
"
"function! foldcolumntoggle()
"    echom &foldcolumn
"endfunction

"}}}




" helper_function  {{{




function! Reversed(l)
	let new_list = deepcopy(a:l)
	call reverse(new_list)
	return new_list
endfunction


"}}}


" python {{{
autocmd BufNewFile,BufRead *.py
    \ set expandtab  " replace tabs with spaces
    \ set autoindent "copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set foldmethod=indent
    \ set encoding=utf-8  "for python 3
    
autocmd BufEnter *.py colorscheme torte

" compile & run python within vim 
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" }}}

