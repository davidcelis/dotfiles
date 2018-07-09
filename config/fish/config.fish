# No greeting, please
set fish_greeting ""

# Universal
set -x PATH $HOME/.local/bin $PATH
set -x EDITOR vim
set -x VISUAL $EDITOR

# Set the Code directory
set -x DEVELOPER $HOME/Developer

# Homebrew and brew-cask options
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

# Source sensitive configuration
if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
