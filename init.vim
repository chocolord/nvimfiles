source ~/AppData/Local/nvim/plug.vim

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ale'

Plug 'flazz/vim-colorschemes'       "colorschemes
Plug 'yggdroot/indentline'          "indentations
Plug 'tpope/vim-surround'           "surrounding
Plug 'tommcdo/vim-lion'             "alignement
Plug 'tpope/vim-speeddating'        "manipulations de dates

Plug 'preservim/nerdcommenter'      "The NERD Commenter
Plug 'SirVer/ultisnips'             "Snippets engine
Plug 'honza/vim-snippets'           "Common snippets
" Plug 'albanm/vuetify-vim'           "Vuetify snippets
Plug 'terryma/vim-multiple-cursors' "Multiple cursors

Plug 'evidens/vim-twig'             "Twig syntax colors
Plug 'digitaltoad/vim-pug'          "Pug syntax colors
Plug 'kchmck/vim-coffee-script'     "CoffeeScript sybtax & Cie
Plug 'posva/vim-vue'                "Vue files syntax colors

Plug 'vim-scripts/npm'               "NPM cli tool
Plug 'roxma/vim-encode'              "encode strings
" Plug 'suan/vim-instant-markdown'     "apercu markdown live

call plug#end()

set ai nu ts=4 sw=4 expandtab noswapfile nocompatible modeline modelines=5 nohls mouse=a
set vb t_vb=
syntax on
colorscheme deus

set fileencodings=utf-8
set fileencoding=utf-8
set encoding=utf-8

let mapleader = "-"

inoremap jk <esc>
inoremap <c-space> <c-n>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
nnoremap <c-j> 30j
nnoremap <c-k> 30k
nnoremap <leader><c-s> :setl hls!<CR>
nnoremap <leader>f zf%
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap nt :NERDTreeToggle<CR>
nnoremap nf :NERDTreeFind 
nnoremap nb :NERDTreeFromBookmark 

" Copy-Past mappgins
inoremap <S-Insert> <C-R>*

" Ouvre le fichier du point de la semaine et le fichier de l'activité.
function! TODO()
	tabnew $HOME/OneDrive\ -\ IZITEK/point\ semaine.txt
	vsplit $HOME/OneDrive\ -\ IZITEK/activite\ semaine.txt
	normal G$
endfunction

function! Latin1()
	edit ++enc=latin1
    call deoplete#disable()
	" call youcompleteme#DisableCursorMovedAutocommands()
endfunction

function! Utf8()
	edit ++enc=utf8
    call deoplete#enable()
	" call youcompleteme#EnableCursorMovedAutocommands()
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.warning + l:counts.style_warning

    if l:counts.error > 0
        let l:problem = ale#statusline#FirstProblem(bufnr(''), 'error')
        echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
    elseif l:counts.style_error
        let l:problem = ale#statusline#FirstProblem(bufnr(''), 'style_error')
        echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
    elseif l:counts.warning
        let l:problem = ale#statusline#FirstProblem(bufnr(''), 'warning')
        echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
    elseif l:counts.style_warning
        let l:problem = ale#statusline#FirstProblem(bufnr(''), 'style_warning')
        echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
    endif

    return l:counts.total == 0 ? '' : printf('%dW %dE', all_warnings, all_errors)
endfunction

command! -n=0 TODO call TODO()
command! -n=0 PointSemaine :!start C:\Users\user\vimfiles\bin\pointSemaine.bat
command! -n=0 NewSemaine :normal Ilundi <esc>Yp<C-A>p2<C-A>p3<C-A>p4<C-A>_~_k_~_k_~_k_~_k_~_o<esc>Yjpjpjpj
command! -n=0 Latin1 call Latin1()
command! -n=0 Utf8 call Utf8()
command! -n=0 StartEslintD !eslint_d start

set statusline=%F " Full path of current file
set statusline+=\ %y " filetype of current file
set statusline+=\ %m " modified status
set statusline+=%= " section separation
set statusline+=%{LinterStatus()}
set statusline+=%= " section separation
set statusline+=%c,%l/%L " column,line/lines

" cd $HOME
" :let $DESKTOP='C:/users/user/desktop'

" Basic Ultisnips configuratino
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="²²"

let g:UltiSnipsSnippetDirectories=['~/AppData/Local/nvim/UltiSnips']
let g:UltiSnipsSnippetDirectories=[$HOME.'/vimfiles/UltiSnips']
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

if exists('no_ycm') && no_ycm
    Latin1
endif

" NERDCommenter Configuraiton
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1 " Set a language to use its alternate delimiters by default
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not 
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
            \ 'c': { 'left': '/**','right': '*/' },
            \ 'js': { 'left': '/**','right': '*/' }
            \ } " Add your own custom formats or override the defaults

"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1

let g:deoplete#enable_at_startup = 1

function g:Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

let g:python3_host_prog = 'python'





