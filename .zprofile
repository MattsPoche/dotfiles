#
# ~/.zprofile
#

# default programs
export SHELL='/bin/zsh'
export TERMINAL='st'
export BROWSER='firefox'
export EDITOR='nvim'
export TERMCMD='st'

## clean up
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export ZDOTDIR="$HOME/.config/zsh"
# Set Home path for user executables
export PATH="${PATH}:$HOME/.local/bin"
# Set Home dir for Mednafen
export MEDNAFEN_HOME="$HOME/.local/share/mednafen"
# Set path for rust compiler
export PATH="$HOME/.cargo/bin:$PATH"
