" This is Derek Bender's .vimrc file
" vim:set ts=2 sts=2 sw=2 expandtab:
set encoding=utf-8
scriptencoding utf-8

" be iMproved, required for modern vim, Vundle
set nocompatible

" Speed hacks
" use old regex engine, new one is slow for ruby.vim
set regexpengine=1
set ttyfast
set lazyredraw
set redrawtime=10000

" required for Vundle
filetype off
" set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'airblade/vim-gitgutter'
Plugin 'luochen1990/rainbow'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'Keithbsmiley/rspec.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'hwartig/vim-seeing-is-believing'
Plugin 'slim-template/vim-slim'
Plugin 'dense-analysis/ale' " ALE: https://github.com/dense-analysis/ale
Plugin 'itchyny/lightline.vim' " replaces powerline
Plugin 'junegunn/fzf', {'rtp': '/usr/local/opt/fzf'}
Plugin 'xaizek/preamble.vim'
Plugin 'junegunn/vim-emoji'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'hashivim/vim-terraform' "syntax highlighting
" Themes
Plugin 'buc0/my-vim-colors'
Plugin 'nightsense/stellarized'
Plugin 'srcery-colors/srcery-vim'

" end of Vundle plugins declarations
call vundle#end()            " required
filetype plugin indent on    " required

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" display incomplete commands
set showcmd
" Fix slow O inserts
"set timeout timeoutlen=1000 ttimeoutlen=100

set hidden
set visualbell
set number
"set paste "in compatible with auto format?
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

set viminfo='20,<1000,s10,h

set timeout         " Do time out on mappings and others
set timeoutlen=1000 " Wait {num} ms before timing out a mapping

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

set ambiwidth=single
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cursorline
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" no duplicates in ctags results tray due to file system case sensitivity
" issue: https://vi.stackexchange.com/a/6001
set tags=tags
set tags^=./.git/tags;

""""""""""""""""""""""
" colorscheme config "
""""""""""""""""""""""
" Enable highlighting syntax
syntax on
set t_Co=256 " 256 colors
function! <SID>darkMode()
  highlight ALEError ctermbg=18
  " let g:lightline = {
  "       \ 'colorscheme': 'srcery'
  "       \ }
  " let g:srcery_italic = 1
  " colorscheme srcery
  colorscheme synthwave

  augroup colorschemetoggle
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=233
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
  augroup END
endfunction

function! <SID>lightMode()
  highlight ALEError ctermbg=15
  let g:lightline = {
        \ 'colorscheme': 'default',
        \ }
  colorscheme default
  set background=light
  augroup colorschemetoggle
    autocmd!
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=231
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=255
  augroup END
endfunction

function! <SID>ToggleDarkLightMode()
  if &background ==# 'dark'
    call <SID>darkMode()
  else
    call <SID>lightMode()
  endif
endfunction

nnoremap <Leader>bg :call <SID>ToggleDarkLightMode()<CR>

let dark = systemlist('defaults read -g AppleInterfaceStyle')

if !empty(dark) && dark[0] ==# 'Dark'
  " if v:shell_error ==# '0' " dark mode
  call <SID>darkMode()
else
  call <SID>lightMode()
endif

" optional yamllint config from: https://www.arthurkoziel.com/setting-up-vim-for-yaml/
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '⚠'
" let g:ale_lint_on_text_changed = 'never'

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2

set wildmode=longest,list
set wildmenu
" old status line before powerline
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)\ [%{&fo}]
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

let g:ruby_indent_assignment_style = 'variable'

" rainbow plugin
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['red', 'darkcyan', 'darkmagenta', 'darkblue', 'darkred', 'cyan', 'magenta', 'green'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'tex': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
\       },
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\       },
\       'vim': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
\       },
\       'html': {
\           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
\       },
\       'css': 0,
\   }
\}

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line('.')
  let c = col('.')
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 1
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_javascript_eslint_exec = "node_modules/.bin/eslint"
let g:syntastic_ruby_checkers = ['mri']
let g:syntastic_sh_shellcheck_args = '-x'

set omnifunc=syntaxcomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
"noremap <C-]> g<C-]>


autocmd FileType make set noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal indentexpr=

"autocmd FileType ruby setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*#'
"autocmd FileType javascript setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'[^\s\|]\*'

let g:gitgutter_max_signs = 1000
let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
let g:gitgutter_sign_modified_removed = emoji#for('collision')
set completefunc=emoji#complete

autocmd BufNewFile,BufRead *.yml.example set filetype=yaml
autocmd BufNewFile,BufRead *.pdf.prawn set filetype=ruby
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
autocmd BufNewFile,BufRead Jenkinsfile set filetype=groovy
autocmd BufNewFile,BufRead Dockerfile* set filetype=dockerfile

if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

" syntax sync minlines=10000
syntax sync fromstart
