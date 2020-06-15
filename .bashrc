#
# ~/.bashrc
#

# vars
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

#aliases
alias  \
	vim=nvim              				\
	r=ranger              				\
	pms='sudo pacman -S'   				\
	pmu='sudo pacman -Syu' 				\
	yt="youtube-dl --add-metadata -i" 	\
	yta="yt -x -f bestaudio/best" 		\
	si="sxiv" 							\
	c="clear" 							\

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ls='ls --color=auto'
PS1='\[\033[0;34m\][\[\033[0;32m\]\u\[\033[0;31m\]@\[\033[0;36m\]\h \[\033[1;33m\]\W\[\033[0;34m\]]\$\[\033[0;000m\] ' 
