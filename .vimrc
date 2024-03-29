" vim tips
" 1. :scriptnames            : list all plugins, _vimrcs loaded (super)
" 2. :verbose set history?   : reveals value of history and where set
" 3. :function               : list functions
" 4. :func SearchCompl       : List particular function
" 5. :colorscheme <Space> <TAB> : to choose among colour scheme
" 6. @: 			:repeat last colon command
" vim path: /usr/share/vim/vim82
" to see how to use package (plugin) -> :h packages
" exmaple of plugin: :h write-plugin
" check runtimepath -> :set rtp? -> :h rtp
" end of vim tips

" recommended plug-ins
" ======================================
" gruvbox -> color scheme
" multi-selection -> vim-visual-multi
" leaderF vim -> fuzzy file finding
" vim-signify -> git diff
" vim-easymotion (or vim9-stargate) -> highlight vim motion jump!
" (easymotion will add its own mapping)
" ======================================
" GTAGS is a specific code tagging system; see https://www.gnu.org/software/global/globaldoc_toc
" 1. install GTAGS
" 2. plug-ins for GTAGS: gutentags -> https://github.com/ludovicchabant/vim-gutentags;
" also see: https://zhuanlan.zhihu.com/p/36279445
" =======================================
" LSP related: {LSP is a separate process running in the background; you need to connect vim as a client to it!!!}
" ALE (linter & more LSP feature) -> https://github.com/dense-analysis/ale
" vim-lsp + vim-lsp-settings -> for automatically config lsp for vim
" =======================================
" end of recommended plug-ins

" basic {{{
" VIM basic
filetype indent plugin on " i.e. filetype on + filetype plugin on + filetype indent on; turn on detection + plugin + indent

set noswapfile

" color
"let g:gruvbox_bold=1
"let g:gruvbox_italic=1
"let g:gruvbox_underline=1
"let g:gruvbox_termcolors=256
let g:gruvbox_contrast_dark='medium'
colorscheme gruvbox
set termguicolors  " enable by default
set background=dark

" for `some` shell
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
" end of color


syntax enable
" The ":syntax enable" command will keep your current color settings.  This
" allows using ":highlight" commands to set your preferred colors before or
" after using this command.  If you want Vim to overrule your settings with the
" defaults, use:syntax on

" shell in terminal mode
set shell=/usr/bin/zsh
" end of shell in terminal mode

" no beep
set belloff=all

" backup, swap, undo file location
"set backupdir=~/.vim/backup//
"set directory=~/.vim/swap//
"set undodir=~/.vim/undo//

" backspace
" vim will protect deletion from backspace
" indent -> allow <bs> delete indentation
" eol -> allow <bs> delete end of line mark
" indent -> if off, you can only delete text you've insert since insert mode started

set backspace=indent,eol,start
" end of backspace


" line number
set relativenumber number numberwidth=1
" end of line number

" tab
set expandtab " tab expand as spaces
set autoindent
set smartindent
" set switchbuf+=usetab,newtab " quickfix open file in another tab; but it will oepn every single tab

" local variable for indent width
" let b:indent_width = 4

" tab space in all files
" let &tabstop=b:indent_width
" let &shiftwidth=b:indent_width
" set softtabstop=4
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

" switch to buffer
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

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


" =======================================
" Leaderf fizzy file search
nnoremap <leader>ff :Leaderf<Space>--popup<Space>file<CR>
nnoremap <leader>fl :Leaderf<Space> line<CR>
" LeaderF gtags <sub-command> is a series command that uses Gtags...


" =======================================
" NERDTree Toggle nerdtree
nnoremap <leader>tt :NERDTreeToggle<CR>


" =======================================
" Gtags
nnoremap <C-]> :GtagsCursor<CR>
nnoremap <leader>gg :Gtags<Space>-g<Space>
" nnoremap <leader>gr :<C-U><C-R>=printf("Gtags -r %s", expand("<cword>"))<CR><CR> " search on current line?
" Gtags quickfix jump
nnoremap <C-k> :cp<CR>
nnoremap <C-j> :cn<CR>


" =======================================
" LSP mapping (vim-lsp + vim-lsp-settings)
nnoremap <leader>ls :LspStatus<CR>
nnoremap <leader>ld :LspDefinition<CR>
nnoremap <leader>lc :LspDeclaration<CR>
nnoremap <leader>lt :LspTypeDefinition<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <leader>lr :LspReferences<CR>
nnoremap <leader>lpd :LspPeekDefinition<CR>
nnoremap <leader>lpc :LspPeekDeclaration<CR>
nnoremap <leader>lpt :LspPeekTypeDefinition<CR>
nnoremap <leader>lda :LspDocumentDiagnostics<CR>

" open a file in quickfix list to a new tab
nnoremap <leader>co :tab copen<CR>

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


" augroup loggroup
" 	autocmd BufWrite * :echom "Writing buffer!"
" augroup END

augroup filetype_vim
    " autocmd! " clear all autocmd for this group
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_python

    " equivalent to -> autocmd BufEnter *.py let python_highlight_all=1
    autocmd FileType python let python_highlight_all=1

    " encoding
    autocmd FileType python setlocal encoding=utf-8

    " compile & run python within vim
    " autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    " autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END


augroup FileTypeSpecificIndentations
    autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType php setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType c setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
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

" let b:get_git_name  = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" let b:git_name = strlen(b:get_git_name) > 0?' '.b:get_git_name.' ':' _'

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


" delete all hidden buffers
" https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers

function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
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

command! -nargs=? -complete=buffer -bang Bonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BOnly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang Bufonly
    \ :call BufOnly('<args>', '<bang>')
command! -nargs=? -complete=buffer -bang BufOnly
    \ :call BufOnly('<args>', '<bang>')

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

" let g:ycm_autoclose_preview_window_after_insertion = 1

"
" sometimes i find completeopt slow vim down, so it'd better to limit its functionality
" see -> :h completeopt
"
" :set completeopt=longest,menuone

"
" you complete me config from zhihu:
"
" let g:ycm_add_preview_to_completeopt = 0
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_server_log_level = 'info'
" let g:ycm_min_num_identifier_candidate_chars = 2
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_complete_in_strings=1
" let let g:ycm_max_num_candidates=7
" set completeopt=menu,menuone

" enter 2 char will triger semantic completion, thanks to async feature starting from vim 8
" let g:ycm_semantic_triggers =  {
" 			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
" 			\ 'cs,lua,javascript': ['re!\w{2}'],
" 			\ }

" file type to enable ycm
" let g:ycm_filetype_whitelist = {
" 			\ "c":1,
" 			\ "cpp":1,
" 			\ "objc":1,
"                       \ "go":1,
" 			\ "python":1,
" 			\ "sh":1,
" 			\ "zsh":1,
" 			\ "zimbu":1,
" 			\ }

" =========================================
" GTAGS
" Firstly MUST set up GTAGS correctly!! (don't forget to cp gtags.vim)
" GTAGS code tagging via Gutentags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" enable ctags + gtags; if no ctags just disable
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0

" IF gutentags has ERROR: DEBUG (see trace)
" let g:gutentags_define_advanced_commands = 1
" :GutentagsToggleTrace
" :messages
" LIKELY a permission problem; just chmod +x <the_bash_script>


" =========================================
" leaderF not search virtual env
" let g:Lf_UseVersionControlTool = 0
" let g:Lf_WildIgnore = {'dir': ['*venv*']}

" =========================================
" LSP
"let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
let g:lsp_document_highlight_enabled = 0

" note that this can be config on a per project basis
" TODO does not seem to be effective
let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['pylint']
\       }
\     }
\   },
\}


"}}}

" write vim profile log {{{
" :profile start profile.log
" :profile func *
" :profile file *
"" At this point do slow actions
" :profile pause
" :qa!
" }}}
