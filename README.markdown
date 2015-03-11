Neat Status Line
===

[![endorse](https://api.coderwall.com/luke/endorsecount.png)](https://coderwall.com/luke)

Yet another status line plugin. The aim of Neat Status is to provide neat, and 
simple UI with just basic information and no bells and whistles for those users
who consider things like Powerline to be overkill.

Neat Status is loosely based on the status line script created by Tomas Restrepo.
The original can be seen here:

  * http://winterdom.com/2007/06/vimstatusline

The basic idea is roughly the same, but the script was heavily modified and made
more customizable and modular to work better as a plugin rather than just a
`.vimrc` snippet.

**Note:** this is not a drop-in replacement for Powerline but rather a much
simpler and streamlined plugin. The aim of the project is not to achieve one
to one feature compatibility but merely to implement a narrow subset of said
features for users who want something simple and easy. If you would like a
robust, feature-full Powerline replacement you should check out [Vim-Airline][va].

Screenshots
-----------

Here is how this status line will look in Gvim on Windows with the Solarized color scheme:

![Neat Statusline][ns]

Information provided from left to right:

* Mode Indicator - changes color depending on the editor mode
* Server/Session - displays vim servername (graphical) or terminal name (cli)
* File path for the file associated with current buffer
* File type (eg. python, ruby, etc..)
* File format (eg. unix, dos, etc..)
* File encoding (eg. utf8, latin1, etc..)
* Buffer number
* Current line, total number of lines (purple box)
* Percentage of file read
* Relative column number (from first character)
* Absolute column number (from start of line)
* Modified / Unmodified (blue box)

Installation
---

To install with Pathogen:

    cd ~/.vim/bundle
    git clone git://github.com/maciakl/vim-neatstatus.git

If your .vim is under source control with Git do this instead:

    cd ~/.vim
    git submodule add git://github.com/maciakl/vim-neatstatus.git bundle/vim-neatstatus
    git submodule init
    git submodule update

Installing without pathogen:

  * Copy `neatstatus.vim` to `~/.vim/after/plugins` directory

Configuration
---

You can configure the colors of the status line elements by defining the following global vars in your `.vimrc`:

* `g:NeatStatusLine_color_normal` - the color of the mode indicator when in normal mode
* `g:NeatStatusLine_color_insert` - the color of the mode indicator when in insert mode
* `g:NeatStatusLine_color_replace` - the color of the mode indicator when in replace mode
* `g:NeatStatusLine_color_position` - the color of the cursor position box (and session box)
* `g:NeatStatusLine_color_line` - the color of the line number in the cursor position box
* `g:NeatStatusLine_color_modified` - the color of the "modified" indicator on the right
* `g:NeatStatusLine_color_filetype` - the color of the filetype box

Make sure you define values both for graphical and terminal clients when you do this. Here is
a quick example that shows you hot to redefine the insert mode colors:

    let g:NeatStatusLine_color_insert = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold'

Note that these only affect the small boxes created by NeatStatus. Your status line will remain
the default color as per your color scheme. This works very well if you also happen to use the
Obvious-Mode plugin. 

If you want to style your status line, you can do it in your `.vimrc` normally using the `hi StatusLine`
and `hi StatusLineNC` commands.

You can also change the separator character that divides the boxes by changing:

* `g:NeatStatusLine_separator`

By default the separator is set to the pipe `|` character. You can disable the separator by setting it to empty string.

[ns]: http://i.imgur.com/7ySiHql.png "Neat Statusline"
[va]: https://github.com/bling/vim-airline
