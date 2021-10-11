" starts python3
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

source ~/.config/nvim/plug.vim

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'dense-analysis/ale'

Plug 'neovim/nvim-lspconfig'        "LSP client/framework

" PhpActor
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*'}
Plug 'kristijanhusak/deoplete-phpactor'

Plug 'scrooloose/nerdtree'          "file explorer
" Plug 'flazz/vim-colorschemes'       "colorschemes
Plug 'yggdroot/indentline'          "indentations
Plug 'tpope/vim-surround'           "surrounding
Plug 'tommcdo/vim-lion'             "alignement
Plug 'tpope/vim-speeddating'        "manipulations de dates

Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" Plug 'romgrk/barbar.nvim'           "supertab line
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'} "superstatus line

Plug 'preservim/nerdcommenter'      "The NERD Commenter
Plug 'SirVer/ultisnips'             "Snippets engine
Plug 'honza/vim-snippets'           "Common snippets
" Plug 'albanm/vuetify-vim'           "Vuetify snippets
Plug 'terryma/vim-multiple-cursors' "Multiple cursors

Plug 'evidens/vim-twig'             "Twig syntax colors
Plug 'posva/vim-vue'                "Vue files syntax colors

Plug 'tpope/vim-fugitive'           "Git wrapper
Plug 'roxma/vim-encode'             "encode strings
Plug 'morhetz/gruvbox'              "gruvbox colorscheme

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

call plug#end()

set ai nu ts=4 sw=4 expandtab noswapfile nocompatible modeline modelines=5 nohls mouse=a fileformat=unix scrolloff=6 clipboard+=unnamedplus
set vb t_vb=
syntax on
colorscheme gruvbox

set fileencodings=utf-8
set fileencoding=utf-8
set encoding=utf-8

let mapleader = "-"
nmap <space> -

" insertion mappings
inoremap jk <esc>
inoremap JK <esc>
inoremap <c-space> <c-n>
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

"normal mode mappings
nnoremap <c-j> 30j
nnoremap <c-k> 30k
nnoremap <leader><c-s> :setl hls!<CR>
nnoremap <leader>f zf%
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff<CR>
nnoremap <leader>du :diffupdate<CR>
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tsh :tabnew<CR>:terminal<CR>A
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind 
nnoremap <leader>nb :NERDTreeFromBookmark 
nnoremap <leader>bn :BlocNotes<CR>
nnoremap <leader>B <c-V>
nnoremap <leader>p :Leaderf file<CR>
nnoremap <leader>P :Leaderf 

" terminal mappgins
tnoremap <Esc> <C-\><C-n>
tnoremap <c-j><c-k> <C-\><C-n>

" Visual mapping to execute the selection
vnoremap <c-x> "xy:@x<CR>

" Copy-Past mappgins
inoremap <S-Insert> <C-R>*

" Ouvre le fichier du point de la semaine et le fichier de l'activité.
function! TODO()
  	tabnew ~user/windows/home/OneDrive\ -\ IZITEK/point\ semaine.txt
  	vsplit ~user/windows/home/OneDrive\ -\ IZITEK/activite\ semaine.txt
    setl filetype=todo
  	normal G7k
endfunction

function! Latin1()
	edit ++enc=latin1
    call deoplete#disable()
endfunction

function! Utf8()
	edit ++enc=utf8
    call deoplete#enable()
endfunction

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))
"
"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_warnings = l:counts.warning + l:counts.style_warning
"
"     if l:counts.error > 0
"         let l:problem = ale#statusline#FirstProblem(bufnr(''), 'error')
"         echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
"     elseif l:counts.style_error
"         let l:problem = ale#statusline#FirstProblem(bufnr(''), 'style_error')
"         echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
"     elseif l:counts.warning
"         let l:problem = ale#statusline#FirstProblem(bufnr(''), 'warning')
"         echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
"     elseif l:counts.style_warning
"         let l:problem = ale#statusline#FirstProblem(bufnr(''), 'style_warning')
"         echom printf('line %d, col %d: %s', problem.lnum, problem.col, problem.text)
"     endif
"
"     return l:counts.total == 0 ? '' : printf('%dW %dE', all_warnings, all_errors)
" endfunction

function! NewSemaine()
    let l:monday = localtime() - (strftime('%w') - 1)*24*60*60
    normal o_________________________________
    normal o
    put =strftime('%A %d/%m', l:monday) 
    normal _vU
    for d in [1,2,3,4]
        normal o
        put =strftime('%A %d/%m', l:monday+24*60*60*d)
        normal _vU
    endfor
    :%s/\<Monday\>/Lundi
    :%s/\<Tuesday\>/Mardi
    :%s/\<Wednesday\>/Mercredi
    :%s/\<Thursday\>/Jeudi
    :%s/\<Friday\>/Vendredi
endfunction

command! -n=0 TODO call TODO()
nnoremap <leader>todo :TODO<CR>
" command! -n=0 PointSemaine :!start C:\Users\user\vimfiles\bin\pointSemaine.bat
command! -n=0 BlocNotes :tabnew
command! -n=0 NewSemaine :call NewSemaine()
command! -n=0 Latin1 call Latin1()
command! -n=0 Utf8 call Utf8()
command! -n=0 StartEslintD !eslint_d start

" set statusline=%F " Full path of current file
" set statusline+=\ %y " filetype of current file
" set statusline+=\ %m " modified status
" set statusline+=%= " section separation
" set statusline+=%{LinterStatus()}
" set statusline+=%= " section separation
" set statusline+=%c,%l/%L " column,line/lines

" cd $HOME
" :let $DESKTOP='C:/users/user/desktop'

" Basic Ultisnips configuratino
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="²²"

let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips']
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:deoplete#enable_at_startup = 1

function g:Multiple_cursors_before()
  call deoplete#custom#buffer_option('auto_complete', v:false)
endfunction
function g:Multiple_cursors_after()
  call deoplete#custom#buffer_option('auto_complete', v:true)
endfunction

let g:Lf_WindowPosition = 'popup'

" LSP configurations
" luado require'lspconfig'.phpactor.setup{}
let g:phpactorPhpBin = '/home/user/.config/nvim/plugged/phpactor/bin'
lua << EOF
require'lspconfig'.phpactor.setup{
    cmd = { '/home/user/.config/nvim/plugged/phpactor/bin/phpactor' }
}
require'lspconfig'.vuels.setup{
    cmd = { '/home/user/.config/yarn/global/node_modules/.bin/vls' }
}
require'lspconfig'.dockerls.setup{
    cmd = { '/home/user/.config/yarn/global/node_modules/.bin/docker-langserver' }
}
require'lspconfig'.bashls.setup{
    cmd = { '/home/user/.config/yarn/global/node_modules/.bin/bash-language-server' }
}
require'lspconfig'.sqlls.setup{
    cmd = { '/home/user/.config/yarn/global/node_modules/.bin/sql-language-server' }
}
EOF

" VIM extensions configurations
source ~/.config/nvim/config/NERDTree.conf.vim

" LUA extensions configurations
luafile ~/.config/nvim/lua/eviline.lua
