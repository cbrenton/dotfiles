" General options
set viminfo='20,\"500,%
" ' Maximum number of previously edited files for
"   which the marks are remembered.
" " Maximum number of lines saved for each register.
" % When included, save and restore the buffer list.  If Vim is
"   started with a file name argument, the buffer list is not
"   restored.  If Vim is started without a file name argument, the
"   buffer list is restored from the viminfo file.  Buffers
"   without a file name and buffers for help files are not written
"   to the viminfo file.
set history=500      " keep {number} lines of command line history

" Tabs
set shiftwidth=2
set softtabstop=2       " spaces per tab press
set tabstop=2           " spaces used to represent tab characters in a file

" General {
   set autoindent          " follow current indentation
   set backspace=2         " let backspace delete any text, including newlines
   set cindent
   set cinoptions=:0,p0,t0
   set cinwords=if,unless,else,while,until,do,for,switch,case
   set cursorline          " current line highlight
   set cursorcolumn        " current line col highlight
   set expandtab           " don't output tabs; replace with spaces
   set formatoptions=tcqr
   set hlsearch            " highlight search terms
   set ignorecase          " ignore capitalization
   set incsearch           " highlight search terms as they are typed
   set laststatus=2        " make airline statusbar appear in all windows
   set nocompatible
   set number              " turn on line numbers
   set ruler
   set showbreak=+++\ \    " make breaks more obvious
   set showcmd             " show commands in status line when typing
   set showmatch
   set showmode            " show which mode (insert, replace, visual)
   set smartcase           " don't ignore case for capital letters
   set smartindent         " obey brace-indentation rules
   set title
   set t_Co=256            " use 256 color mode
   set wildmenu
   set wrap                " wrap lines
" }

syntax on                  " indentation

colorscheme molokai

" Vim-airline configuration
let g:airline_powerline_fonts = 1

" Allows non-root user to save write-protected files.
cmap w!! %!sudo tee > /dev/null %

" Place temporary files in a single location, rather than the current
" directory.
set backupdir=/var/tmp,/tmp
set directory=/var/tmp,/tmp

" Set leader to something reasonable.
let mapleader = "\<Space>"

" Make tabs and trailing spaces visible when requested.
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Make <leader>h turn off highlights from the last search.
nmap <leader>h :nohlsearch<CR>

" Make <leader>v open .vimrc in a new tab for editing.
nmap <leader>v :tabnew $MYVIMRC<CR>

nmap <leader>f :set foldmethod=indent<cr>zM<cr>
nmap <leader>F :set foldmethod=manual<cr>zR<cr>

" Source the vimrc file after saving it
if has("autocmd")
   augroup reload_vimrc " {
      autocmd!
      autocmd bufwritepost $MYVIMRC source $MYVIMRC
   augroup END " }
endif

filetype plugin indent on

"  Tab Clear up formatting by doing the following:
"  Ensure UNIX formatting (no CR chars, NL after the last line).
"  Insert a tab at the end of the current line (to avoid errors in next
"      step).
"  Then replace all tabs with 2 spaces.  That is, "detab".
"  Then, remove any spaces at the end of lines (this corrects the inserted
"      tab).
"  Then, clean up some annoying highlights in the file.
"  Note: this detabbing should work for tabs at the beginning of the line, but
"      will probably be somewhat wrong for tabs later in the line, but
"      wherever they used to be, they'll now be gone.
":map <Tab> mz:set fileformat=unix<cr>:set endofline<cr>A<C-V><Tab><esc>:%s/<C-V><Tab>/   /g<cr>:%s/\s*$//<cr>:nohlsearch<cr>ggVG=`z
:map <Tab> mz:set fileformat=unix<cr>:set endofline<cr>A<C-V><Tab><esc>:%s/\s*$//<cr>:nohlsearch<cr>ggVG=`z

" F6 works like tab, but works even in insert mode.
:map <F6> <Tab>
:imap <F6> <esc>mz<Tab>`za

" ABBREVIATIONS
:ab cmain <cr>iint main(int argc, char *argv[]) {<cr>return 0;<cr><bs>}<cr><esc>kkO<tab>   <esc>
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Toggle line numbers and fold column for easy copying:
nnoremap <Leader>n :set nonumber!<CR>:set foldcolumn=0<CR>

" Insert 'import pdb; pdb.set_trace()' before the current line with leader-p
nnoremap <leader>p Oimport pdb; pdb.set_trace()<Esc>

" Toggle paste mode with leader-P
nnoremap <leader>P :set nopaste!<CR>

" Leader-w to save a file
nnoremap <Leader>w :w<CR>
nnoremap <Leader>W :wq<CR>
nnoremap <Leader>b :bd<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa<CR>

" Jump to end of pasted lines
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Improved search/replace: yank selection with ys, change with cs
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Python-specific spacing
au FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl

ca tn tabnew
ca th tabp
ca tl tabn

" Easy split navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" CtrlP settings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" Vim-markdown settings
let g:vim_markdown_folding_disabled = 1

" Vim-plug
call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-sensible'
Plug 'sbdchd/neoformat'
Plug 'vim-ruby/vim-ruby'
Plug 'psf/black'
Plug 'hashivim/vim-terraform'

call plug#end()

" Neoformat
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_cpp = ['clang-format']
autocmd BufWritePre *.h,*.cc,*.cpp,*.py Neoformat

" Disable minibufexplorer. Ugh.
let g:loaded_minibufexplorer=1
