#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

HAS_ZSH=$(command -v zsh)

if [ -z "$HAS_ZSH" ]; then
	echo "Zsh is not installed. Installing zsh..."
	sudo apt install zsh -y
else
	echo "Zsh is installed. Setting up zsh..."
fi

echo "Setting zsh as default shell..."

chsh -s $(which zsh)

echo "Installing oh-my-zsh..."
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" &

echo "Sleeping for 10 seconds to let oh-my-zsh finish installation..."
sleep 10

echo  "Installing zsh-syntax-highlighting..."
sudo apt install zsh-syntax-highlighting -y

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Copying .zshrc to home directory..."
cp ../zsh/.zshrc ~/.zshrc

echo "Installing p10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Install the recommended font from here: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#meslo-nerd-font-patched-for-powerlevel10k"



