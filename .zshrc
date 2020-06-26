#
# ~/.config/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vars
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#aliases
alias	\
	vim=nvim							\
	r=ranger							\
	pms='sudo pacman -S'				\
	pmu='sudo pacman -Syu'				\
	yt='youtube-dl --add-metadata -i'	\
	yta='yt -x -f bestaudio/best'		\
	si='sxiv'							\
	c='clear'							\
	ls='ls --color=auto'				\

set -o vi

PS1='%F{blue}[%F{green}%n%F{red}@%F{cyan}%m %B%F{yellow}%c%b%F{blue}]$ %F{15}'

HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000

setopt autocd extendedglob nomatch
bindkey -v

zstyle :compinstall filename '/home/matt/.zshrc'

autoload -Uz compinit
compinit

# pluggins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
