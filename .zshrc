
#git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/git_repo/zsh-syntax-highlighting
#git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/git_repo/zsh-autosuggestions

### syntax-highligh
# see: https://github.com/zsh-users/zsh-syntax-highlighting; put right path
source $HOME/git_repo/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
### end of syntax-highlight


### syntax-autosuggestion
# see: https://github.com/zsh-users/zsh-autosuggestions.git
source $HOME/git_repo/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"  # configurable
### end of syntax-autosuggestion



### command short hand
alias ll="ls -al"
alias tre="tree -CL 2"
### end of short hand

### git
alias gs="git status"
# visual last 10 via graph
alias "ggraph"="git log --oneline -n 10 --graph --color --all --decorate"
### end of git

### tmux
alias tm=tmux
### end of tmux

### make
alias mk='make'
alias mj='make -j$(nproc)'
alias mc='make clean'
### end of make

### AWS
alias aws='docker run --rm -it amazon/aws-cli'
# auto apply credential + mount file system
#  alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
### end of AWS

### python
alias "py"="python3"
### end of python

### docker
alias dk="docker"
### end of docker

### config prompt sign
autoload -U colors && colors
PROMPT="%{$fg[magenta]%}%1~ %(?.%{$fg[green]%}√.%{$fg[red]%}x)%b "

# PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%1~  %(?.%{$fg[green]%}√.%{$fg[red]%}x)%b "
#RPROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M"

autoload -Uz vcs_info      # integrate git into PROMPT
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_
setopt prompt_subst

# zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%F{cyan}%r%f'
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)'
zstyle ':vcs_info:*' enable git
#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
### end of config prompt

### zsh shell option
# to reset all shell option: emulate -LR zsh (useful for scripting)
# setopt CORRECT  # correct when typo
setopt no_case_glob  # case-insensitive globbing
setopt share_history
setopt INC_APPEND_HISTORY # adds commands as they are typed
setopt HIST_IGNORE_DUPS  # do not store duplications
### end of set opt#

### tab auto-complete
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -u
_comp_options+=(globdots)		# Include hidden files.`
### end of auto-complete

### bindkey with vim
#see: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
bindkey -v # enable vim in zsh
export KEYTIMEOUT=1  #Delay between ESC and mode change

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
# zle-line-init() {
#     zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#     echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# 0  ⇒  blinking block.
# 1  ⇒  blinking block (default).
# 2  ⇒  steady block.
# 3  ⇒  blinking underline.
# 4  ⇒  steady underline.
# 5  ⇒  blinking bar, xterm.
# 6  ⇒  steady bar, xterm.

### end of bindkey with vim


