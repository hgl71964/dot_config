# example of adding python path
# export PYTHONPATH=/usr # where python will search for packages 

### command short hand
alias ll="ls -al"
alias tre="tree -CL 2"
### end of short hand

### git 
alias gs="git status"
alias "ggraph"="git log --oneline --graph --color --all --decorate"
alias "gam"="git add . && git commit -m 'lazy_commit'"
### end of git



### AWS
alias aws='docker run --rm -it amazon/aws-cli'

# auto apply credential
#  alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
### end of AWS
#

### docker
alias dk="docker"
### end of docker

### config prompt sign
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
### end of config prompt

### zsh shell option
setopt CORRECT  # correct when typo
setopt no_case_glob  # case-insensitive globbing
setopt share_history
setopt INC_APPEND_HISTORY # adds commands as they are typed
setopt HIST_IGNORE_DUPS  # do not store duplications
### end of set opt#

### tab auto-complete 
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -u
_comp_options+=(globdots)		# Include hidden files.`
### end of auto-complete

### syntax-highligh
# see: https://github.com/zsh-users/zsh-syntax-highlighting; put right path
source $HOME/git_repo/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
### end of syntax-highlight


### bindkey with vim
#see: https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
bindkey -v  # enable vim in zsh
export KEYTIMEOUT=1  #Delay between ESC and mode change

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt
### end of bindkey with vim
