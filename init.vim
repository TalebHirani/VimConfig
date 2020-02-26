syntax on
set nocompatible              " be iMproved, required
filetype on                 " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'pangloss/vim-javascript'
Plugin 'flazz/vim-colorschemes'

Plugin 'dense-analysis/ale'
"Plugin 'lervag/vimtex'

Plugin 'Chiel92/vim-autoformat'

Plugin 'fatih/vim-go'

"Plugin 'sirver/ultisnips'

"Plugin 'tomlion/vim-solidity'
"Plugin 'sheerun/vim-polyglot'
Plugin 'lervag/vimtex'

"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

call vundle#end()            " required
set mouse=a
filetype plugin indent on    " required
let g:airline_theme='minimalist'
let g:javascript_plugin_ngdoc = 1
set number
set noerrorbells
colorscheme 1989
set expandtab
set tabstop=2
set shiftwidth=4
let g:polyglot_disabled = ['css']
let g:polyglot_disabled = ['tex']

"if has('macunix')
"    let g:vimtex_view_general_viewer
"                \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
"elseif has('unix')
"    let g:vimtex_view_general_viewer
"                \ = 'zathura'
"endif
let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
let g:vimtex_latexmk_callback_hooks = ['UpdateSkim']
function! UpdateSkim(status)
	if !a:status | return | endif

	let l:out = b:vimtex.out()
	let l:tex = expand('%:p')
	let l:cmd = [g:vimtex_view_general_viewer, '-r']
	if !empty(system('pgrep Skim'))
		call extend(l:cmd, ['-g'])
	endif
	if has('nvim')
		call jobstart(l:cmd + [line('.'), l:out, l:tex])
	elseif has('job')
		call job_start(l:cmd + [line('.'), l:out, l:tex])
	else
		call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
	endif
endfunction

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'haskell': ['hfmt', 'hlint'],
\}
let g:ale_linters = {
\   'cpp': ['clang'],
\   'python': ['flake8'],
\   'java': ['javac'],
\   'haskell': ['hlint', 'stack-ghc', 'hfmt'],
\}

"let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']
