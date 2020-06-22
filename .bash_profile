#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# default programs
export TERMINAL='st'
export BROWSER='firefox'
export EDITOR='nvim' 

# clean up
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"

# Set Home path for user executables
export PATH="${PATH}:$HOME/.local/bin"
# Set path for rust compiler
export PATH="$HOME/.cargo/bin:$PATH"
