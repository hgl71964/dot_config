#!/bin/bash

cp ./dot_config/.vimrc /root
cp ./dot_config/.zshrc /root
source /root/.zshrc


autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
