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

" set {{{
" VIM basic
filetype on

" set noerrorbells


filetype indent plugin on 

syntax enable 
" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use:syntax on

" color
set background=dark
colorscheme default  " can use gruvbox if installed
" end of color 


" line number
set relativenumber number numberwidth=1
" end of line number

" tab
set expandtab " tab expand as spaces 
let b:indent_width = 4 " local variable for indent width
let &tabstop=b:indent_width " tab = 4 space in all files
let &shiftwidth=b:indent_width
set smartindent
" set autoindent
" end of tab

" search 
set smartcase  " case insensive searching
set hlsearch " no highlight after search
set incsearch 
set showmatch " show the matching part of the pair for [] {} and ()
" end of search 

set nowrap " no wrap for long line 
set signcolumn=yes
" set foldcolumn=1  
set colorcolumn=100
set noerrorbells 
set scrolloff=8  " keep the cursor off page edge, keeping cursor centered

" cursor 
"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)
" set cursorline  " underline of current line

" this overwrite the conflict caused by .zshrc when entering file
autocmd VimEnter * silent exec "! echo -ne '\e[2 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"
" end of cursor
"}}}


" recommended plug-ins
" gruvbox -> color scheme
" vim-man -> man pages
" rtags -> great for cpp
" ctrlp vim -> nice file finding
" YouCompleteMe -> autocomplete
" undo tree -> like git graph allowing quick view of progress
" end of recommended plug-ins



" mapleader {{{ 
" use " " will choose the <space bar>
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
inoremap <C-d> <Esc>ddi
inoremap <S-Tab> <C-d>
inoremap <C-l> <ESC>$i<Right>
inoremap <C-h> <ESC>0i
" inoremap < <><Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
xnoremap <C-c> "*y
xnoremap ( xi()<Esc>P
xnoremap [ xi[]<Esc>P
xnoremap { xi{}<Esc>P
xnoremap ' xi''<Esc>P
xnoremap " xi""<Esc>P
""inoremap ' ''<Left>
""inoremap " ""<Left>
"}}}


" auto command {{{

" automatic highlight matching work under the cursor
" By default, this will highlight the word under the cursor after 4s of inactivity.
autocmd CursorHold * :exec 'match Search /\V\<' . expand('<cword>') . '\>/'
set updatetime=100 " to make it happen after 0.1s instead.



augroup loggroup
	autocmd BufWrite * :echom "Writing buffer!"
augroup END

augroup filetype_vim
    " clear all autocmd for this group 
	autocmd!  
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" python

" autocmd BufEnter *.py colorscheme torte
autocmd BufNewFile,BufRead *.py
    \ let python_highlight_all=1 " TODO test: enable all py syntax highlight
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set foldmethod=indent
    \ set encoding=utf-8  "for python 3

" compile & run python within vim 
" autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
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

" TODO: this shows how to display buffer number ...
" set laststatus=2                             " always show statusbar  
" set statusline=  
" set statusline+=%-10.3n\                     " buffer number  
" set statusline+=%f\                          " filename   
" set statusline+=%h%m%r%w                     " status flags  
" set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type  
" set statusline+=%=                           " right align remainder  
" set statusline+=0x%-8B                       " character value  
" set statusline+=%-14(%l,%c%V%)               " line, character  
" set statusline+=%<%P                         " file position  

let b:get_git_name  = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
let b:git_name = strlen(b:get_git_name) > 0?' '.b:get_git_name.' ':' _'

set statusline=%f " relative path
set statusline+=%#LineNr# "syntax highlighting
set statusline+=\ -\ " separator 
set statusline+=ft: " Label
set statusline+=%y        " Filetype of the file

" disable git name in status bar
" set statusline+=\ -\ " separator 
" set statusline+=loc_branch: 
" set statusline+=%{b:git_name}
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
