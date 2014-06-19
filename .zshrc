#Colorize prompt
autoload -U colors && colors

#Enable zmv
autoload -U zmv

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
#PROMPT='%n@%m:%~%# '
PROMPT='%n@%m:%# '
PROMPT="%{$fg[cyan]%}%n%{$reset_color%}%{$fg[red]%}@%{$reset_color%}%{$fg[green]%}%m%{$reset_color%}% (%{$fg[cyan]%}%~%{$reset_color%})# "

#right prompt
#RPS1="(%{$fg[cyan]%}%30<…<%~%{$reset_color%})"

setopt autocd complete_in_word correct rm_star_wait extended_glob auto_pushd share_history prompt_subst
unsetopt beep

bindkey -e
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[3~' delete-char

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit
# End of lines added by compinstall
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# colorful completion listings
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=30;;43:ow=30;43:"
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# remove slash if argument is a directory
zstyle ':completion:*' squeeze-slashes true

# User aliases
alias unpk='tar xzf'
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(auto)%d%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
# Convenience user functions
ec () { /Applications/Emacs.app/Contents/MacOS/bin/emacsclient $* }
be () { bundle exec "$@" }
br () { bundle exec rake $* }
alias berc='be rails console'
alias bers='be rails server'
alias dia /Applications/Dia.app/Contents/Resources/bin/dia

# Set path to includ current director
export PATH=".:~/bin:/usr/local/mysql/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/X11/lib
#export CCL_DEFAULT_DIRECTORY="/Applications/Clozure CL.app/Contents/Resources/ccl"

# Colorize ls
alias ls='ls -G'

if [[ ("$TERM" == 'eterm-color')]] then
	TERM="xterm"
	export TERM
fi

#Git prompt
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '+'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' actionformats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%r%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
precmd() {

    vcs_info
}

 RPS1='${vcs_info_msg_0_}'

# Initialization for FDK command line tools.Tue Sep 25 22:59:29 2012
FDK_EXE="/Users/pobocks/bin/FDK/Tools/osx"
#PATH=${PATH}:"/Users/pobocks/bin/FDK/Tools/osx"
#export PATH
#export FDK_EXE

# Emacsmacsmacs
export EDITOR="emacs"

# Development Env for Rails
export RAILS_ENV="development"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
