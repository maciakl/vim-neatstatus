" NeatStatus (c) 2012 Lukasz Grzegorz Maciak
"
" Based on a script by Tomas Restrepo (winterdom.com)
" " Original available here:
" http://winterdom.com/2007/06/vimstatusline

set ls=2 " Always show status line

if has('statusline')

	" Status line detail:
	"
	" %f     file path
	" %y     file type between braces (if defined)
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

		    " file path
			let &stl="%f "
            " if not native display !
            let &stl.="%(%{'!'[&ff=='".&ff."']}"
			" read only, modified, modifiable flags in brackets
			let &stl.="%([%R%M]%) "

			" right-aligh everything past this point
			let &stl.="%= "

			" file type (eg. python, ruby, etc..)
			let &stl.="%(%{&filetype} | %)"
			" file format (eg. unix, dos, etc..)
			let &stl.="%{&fileformat} | "
			" file encoding (eg. utf8)
			let &stl.="%(%{&fileencoding} | %)"
			" buffer number
			let &stl.="BUF #%n | " 
			"line number / total lines
			let &stl.="LN %l/%L | "
			" percentage done
			let &stl.="(%p%%) | "
			" column number
			let &stl.="COL %c%V "

	endfunc

	" Switch between the normal and vim-debug modes in the status line
	nmap _ds :call SetStatusLineStyle()<CR>
	call SetStatusLineStyle()
	" Window title
	if has('title')
		set titlestring=%t%(\ [%R%M]%)
	endif
endif
