" start  vim comend

" set number &&  multi-command in one line!
set relativenumber number numberwidth=2

		
" mapping 
nnoremap <C-j> yyddp
nnoremap <C-k> yydd<Up><Up>p
nnoremap <S-j> v<Down>
nnoremap <S-k> v<Up>
nnoremap <Space> viw
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
inoremap <C-d> <ESC>ddi
inoremap <C-l> <ESC>$i<Right>
inoremap <C-h> <ESC>0i
inoremap ' ''<Left>
inoremap < <><Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>


" mapleader 
let mapleader = "-"
let localleader = ","
nnoremap <leader>config  :vsplit $MYVIMRC<cr> 
nnoremap <leader>fconfig :source $MYVIMRC<cr>

" abbreviations example -> correct typo 
" :iabbrev slef self 



" auto command

augroup loggroup
	autocmd BufWrite * :echom "Writing buffer!"
augroup END

autocmd FileType python :iabbrev <buffer> self self
":autocmd FileType python nnoremap <buffer> <localleader>c I#

" Vimscript file settings ---------------------- {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}




" statusline 
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



"afqwrqwrqwrq"
