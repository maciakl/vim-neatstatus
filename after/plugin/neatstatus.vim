" NeatStatus (c) 2012 Lukasz Grzegorz Maciak
" Neat and simple status line - because Powerline is overrated
"    _   _            _   ____  _        _             
"   | \ | | ___  __ _| |_/ ___|| |_ __ _| |_ _   _ ___ 
"   |  \| |/ _ \/ _` | __\___ \| __/ _` | __| | | / __|
"   | |\  |  __/ (_| | |_ ___) | || (_| | |_| |_| \__ \
"   |_| \_|\___|\__,_|\__|____/ \__\__,_|\__|\__,_|___/
"   Vim plugin by Luke Maciak (c) 2012
"
" Loosely based on a script by Tomas Restrepo (winterdom.com)
" " Original available here:
" http://winterdom.com/2007/06/vimstatusline

set ls=2 " Always show status line
let g:last_mode=""

" Color Scheme Settings
" You can redefine these in your .vimrc

if !exists('g:NSColor_normal')
    " Black on Green
    let g:NSColor_normal    = 'guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE'
endif

if !exists('g:NSColor_insert')
    " White on Red
    let g:NSColor_insert    = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold'
endif

if !exists('g:NSColor_replace')
    " Yellow on Blue
    let g:NSColor_replace='guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold'
endif

if !exists('g:NSColor_visual')
    " White on Purple
    let g:NSColor_visual='guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE'
endif

if !exists('g:NSColor_position')
    " White on Black
    let g:NSColor_position='guifg=#ffffff guibg=#000000 ctermfg=15 ctermbg=0'
endif

if !exists('g:NSColor_modified')
    " White on Pink
    let g:NSColor_modified='guifg=#ffffff guibg=#ff00ff ctermfg=15 ctermbg=5'
endif

if !exists('g:NSColor_line')
    " Pink on Black
    let g:NSColor_line='guifg=#ff00ff guibg=#000000 gui=bold ctermfg=207 ctermbg=0 cterm=bold'
endif

if !exists('g:NSColor_filetype')
    " Black on Cyan
    let g:NSColor_filetype='guifg=#000000 guibg=#00ffff gui=bold ctermfg=0 ctermbg=51 cterm=bold'
endif

"==============================================================================
"==============================================================================

" Set up the colors for the status bar
function! SetNeatstatusColorscheme()

    " Basic color presets
    exec 'hi User1 '.g:NSColor_normal
    exec 'hi User2 '.g:NSColor_replace
    exec 'hi User3 '.g:NSColor_insert
    exec 'hi User4 '.g:NSColor_visual
    exec 'hi User5 '.g:NSColor_position
    exec 'hi User6 '.g:NSColor_modified
    exec 'hi User7 '.g:NSColor_line
    exec 'hi User8 '.g:NSColor_filetype

endfunc

" pretty mode display - converts the one letter status notifiers to words
function! Mode()
    let l:mode = mode()

    if     mode ==# "n"  | return "NORMAL"
    elseif mode ==# "i"  | return "INSERT"
    elseif mode ==# "R"  | return "REPLACE"
    elseif mode ==# "v"  | return "VISUAL"
    elseif mode ==# "V"  | return "V-LINE"
    elseif mode ==# "^V" | return "V-BLOCK"
    else                 | return l:mode
    endif

endfunc    

" Change the values for User1 color preset depending on mode
function! ModeChanged(mode)

    if     a:mode ==# "n"  | exec 'hi User1 '.g:NSColor_normal
    elseif a:mode ==# "i"  | exec 'hi User1 '.g:NSColor_insert
    elseif a:mode ==# "r"  | exec 'hi User1 '.g:NSColor_replace
        "elseif a:mode ==# "v"  | exec 'hi User1 '.g:NSColor_visual
        "elseif a:mode ==# "V"  | exec 'hi User1 '.g:NSColor_visual
        "elseif a:mode ==# "^V" | exec 'hi User1 '.g:NSColor_visual
    else                   | exec 'hi User1 '.g:NSColor_visual
    endif

    " Sometimes in console the status line starts repeating so we redraw
    " there is probably a better way to fix this
    if !has('gui_running')
        redraw!
    endif
endfunc

"==============================================================================
"==============================================================================

if has('statusline')

    " set up color scheme now
    call SetNeatstatusColorscheme()

    " Status line detail:
    " -------------------
    "
    " %f    file name
    " %F    file path
    " %y    file type between braces (if defined)
    "
    " %{v:servername}   server/session name (gvim only)
    "
    " %<    collapse to the left if window is to small
    "
    " %( %) display contents only if not empty
    "
    " %1*   use color preset User1 from this point on (use %0* to reset)
    "
    " %([%R%M]%)   read-only, modified and modifiable flags between braces
    "
    " %{'!'[&ff=='default_file_format']}
    "        shows a '!' if the file format is not the platform default
    "
    " %{'$'[!&list]}  shows a '*' if in list mode
    " %{'~'[&pm=='']} shows a '~' if in patchmode
    "
    " %=     right-align following items
    "
    " %{&fileencoding}  displays encoding (like utf8)
    " %{&fileformat}    displays file format (unix, dos, etc..)
    " %{&filetype}      displays file type (vim, python, etc..)
    "
    " #%n   buffer number
    " %l/%L line number, total number of lines
    " %p%   percentage of file
    " %c%V  column number, absolute column number
    " &modified         whether or not file was modified
    "
    function! SetStatusLineStyle()

        let g:neatstatus_session = strlen(v:servername)>0? (v:servername) : 'term'

        let &stl=""
        " mode (changes color)
        let &stl.="%1*\ %{Mode()} %0*|" 
        " session name
        let &stl.="%5* %{g:neatstatus_session} %0*|"
        " file path
        let &stl.=" %<%F "
        " read only, modified, modifiable flags in brackets
        let &stl.="%([%R%M]%) "

        " right-aligh everything past this point
        let &stl.="%= "

        " readonly flag
        let &stl.="%(%{(&ro!=0?'(readonly)':'')} | %)"

        " file type (eg. python, ruby, etc..)
        let &stl.="%8*%( %{&filetype} %)%0*| "
        " file format (eg. unix, dos, etc..)
        let &stl.="%{&fileformat} | "
        " file encoding (eg. utf8, latin1, etc..)
        let &stl.="%(%{(&fenc!=''?&fenc:&enc)} | %)"
        " buffer number
        let &stl.="BUF #%n |" 
        "line number (pink) / total lines
        let &stl.="%5* LN %7*%l%5*/%L\ %0*| "
        " percentage done
        let &stl.="(%p%%) | "
        " column number
        let &stl.="COL %c%V |"
        " modified / unmodified (purple)
        let &stl.="%(%6* %{&modified ? 'modified':''} %)"

    endfunc

    au InsertEnter  * call ModeChanged(v:insertmode)
    au InsertChange * call ModeChanged(v:insertmode)
    au InsertLeave  * call ModeChanged(mode())

    " whenever the color scheme changes re-apply the colors
    au ColorScheme * call SetNeatstatusColorscheme()

    " Make sure the statusbar is reloaded late to pick up servername
    au ColorScheme,VimEnter * call SetStatusLineStyle()
    "au BufRead,BufNew,BufWritePost,FileWritePost,ColorScheme,VimEnter * call SetStatusLineStyle()

    " Switch between the normal and vim-debug modes in the status line
    nmap _ds :call SetStatusLineStyle()<CR>
    call SetStatusLineStyle()
    " Window title
    if has('title')
        set titlestring="%t%(\ [%R%M]%)".expand(v:servername)
    endif
endif
