essential:
	stow -v -t $$HOME -R tmux lvim

sync_zsh:
	stow -v -t $$HOME -R zsh

pre_zsh:
	./zsh_setup/zsh_setup.sh

pre:
	apt install stow
