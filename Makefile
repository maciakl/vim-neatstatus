deploy:
	git add .
	git commit -a
	git push
	cd ~/.vim/bundle/vim-neatstatus; \
		git pull origin master; \
		cd ../..; \
		git commit -a -m "Updtaded vim-neatstatus"; \
		git push

update:
	cd ~/.vim/bundle/vim-neatstatus; \
		git pull origin master; \
		cd ../..; \
		git commit -a -m "Updtaded vim-neatstatus"; \
		git push
