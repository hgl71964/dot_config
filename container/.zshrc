# example of adding python path
export PYTHONPATH=/usr

### command short hand
alias ll="ls -al"
alias tre="tree -CL 2"
### end of short hand

### git 
alias gs="git status"
alias "ggraph"="git log --oneline --graph --color --all --decorate"
### end of git

# example of chaning prompt sign
# PS1=">> "
### shell config
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
### end of shell config

# auto apply credential
#  alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
### end of AWS
#

### docker
alias dk="docker"
### end of docker

