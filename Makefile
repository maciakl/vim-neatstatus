deploy:
	git add .
	git commit -a
	git push
	cd $HOME/.vim/bundle/vim-neatstatus
	git pull
