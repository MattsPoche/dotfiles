#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# default programs
export TERMINAL='st'
export BROWSER='firefox'
export EDITOR='nvim' 

# Set Home path for user executables
export PATH="${PATH}:$HOME/.local/bin"
# Set path for rust compiler
export PATH="$HOME/.cargo/bin:$PATH"
