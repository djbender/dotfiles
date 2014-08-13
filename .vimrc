" This is Derek Bender's .vimrc file
" vim:set ts=2 sts=2 sw=2 expandtab:

source /usr/local/lib/python2.7/site-packages/powerline/bindings/vim/plugin/powerline.vim

call pathogen#infect()

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" display incomplete commands
set showcmd
" Fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100

set hidden
set visualbell
set number
set paste
set nocompatible
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif
set ambiwidth=single
"if version >= 700
"  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
"  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
"endif
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
" display incomplete commands
set showcmd
" Enable highlighting syntax
syntax on
set t_Co=256 " 256 colors
set background=light
color default
filetype plugin indent on
set encoding=utf-8

set wildmode=longest,list
set wildmenu
" old status line before powerline
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)\ [%{&fo}]
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" " Indent if we're at the beginning of a line. Else, do completion.
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

autocmd Filetype markdown setlocal tw=74 fo+=t wm=0 spell spelllang=en_us

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

autocmd FileType ruby,eruby :let g:AutoCloseExpandEnterOn=""
autocmd Filetype gitcommit setlocal spell textwidth=72

"if version >= 703
"  function! NumberToggle()
"    if(&relativenumber == 1)
"      set number
"    else
"      set relativenumber
"    endif
"  endfunc
"
"nnoremap <C-n> :call NumberToggle()<cr>
"autocmd FocusLost * :set number
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set relativenumber
"autocmd CursorMoved * :set relativenumber
"endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  let rake_task = match(current_file, 'tasks') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = substitute(new_file, '\.e\?rake$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else "going to source
    if rake_task
      let new_file = substitute(new_file, '_spec\.rb$', '.rake', '')
    else
      let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    end
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
let mapleader=","
nnoremap <leader>. :call OpenTestAlternate()<cr>
let mapleader="\\"

" for go
"filetype off
"filetype plugin indent off
"set runtimepath+=/usr/local/go/misc/vim
"filetype plugin indent on
"au BufRead,BufNewFile *.md set filetype=markdown
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
highlight clear SignColumn
