" NeatStatus (c) 2012 Lukasz Grzegorz Maciak
"
" Based on a script by Tomas Restrepo (winterdom.com)
" " Original available here:
" http://winterdom.com/2007/06/vimstatusline

set ls=2 " Always show status line

hi User1 guibg=#7dcc7d                  " GREEN
hi User2 guifg=#ffffff  guibg=#5b7fbb   " BLUE
hi User3 guifg=#ffffff  guibg=#F4905C   " ORANGE
hi User4 guifg=#ffffff  guibg=#810085   " PURPLE

" pretty mode display
function! Mode()
    let l:mode = mode()

    if     mode ==# "n"  | return "NORMAL"
    elseif mode ==# "i"  | return "INSERT"
    elseif mode ==# "R"  | return "REPLACE"
    elseif mode ==# "v"  | return "VISUAL"
    elseif mode ==# "V"  | return "V�LINE"
    elseif mode ==# "^V" | return "V�BLOCK"
    else                 | return l:mode
    endfunc    

    function! Modified()
        let l:modified = &modified

        if modified == 0
            return 'unmodified'
        else
            return 'modified'
    endfunc

        if has('statusline')

            " Status line detail:
            "
            " %f     file name
            " %F    file path
            " %y    file type between braces (if defined)
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
                " mode
                let &stl.="%1*\ %{Mode()} %0* " 
                " file path
                let &stl.="%F "
                " read only, modified, modifiable flags in brackets
                let &stl.="%([%R%M]%) "

                " right-aligh everything past this point
                let &stl.="%= "

                " file type (eg. python, ruby, etc..)
                let &stl.="%(%{&filetype} | %)"
                " file format (eg. unix, dos, etc..)
                let &stl.="%{&fileformat} | "
                " file encoding (eg. utf8, latin1, etc..)
                let &stl.="%(%{(&fenc!=''?&fenc:&enc)} | %)"
                " buffer number
                let &stl.="BUF #%n |" 
                "line number / total lines
                let &stl.="%4* LN %l/%L\ %0*| "
                " percentage done
                let &stl.="(%p%%) | "
                " column number
                let &stl.="COL %c%V |"
                " modified / unmodified (purple)
                let &stl.="%2* %{Modified()} "
            endfunc

            " Switch between the normal and vim-debug modes in the status line
            nmap _ds :call SetStatusLineStyle()<CR>
            call SetStatusLineStyle()
            " Window title
            if has('title')
                set titlestring=%t%(\ [%R%M]%)
            endif
        endif
