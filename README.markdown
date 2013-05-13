Neat Status Line
===

This is a modified version of a nice vim status line script created by Tomas Restrepo.
The original can be seen here:

  * http://winterdom.com/2007/06/vimstatusline

This version has small readability modifications. Main purposed of hosting it here is
to make this script compatible with Pathogen plugin manager.

Screenshots
-----------

Here is how this status line will look in Gvim on Windows with the Solarized color scheme:

![Neat Statusline][ns]

Information provided from left to right:

* Vim Mode (green box)
* File path
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

  * Copy `neatstatus.vim` to `~/.vim/plugins` directory

  [ns]: http://i.imgur.com/DkU6RNP.jpg "Neat Statusline"
