#! /bin/bash

# this script automates setting up the environment

# the current script path
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# ---------------------------------------------------------------------------------------
# update package manager

sudo apt upgrade --yes
sudo apt-get update --yes
sudo apt-get upgrade --yes
sudo apt-get dist-upgrade --yes

# ---------------------------------------------------------------------------------------
# make dot files

if [ ! -d "$dot_config" ]; then
    git clone --depth=1 https://github.com/hgl71964/dot_config.git
fi
cp dot_config/.vimrc dot_config/.zshrc .

# this overwrite the default prompt config
echo 'PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~  %(?.%{$fg[green]%}√.%{$fg[red]%}x)%b "' >> .zshrc

# clean up
rm -rf dot_config

# ---------------------------------------------------------------------------------------
# make zsh tools
if [ ! -d "$git_repo" ]; then
    mkdir git_repo
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git git_repo/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git git_repo/zsh-autosuggestions
fi

# ---------------------------------------------------------------------------------------
# cli for linux sys

echo 'alias ls="ls --color=auto"' >> .zshrc
echo 'alias grep="grep --color=auto"' >> .zshrc

# ---------------------------------------------------------------------------------------
# example of installing python3
# apt install python3-pip

# example of un-install python3
# apt remove <package name>
# apt autoremove --purge

# ---------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------
