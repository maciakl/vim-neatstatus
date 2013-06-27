deploy:
	git add .
	git commit -a
	git push
	cd ~/.vim/bundle/vim-neatstatus
	git pull
