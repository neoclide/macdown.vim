# Macdown.vim

A simplified and flexible markdown preview for vim user on Mac.
Using applescript instead of a server to enhance the exprience of live preview.

You can get the style preview [here](https://chemzqm.me/static/sample.html)

## Features

* No server, much better performance.
* Async markdown parse when possible (using jobstart of nvim/vim or vimproc)
* Works out of box, all dependencies are optional.
* Preview in Chrome with range and auto reload support.
* Auto close Chrome tab on buffer delete and vim exit.
* Tables, GFM enabled, code highlight and footnote enabled by default.
* Misaka parser support [smartypants](http://misaka.61924.nl/#misaka.smartypants),
toc (table of content) and unicode (including Emoji)

## Install

Take [vundle](https://github.com/VundleVim/Vundle.vim) as example:

    Plugin 'chemzqm/macdown.vim'

## Usage

To preview current markdown file, type:

    :Preview

Preview with range, eg:

    :1,10Preview

Or visual select a range, and use:

    :'<,'>Preview

To toggle auto preview for current file, type:

    :PreviewAuto

The corresponding chrome tab would be activated and refreshed on TextChanged and
TextChangedI. A handy remap could be:

    nnoremap <C-p> :PreviewAuto<CR>

## Configuration

By default `macdown.vim` using [markit](https://github.com/lepture/markit) for
markdown parsing, it's exists inside this repository, but if you need speed and
more future, you can set global variable:

    let g:macdown_marked_programme = 'misaka'

To enable misaka parse, it's almost 4 times faster than markit, but you need to
install python dependencies:

    pip install misaka pygments

`sudo` might be required.

You can also make your own parser, it's just create a excutable file inside
`macdown.vim/bin` which accept markdown content from stdin and output html to
stdout.

## TODO

* Scrollbind for vim and Chrome (vim doesn't support Scroll autocmd, bind
  CurseMove would be rediculious for me)
