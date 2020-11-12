NVimFiles
===

This is my VIM configuration, it uses [Vim-Plug](https://github.com/junegunn/vim-plug) to manage plugins, NERDTree, Deoplete, Ale, UltiSnips and other fancy plugins.

## Table of contents

 - [Required Tools](#required-tools)
 - [Installation](#installaiton)
 - [Global Settings](global-settings)
 - [Vim Modules](#vim-modules)
 - [Mappings](#mappings)
 - [Links](#links)

## Required Tools

To use this configration you will need to install [nodeJS](https://nodejs.org/) and [Yarn](https://yarnpkg.com/).

## Installation

1) Clone this repository into your vim confuguration folder (`~/.config/nvim` for linux, `$HOME/AppData/Local/nvim` for windows).
    - Unix: `git clone https://github.com/chocolord/vimfiles ~/.config/nvim`
    - Windows: `git clone https://github.com/chocolord/vimfiles $HOME/AppData/Local/nvim`

2) Install the plugins with the `:PlugInstall` command

3) Install the node modules needed with the following command (you may need sudo on linux).

    yarn global add \
        babel-eslint \
        csslint \
        eslint-plugin-vue \
        eslint_d \
        instant-markdown

## Global Settings

| Setting  | Description |
| --- |--- |
| ai | auto indent
| nu | line numbers |
| sw=4 | shiftwidth set to 4 |
| ts=4 | tabstop set to 4 |
| et | expandtab |
| noswapfile | disable the swap file |
| nocompatible | Disable Vi compatibilities |
| syntax | enables the coloration of the syntax |
| colorscheme | sets the colors of the editor |
| fileencoding(s) | sets the encoding of the file |

## Vim Modules

| Module | description |documenttion |
| --- | --- |--- |
| ale | syntax linter |
| deoplete | autocompletion module |
| indentline | shows the indentation | https://github.com/yggdroot/indentline |
| nerdtree | file system explorer | https://github.com/scrooloose/nerdtree |
| ultisnips | snippets engine | https://github.com/SirVer/ultisnips |
| vim-colorschemes | colorshemes collection | https://github.com/flazz/vim-colorschemes |
| vim-encode | strings encoder | https://github.com/roxma/vim-encode |
| vim-fugitive | Git plugin | https://github.com/tpope/vim-fugitive |
| vim-instant-markdown | markdown viewer | https://github.com/suan/vim-instant-markdown |
| vim-lion | alignment tool | https://github.com/tommcdo/vim-lion |
| vim-multiple-cursors | multiple cursor edition | https://github.com/terryma/vim-multiple-cursors |
| vim-snippets | snippet collection | https://github.com/honza/vim-snippets |
| vim-speeddating | date formatting tool | https://github.com/tpope/vim-speeddating |
| vim-surround | text surrounding tool | https://github.com/tpope/vim-surround |
| vim-twig | twig plugin | https://github.com/evidens/vim-twig |
| vim-vue | VueJS component file syntax | https://github.com/posva/vim-vue |

## Mappings

The mappings are declared in the `init.vim` file.

**Leader key:** `-` 

| Mode | Mapping | Acions | Description | 
| --- | --- | --- |--- |
| INSERT | `jk` | `<esc>` | quit INSERT mode easily |
| NORMAL | `Ctrl+j` | `20j` | Scroll 20 lines down |
| NORMAL | `Ctrl+k` | `20k` | Scroll 20 lines up |
| INSERT | `Ctrl+<space>` | `Ctrl+n` | Browse autocompletion suggestions |
| NORMAL | `<leader>+s` | `:set hls!<CR>` | Enable/Disable search results highlighting |
| NORMAL | `<leader>+f` | `zf%` | Set a fold on the block (ex: fold a function) |
| NORMAL | `nt` | `:NERDTREEToogle<CR>` | Toggle the NERDTree pannel |
| NORMAL | `nb` | `:NERDTREEFromBookmark` | pre-type the `:NERDTreeFromBookmark` command |

## Links
  - Learn how to use Vim: [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/)
  - Find packages: [vimawesome](http://vimawesome.com/)
  - Find your color sheme: [vim colors](http://vimcolors.com/)
