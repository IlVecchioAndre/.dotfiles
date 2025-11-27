" ========================================
" CONFIGURAZIONE VIM - Andrea Vigliani
" ========================================

" --- IMPOSTAZIONI ESSENZIALI (prima di tutto) ---
set nocompatible              " Disabilita compatibilità con vi
set encoding=utf-8            " Codifica UTF-8
filetype off                  " Richiesto per vim-plug

" ========================================
" PLUGIN (vim-plug)
" ========================================
call plug#begin('~/.vim/plugged')

" Essenziali
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'

" LaTeX
Plug 'lervag/vimtex'

" Completamento e snippet
Plug 'lifepillar/vim-mucomplete'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Editing
Plug 'jiangmiao/auto-pairs'

" Estetica
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'NLKNguyen/papercolor-theme'

"color picker
Plug 'ap/vim-css-color'

call plug#end()

" ========================================
" CONFIGURAZIONE PLUGIN
" ========================================

" --- ULTISNIPS (usa Ctrl+J per evitare conflitto con mucomplete) ---
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsEditSplit = "vertical"

" --- MUCOMPLETE (autocompletamento con Tab) ---
set completeopt+=menuone,noselect
set shortmess+=c
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_mappings = 1  " Disabilita mappature automatiche

" Mappa manualmente Tab per evitare conflitti
inoremap <expr> <Tab> mucomplete#tab_complete(1)
inoremap <expr> <S-Tab> mucomplete#tab_complete(-1)

inoremap jj <Esc>l " mappa jj al posto di esc e il capslock

" --- AUTO-PAIRS ---
let g:AutoPairsMapCR = 1
let g:AutoPairsMultilineClose = 1
let g:AutoPairs = {'(':')', '[':']', '{':'}', '"':'"', '`':'`','$':'$'}

" --- VIMTEX ---
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let maplocalleader = ","

"let g:vimtex_compiler_method = 'latexrun'
"let g:vimtex_compiler_latexrun = {
    \ 'build_dir' : 'latex.out',
    \ 'options' : [
    \   '--verbose-cmds',
    \   '--latex-args="-synctex=1"',
    \ ],
    \}

let g:vimtex_compiler_method = 'latexmk'
" Opzioni di compilazione
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'hooks' : [],
    \ 'options' : [
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

let g:vimtex_complete_close_braces = 1

" DISABILITA CONCEAL (mostra sempre i comandi reali)
let g:vimtex_syntax_conceal_disable = 1
let g:vimtex_view_general_viewer = 'zathura'
" Compila automaticamente quando salvi file .tex
augroup vimtex_config
  autocmd!
  autocmd BufWritePost *.tex VimtexCompileSS | VimtexView
augroup END

" --- LIGHTLINE ---
set laststatus=2              " Barra di stato sempre visibile
let g:lightline = {
\ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
    \   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
    \ }
    \ }

" --- INDENTLINE ---
" (configurazione di default va bene)

" ========================================
" ASPETTO E TEMA
" ========================================
set t_Co=256
set background=light
colorscheme PaperColor
"set termguicolors

let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.light': {
  \       'override' : {
  \         'color00' : ['', '15'],
  \         'color03' : ['#437d4e', '']
  \       }
  \     }
  \   }
  \ }
syntax enable                 " Abilita sintassi colorata
filetype plugin indent on     " Abilita riconoscimento tipo file

"" Carica i colori generati automaticamente
if filereadable(expand('~/.config/vim/colors-generated.vim'))
    source ~/.config/vim/colors-generated.vim
endif

"" Imposta background in base alla palette
"set background=dark           " Cambia in 'light' se usi palette chiare

" ========================================
" INTERFACCIA
" ========================================
set number                    " Mostra numeri di riga
set relativenumber            " Numeri relativi
set showcmd                   " Mostra comando parziale
set showmode                  " Mostra modalità corrente
set wildmenu                  " Menu completamento comandi
set wildmode=longest:full,full
set ruler                     " Mostra posizione cursore
set cursorline                " Evidenzia riga corrente

" ========================================
" RICERCA
" ========================================
set incsearch                 " Ricerca incrementale
set hlsearch                  " Evidenzia risultati ricerca
set ignorecase                " Ignora maiuscole/minuscole
set smartcase                 " Ma rispettale se scrivi maiuscole

" ========================================
" INDENTAZIONE E TAB
" ========================================
set autoindent                " Mantieni indentazione
set smartindent               " Indentazione intelligente
set expandtab                 " Usa spazi invece di tab
set tabstop=4                 " Tab = 4 spazi
set shiftwidth=4              " Indentazione = 4 spazi
set softtabstop=4             " Backspace cancella 4 spazi

" ========================================
" COMPORTAMENTO
" ========================================
set backspace=indent,eol,start " Backspace funziona ovunque
set clipboard=unnamed         " Usa clipboard sistema

" ========================================
" VISUALIZZAZIONE
" ========================================
set wrap                      " A capo automatico righe lunghe
set linebreak                 " Non spezzare parole
set scrolloff=5               " Mantieni 5 righe visibili sopra/sotto cursore
set sidescrolloff=5           " Mantieni 5 colonne visibili ai lati

" ========================================
" PRESTAZIONI
" ========================================
set lazyredraw                " Non ridisegnare durante macro

" ========================================
" MAPPATURE
" ========================================

" Leader key (default è \)
let mapleader = " "           " Usa spazio come leader

" Cancella evidenziazione ricerca
nnoremap <leader>h :nohlsearch<CR>

" Salva velocemente
nnoremap <leader>w :w<CR>

" Chiudi
nnoremap <leader>q :q<CR>

" Navigazione finestre standard
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" utilizza spazio+a per append
nnoremap <leader>a A
"spostati a inizio e fine riga usando - e _
nnoremap - $
"rimappiamo gj e gk in modo che siano solo J e K
"nnoremap j gj
"nnoremap k gk

" configurazioni personali layout italiano
inoremap æ à
inoremap € è
inoremap → ì
inoremap ø ò
inoremap ↓ ù
inoremap ò "
inoremap à $
inoremap ù /

inoremap + }
inoremap è {
inoremap ç <del>
inoremap ° +

nnoremap è {
nnoremap + }
vnoremap ù :
vnoremap - $

inoremap <C-n> <Right>
inoremap <C-b> <Left>

" Mappings comodi per clipboard
" Leader+y copia nella clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Leader+p incolla dalla clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

"Leader+z per la compilazione zathura
nnoremap <leader>z :VimtexView<CR>
nnoremap <leader>e :VimtexErrors<CR>
" ========================================
" AUTOCMD
" ========================================

" Torna all' ultima posizione quando riapri un file
augroup restore_cursor
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END

" Rimuovi spazi bianchi finali al salvataggio
augroup remove_trailing_spaces
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

" ========================================
" GUIDA RAPIDA
" ========================================
" COMPLETAMENTO:
"   Tab/Shift-Tab    → naviga completamento automatico
"   Ctrl+J           → espandi snippet UltiSnips
"   Ctrl+K           → torna indietro nello snippet
"
" LATEX (modalità normale):
"   ,ll              → compila (local leader = ,)
"   ,lv              → visualizza PDF
"   ,lc              → pulisci file temporanei
"
" GENERALI:
"   Space+w          → salva
"   Space+q          → chiudi
"   Space+h          → cancella highlight ricerca
"   Space+n          → toggle NERDTree
"   Ctrl+h/l         → naviga finestre sinistra/destra
"   Alt+j/k          → naviga finestre su/giù
