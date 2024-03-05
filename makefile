essential:
	stow -v -t $$HOME -R tmux lvim

pre_zsh:
	./zsh_setup/install.sh

pre:
	apt install stow
