# No greeting, please
set fish_greeting ""

# Universal
set -x PATH $HOME/.local/bin $PATH
set -x EDITOR vim
set -x VISUAL $EDITOR

# Set the Code directory
set -x DEVELOPER $HOME/Developer

# Homebrew and brew-cask options
fish_add_path /opt/homebrew/bin
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

# Source functions for asdf, a multi-purpose version manager
if test -f /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

# Source sensitive configuration
if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
