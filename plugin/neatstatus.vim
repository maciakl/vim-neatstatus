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
	" %([%R%M]%)   read-only, modified and modifiable flags between braces
	"
	" %{'!'[&ff=='default_file_format']}
	"        shows a '!' if the file format is not the platform default
	"
	" %{'$'[!&list]}  shows a '*' if in list mode
	" %{'~'[&pm=='']} shows a '~' if in patchmode
	"
	" (%{synIDattr(synID(line('.'),col('.'),0),'name')})
	"        only for debug : display the current syntax item name
	"
	" %=     right-align following items
	"
	" #%n    buffer number
	"
	" %l/%L,%c%V   line number, total number of lines, and column number
	function SetStatusLineStyle()
		if &stl == '' || &stl =~ 'synID'
			let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=buff:#%n line:%l/%L col:%c%V "
		else
			let &stl="%f %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=buff:#%n line:%l/%L col%c%V "
		endif
	endfunc

	" Switch between the normal and vim-debug modes in the status line
	nmap _ds :call SetStatusLineStyle()<CR>
	call SetStatusLineStyle()
	" Window title
	if has('title')
		set titlestring=%t%(\ [%R%M]%)
	endif
endif
