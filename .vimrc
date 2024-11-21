"  
"  Author:      Peter Martinson
"  Create Date: September 1, 2015
"  version: for writing
"  
"  type 'vim --version' to see where to save this file
"

set nocompatible

"  Plugin manager
execute pathogen#infect()
filetype plugin on

autocmd FileType sql setlocal commentstring=--\ %s

set tabstop=2                       " Tabs are 2 columns long
set expandtab                       " Typing Tab produces spaces, not tabs
set softtabstop=2                   " Typing Tab produces 2 spaces
set shiftwidth=2                    " '>' and '<' indents 2 spaces
set autoindent                      " Smart indenting
set number                          " Turn on line numbers
set nowrap                          " Do not wrap text
set linebreak                       " Don't break words at the wrap
set nolist                          " Don't show eol and other chars
set ignorecase                      " Ignore case while searching
set incsearch                       " Start highlighting as you type in search
set scrolloff=5                     " Scroll when 5 lines from top or bottom
set showcmd                         " Show current command & selection length
set t_Co=256                        " Use 256 colors
set nohlsearch                      " Do not highlight all occurrences of a search
set history=200                     " Keep history of 200 commands
set clipboard=unnamedplus           " Send yanks to the Windows clipboard!
syntax enable                       " Turn on syntax highlighting
au FileType * set fo-=c fo-=r fo-=o " kill the auto commenting!!
colorscheme gruvbox
" colorscheme default
set background=dark
set backspace=indent,eol,start
set guifont=Consolas:h9

let g:snipMate = { 'snippet_version' : 1 }

""""""""""""""
" Statusline "
""""""""""""""

set laststatus=2                    " Show statusline always
set statusline=
set statusline+=\ %t\ 
set statusline+=%#CursorLineNr#
set statusline+=%{fugitive#statusline()}
set statusline+=%*
set statusline+=\ \%m\%=
set statusline+=\ \%c\ \|\ %l\/%L\ (%p\%%)

"""""""""""""""
" Keybindings "
"""""""""""""""

"  slap in a shebang
nnoremap ! i#!/bin/sh<cr><esc>

"  open a file manager
nnoremap <space>e :Explore<cr>
nnoremap <space>v :Vexplore!<cr>
nnoremap <space>t :Texplore<cr>

"  Put in the current date
nnoremap gp "=strftime('%B %d, %Y')<cr>p
nnoremap gP "=strftime('%m/%d/%Y')<cr>p

" 80 character rule above current line
nnoremap <space>- O--------------------------------------------------------------------------------<esc>j0
"  Center text into a comment line
nnoremap <space>l :center 80<cr>hhv0llr_hvhs/*<esc>lvey$A <esc>pA*/<cr><esc>
"  Delete current line but leave a blank line there
nnoremap <space><space> 0d$
"  Copy an entire paragraph
nnoremap Y m`"*yip

" Run Fugitive's Git Status
nnoremap gs :Git<cr>

"  move screen lines with arrow keys
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
vmap <up> gk
vmap <down> gj

"  Switch splits using CTRL-<motion key>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"  Cycle through splits and tabs with \ -> save left pinky!
nnoremap \ <C-w>w
nnoremap <C-\> :only<cr>

"  Resize splits
nnoremap <C-Up> <C-W>>
nnoremap <C-Down> <C-W><
nnoremap = <C-W>=

"  Open the Quickfix window
nnoremap <space>q :copen<cr>
nnoremap <space>Q :cclose<cr>

"  Make K do something more predictable
nnoremap K k:echo "    -->  Caps Lock is ON !!  <--"<cr>

"""""""""""""""""""""""""
" SQL specific bindings "
"""""""""""""""""""""""""

"  01/01/2010 -> to_date('01/01/2010','MM/DD/YYYY')
nnoremap <space>sd viW<esc>a','MM/DD/YYYY')<esc>Bito_date('<esc>%%

"  TABLE_NAME -> drop table/create table TABLE_NAME
nnoremap <space>st yiWIdrop table <esc>A;<cr>create table <esc>pA nologging as<esc>0k

"  format list of values to -> (a, b, c, etc.)
nnoremap <space>s( vip:sort un<cr>vipk:s/\n/, /<cr>I(<esc>A)<esc>0

"  format list of values to -> ('a', 'b', 'c', etc.)
nnoremap <space>s' vip:sort u<cr>vip:s/^/'/<cr>vipk:s/\n/', /<cr>I(<esc>A')<esc>0

"  get a date range from 'From: <date> 	To: <date>'
nnoremap <space>sb I  and __date__ between '<esc>ldf Ea' and '<esc>ldf A'<esc>0f_

"  Reformat a query for Power BI
vnoremap q k:s/\n/#(lf)/g<cr>
nnoremap <space>p vipk:s/\n/#(lf)/g<cr>"+dd:echo "  -->  Yanked block as a Power Query string  <--"<cr>

"  Open a SQL scratch pad
nnoremap <silent> <space>sh :aboveleft vnew<cr>:set syntax=sql<cr>
nnoremap <silent> <space>sj :belowright new<cr>:set syntax=sql<cr>
nnoremap <silent> <space>sk :aboveleft new<cr>:set syntax=sql<cr>
nnoremap <silent> <space>sl :belowright vnew<cr>:set syntax=sql<cr>

"  Remove all the [brackets] from a query.  Useful for SQL Server Management Studio
nnoremap <space>s[ vip:s/\[//g<cr>vip:s/\]//g<cr>{


""""""""""""""""""""""""""""""
" Markdown Specific Bindings "
""""""""""""""""""""""""""""""

" underline with =
nnoremap M= yypVr=o<esc>

" underline with -
nnoremap M- yypVr-o<esc>

" Title a journal entry with the date
nnoremap Mt ggi# <esc>:put =strftime(\"%A\")<cr>ggJo<cr># <esc>:put =strftime(\"%B\ %d\,\ %Y\")<cr>kJkddyypVr-o<esc>

" Linkify something selected in Visual mode
vnoremap gl c[]<esc>Pla(LINK)<esc>

""""""""""""
" Commands "
""""""""""""

" Switch to a new Git branch named 'dev'
command! Dev Git checkout -b dev

"""""""""""""""""""
" Linter Settings "
"""""""""""""""""""

"  Run JSLint, or whatever linter you gots
" nmap <space>j :w<cr>:make<cr><cr>:copen<cr>

"  ALE

let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_lint_on_save = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


"""""""""""""""""""""""""""""""""""
" Abbreviations / Typo correction "
"""""""""""""""""""""""""""""""""""

iabbrev   pateint   patient
iabbrev   PATEINT   PATIENT
iabbrev   patietn   patient
iabbrev   PATIETN   PATIENT
iabbrev   patient_name  patient_name
iabbrev   PATIENT_NAME  PATIENT_NAME
iabbrev   patient_lname  patient_lname
iabbrev   patient_fname  patient_fname
iabbrev   patietn_lname  patient_lname
iabbrev   patietn_fname  patient_fname
iabbrev   patient_lnaem  patient_lname
iabbrev   patient_fnaem  patient_fname
iabbrev   PATIENT_LNAME  PATIENT_LNAME
iabbrev   PATIENT_FNAME  PATIENT_FNAME
iabbrev   PATIETN_LNAME  PATIENT_LNAME
iabbrev   PATIETN_FNAME  PATIENT_FNAME
iabbrev   PATIENT_LNAEM  PATIENT_LNAME
iabbrev   PATIENT_FNAEM  PATIENT_FNAME
iabbrev   adn       and
iabbrev   ADN       AND
iabbrev   soem      some
iabbrev   teh       the
iabbrev   joni      join
iabbrev   thsi      this
iabbrev   Thsi      This
iabbrev   becasue   because
iabbrev   Becasue   Because
iabbrev   informaiton information
iabbrev   Informaiton Information
iabbrev   disclaim _Disclaimer:  this post contains affiliate links.  If you click on them and buy the products, I'll get a cut of the profit._

"""""""""""""""""""""""""""""""
"  Get a writing environment  "
"""""""""""""""""""""""""""""""

" nnoremap <space>w :set nonumber<cr>:set wrap<cr>:setlocal spell spelllang=en_us<cr>:colorscheme gruvbox<cr>:set background=light<cr>:highlight Normal ctermbg=white ctermfg=black<cr>:set syntax=markdown<cr>:echo "  ]s next word\n  [s previous word\n  zG ignore the word\n  zg add word to dictionary"<cr>

nnoremap <space>w :set wrap<cr>:set nonumber<cr>:setlocal spell spelllang=en_us<cr>:colorscheme Tomorrow<cr>:set background=light<cr>:set syntax=markdown<cr>:nnoremap j gj<cr>:nnoremap k gk<cr>:echo "  ]s next word\n  [s previous word\n  zG ignore the word\n  zg add word to dictionary"<cr>

nnoremap <space>W :set number<cr>:set number<cr>:set nowrap<cr>:set nospell<cr>:colorscheme gruvbox<cr>:set background=dark<cr>:filetype detect<cr>nnoremap j j<cr>nnoremap k k

inoremap person<tab> Birth: _01/01/1900_<cr>Death: _01/01/1900_<cr>Location: _Wisconsin_<cr>Last Known Affiliation: _USAF_<cr>Job Title: _Spook_<cr><cr>

inoremap org<tab> Title: _someorg_<cr>Started: _1900_<cr>Ended: _1900_<cr>Country: _USA_<cr>Parent Organization:  _US State Department_<cr>Other Names:  _aka_<cr><cr>

nnoremap gy :Goyo<cr>

