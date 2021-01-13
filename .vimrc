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
filetype indent plugin on 

syntax enable 
" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use:syntax on

set background=dark
colorscheme default

set relativenumber number numberwidth=1

set expandtab " tab expand as spaces 
let b:indent_width = 4 " local variable for indent width
let &tabstop=b:indent_width " tab = 4 space in all files
let &shiftwidth=b:indent_width

set hlsearch incsearch " highlight when performing search
set foldcolumn=1  cursorline  showmatch  autoindent


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
inoremap < <><Left>
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


" set encoding=utf-8 for python 3


