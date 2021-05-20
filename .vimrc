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

" TODO test different plugins
" recommended plug-ins
" gruvbox -> color scheme
" multi-selection -> vim-visual-multi
" leaderF vim -> fuzzy file finding
" YouCompleteMe -> autocomplete
" vim-signify -> git diff
" vim-python/python-syntax -> python syntax highlight
" undo tree -> like git graph allowing quick view of progress
" end of recommended plug-ins

" basic {{{
" VIM basic
filetype on

" color
"let g:gruvbox_bold=1
"let g:gruvbox_italic=1
"let g:gruvbox_underline=1
"let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set termguicolors  " enable by default
set background=dark
" end of color

filetype indent plugin on

syntax enable
" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use:syntax on

" shell in terminal mode
set shell=/usr/bin/zsh
" end of shell in terminal mode

" backspace
" vim will protect deletion from backspace
" indent -> allow <bs> delete indentation
" eol -> allow <bs> delete end of line mark
" indent -> if off, you can only delete text you've insert since insert mode started

set backspace=indent,eol,start
" end of backspace

" encoding
set encoding=utf-8  "for python 3
" end of encoding

" line number
set relativenumber number numberwidth=1
" end of line number

" tab
set expandtab " tab expand as spaces

" local variable for indent width
let b:indent_width = 4

" tab space in all files
let &tabstop=b:indent_width
let &shiftwidth=b:indent_width
set softtabstop=4
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
set scrolloff=10  " keep the cursor off page edge, keeping cursor centered

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

" end of cursor
"}}}


" mapleader {{{

" use " " will choose the <space bar>
" let mapleader = " "  <Space> makes terminal mode slower
" let localleader = ","
let mapleader = ","

nnoremap <leader>config  :vsplit $MYVIMRC<cr>
nnoremap <leader>fconfig :source $MYVIMRC<cr>
"}}}


" mapping {{{
nnoremap <C-j> ddp
nnoremap <C-k> dd<Up><Up>p

" switch to buffer
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" for fizzy file search
nnoremap <leader>ff :Leaderf<Space>--popup<Space>file<CR>

" directly start debugger
nnoremap <leader>py :let @" = expand("%") <bar> :terminal<CR>py<Space>-m<Space>ipdb<Space><C-w>""<CR>

" Toggle nerdtree
nnoremap <leader>tt :NERDTreeToggle<CR>

" fix the * position, but goes to the start of the current word
nnoremap * *N

" inoremap <C-d> <Esc>ddi
inoremap <S-Tab> <C-d>
inoremap <C-l> <ESC>$i<Right>
inoremap <C-h> <ESC>^i
" inoremap < <><Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" add surroundings on visual mode
xnoremap <leader>( c()<Esc>P
xnoremap <leader>[ c[]<Esc>P
xnoremap <leader>{ c{}<Esc>P
xnoremap <leader>' c''<Esc>P
xnoremap <leader>" c""<Esc>P

" highlight visual selected txt
xnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" short cut on terminal mode
tnoremap <leader>py py<Space>-m<Space>ipdb<Space>


" Insert mode auto delete pairs; e.g. () <BS> -> delete both quote
let g:couples = ['(#)', '[#]', '{#}', '<#>', '<div>#</div>', '"#"', ]  " TODO add ' to the list
function BetterBS()

    for l:couple in g:couples
        if ! (l:couple =~ '#')
            continue
        endif
        let l:regex = substitute(escape(l:couple, '/\^$*.[~'), '#', '\\%#', '')
        if search(l:regex, 'n')
            let l:out = repeat("\<BS>", len(matchstr(l:couple, '^.\{-}\ze#')))
            let l:out .= repeat("\<DEL>", len(matchstr(l:couple, '#\zs.\{-}$')))
            return l:out
        endif
    endfor

    return "\<BS>"
endfunction
inoremap <silent> <BS> <C-r>=BetterBS()<CR>
" end of insert mode delete
"
"}}}


" auto command {{{

" automatic highlight matching work under the cursor, XXX if highlight color can customise?
" By default, this will highlight the word under the cursor after 4s of inactivity.
" autocmd CursorHold * :exec 'match Search /\V\<' . expand('<cword>') . '\>/'
" set updatetime=100 " to make it happen after 0.1s instead.


" this overwrite the conflict caused by .zshrc when entering file
autocmd VimEnter * silent exec "! echo -ne '\e[2 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" delete trailing white space when save
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" end of delete trailing white space when save




augroup loggroup
	autocmd BufWrite * :echom "Writing buffer!"
augroup END

augroup filetype_vim
    " clear all autocmd for this group
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" python
" \ let python_highlight_all=1 " TODO test: enable all py syntax highlight
autocmd BufEnter *.py let python_highlight_all=1

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
set statusline+=Lines:
set statusline+=%l " Current line
set statusline+=/
set statusline+=%L "total line
"}}}


" branching {{{
" ==# is the case-sensitive comparison no matter what the user has set
" ==? is the case-insensitive comparison no matter what the user has set
"}}}


"  function  {{{

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


" BufOnly.vim  -  Delete all the buffers except the current/named buffer.
"
" Copyright November 2003 by Christian J. Robinson <infynity@onewest.net>
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :Bonly / :BOnly / :Bufonly / :BufOnly [buffer] 
"
" Without any arguments the current buffer is kept.  With an argument the
" buffer name/number supplied is kept.

"command! -nargs=? -complete=buffer -bang Bonly
"    \ :call BufOnly('<args>', '<bang>')
"command! -nargs=? -complete=buffer -bang BOnly
"    \ :call BufOnly('<args>', '<bang>')
"command! -nargs=? -complete=buffer -bang Bufonly
"    \ :call BufOnly('<args>', '<bang>')
"command! -nargs=? -complete=buffer -bang BufOnly
"    \ :call BufOnly('<args>', '<bang>')

function! BufOnly(buffer, bang)
	if a:buffer == ''
		" No buffer provided, use the current buffer.
		let buffer = bufnr('%')
	elseif (a:buffer + 0) > 0
		" A buffer number was provided.
		let buffer = bufnr(a:buffer + 0)
	else
		" A buffer name was provided.
		let buffer = bufnr(a:buffer)
	endif

	if buffer == -1
		echohl ErrorMsg
		echomsg "No matching buffer for" a:buffer
		echohl None
		return
	endif

	let last_buffer = bufnr('$')

	let delete_count = 0
	let n = 1
	while n <= last_buffer
		if n != buffer && buflisted(n)
			if a:bang == '' && getbufvar(n, '&modified')
				echohl ErrorMsg
				echomsg 'No write since last change for buffer'
							\ n '(add ! to override)'
				echohl None
			else
				silent exe 'bdel' . a:bang . ' ' . n
				if ! buflisted(n)
					let delete_count = delete_count+1
				endif
			endif
		endif
		let n = n+1
	endwhile

	if delete_count == 1
		echomsg delete_count "buffer deleted"
	elseif delete_count > 1
		echomsg delete_count "buffers deleted"
	endif

endfunction

"}}}


"  plug_in config  {{{

" this part may not be necessary as setup script will do this automatically when setting up containers
" let g:ycm_autoclose_preview_window_after_insertion = 1
"}}}

