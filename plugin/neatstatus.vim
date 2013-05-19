" NeatStatus (c) 2012 Lukasz Grzegorz Maciak
"
" Based on a script by Tomas Restrepo (winterdom.com)
" " Original available here:
" http://winterdom.com/2007/06/vimstatusline

set ls=2 " Always show status line
let g:last_mode=""

" Basic color presets
hi User1 guifg=#000000  guibg=#7dcc7d   ctermfg=0  ctermbg=2    " BLACK ON GREEN
hi User2 guifg=#ffffff  guibg=#5b7fbb   ctermfg=15 ctermbg=67   " WHITE ON BLUE
hi User3 guifg=#000000  guibg=#FF0000   ctermfg=15 ctermbg=9    " BLACK ON ORANGE
hi User4 guifg=#ffffff  guibg=#810085   ctermfg=15 ctermbg=53   " WHITE ON PURPLE
hi User5 guifg=#ffffff  guibg=#000000   ctermfg=15 ctermbg=0    " WHITE ON BLACK
hi User6 guifg=#ffffff  guibg=#ff00ff   ctermfg=15 ctermbg=5    " WHITE ON PINK
hi User7 guifg=#ff00ff  guibg=#000000   ctermfg=207 ctermbg=0 gui=bold cterm=bold   " PINK ON BLACK
hi User8 guifg=#000000  guibg=#00ffff   ctermfg=0 ctermbg=51 gui=bold cterm=bold    " BLACK ON CYAN

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

    if     a:mode ==# "n"  | hi User1 guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE
    elseif a:mode ==# "i"  | hi User1 guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
    elseif a:mode ==# "r"  | hi User1 guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold
    "elseif a:mode ==# "v"  | hi User1 guifg=#ffffff guibg=#810085 ctermfg=15 ctermbg=53
    "elseif a:mode ==# "V"  | hi User1 guifg=#ffffff guibg=#810085 ctermfg=15 ctermbg=53
    "elseif a:mode ==# "^V" | hi User1 guifg=#ffffff guibg=#810085 ctermfg=15 ctermbg=53
    else                   | hi User1 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE
    endif

endfunc

" Return a string if file is modified or empty string if its not
function! Modified()
    let l:modified = &modified

    if modified == 0
        return ''
    else
        return 'modified'
endfunc

if has('statusline')

    " Status line detail:
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
    "
    function! SetStatusLineStyle()

        let &stl=""
        " mode (changes color)
        let &stl.="%1*\ %{Mode()} %0*|" 
        " session name
        if v:servername!=''
            let &stl.="%5* %{v:servername} %0*|"
        endif
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
        let &stl.="%(%6* %{Modified()} %)"

        
    endfunc

    au InsertEnter * call ModeChanged(v:insertmode)
    au InsertChange * call ModeChanged(v:insertmode)
    au InsertLeave * call ModeChanged(mode())

    " Switch between the normal and vim-debug modes in the status line
    nmap _ds :call SetStatusLineStyle()<CR>
    call SetStatusLineStyle()
    " Window title
    if has('title')
        set titlestring=%t%(\ [%R%M]%)
    endif
endif
