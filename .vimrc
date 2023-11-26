
""" Map leader to space ---------------------
let mapleader=" "

" Show a few lines of context around the cursor. Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set showmode
set so=5
set incsearch
set nu

set surround
set multiple-cursors
" set commentary
set argtextobj
set easymotion
set ideaJoin
set relativenumber

set ideastatusicon=gray

" --- Enable IdeaVim plugins https://jb.gg/ideavim-plugins

" Highlight copied text
Plug 'machakann/vim-highlightedyank'
" Commentary plugin
Plug 'tpope/vim-commentary'

nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^

nmap <C-l> :bnext <CR>
nmap <C-h> :bprev <CR>



nnoremap <leader>ff workbench.action.quickOpen
nnoremap <leader>fp workbench.action.openRecent

" Going back to normal mode
inoremap jk <Esc>
inoremap kj <Esc>

vmap <leader>y "+y
nmap <leader>y "+yy

" Visual Mode
vmap <S-J> editor.action.moveLinesDownAction
vmap <S-K> editor.action.moveLinesUpAction

" Window Splitting
nnoremap <leader>sv :vsplit <CR>
nnoremap <leader>sh :spit <CR>
nnoremap <leader>v :action NextSplitter <CR>
nnoremap <leader>sc :action UnsplitAll <CR>

nmap <leader>z workbench.action.toggleZenMode
nmap <leader>c workbench.action.closeActiveEditor
" Select all
nnoremap <C-A> gg<S-v>G


nnoremap <C-r> :%s//