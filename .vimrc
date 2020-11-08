" start  vim comment

" set number &&  multi-command in one line!
set relativenumber number numberwidth=2
set foldcolumn=1
set hlsearch incsearch " highlight when performing search
		
" mapping {{{
nnoremap <C-j> yyddp
nnoremap <C-k> yydd<Up><Up>p
nnoremap <S-j> v<Down>
nnoremap <S-k> v<Up>
nnoremap <Space> viw
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
inoremap <C-d> <ESC>ddi
inoremap <C-l> <ESC>$i<Right>
inoremap <C-h> <ESC>0i
inoremap < <><Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
""inoremap ' ''<Left>
""inoremap " ""<Left>
"}}}



" mapleader {{{ 
let mapleader = "-"
let localleader = ","
nnoremap <leader>config  :vsplit $MYVIMRC<cr> 
nnoremap <leader>fconfig :source $MYVIMRC<cr>
"}}}

" abbreviations example for correct typo 
" :iabbrev slef self 


" auto command {{{

augroup loggroup
	autocmd BufWrite * :echom "Writing buffer!"
augroup END

autocmd FileType python :iabbrev <buffer> self self
autocmd FileType python :iabbrev <buffer> reutrn return
":autocmd FileType python nnoremap <buffer> <localleader>c I#


augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

"}}}



" statusline {{{
set laststatus=2

set statusline=%f " relative path
set statusline+=%#LineNr# "syntax highlighting
set statusline+=\ -\ " separator 
set statusline+=FileType: " Label
set statusline+=%y        " Filetype of the file

set statusline+=%=        " Switch to the right side
set statusline+=%#Folded#
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
