essential:
	stow -v -t $$HOME -R tmux lvim

sync_hypr:
	stow -v -t $$HOME -R zsh

sync_zsh:
	stow -v -t $$HOME -R hypr

pre_zsh:
	./zsh_setup/zsh_setup.sh

pre:
	apt install stow
