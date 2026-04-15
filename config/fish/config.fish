# No greeting, please
set fish_greeting ""

# Universal
set -x PATH $HOME/.local/bin $PATH
set -x EDITOR vim
set -x VISUAL $EDITOR
set -gx GPG_TTY (tty)

# Set the Code directory
set -x DEVELOPER $HOME/Developer

# Homebrew and brew-cask options
fish_add_path /opt/homebrew/bin
set -x HOMEBREW_CASK_OPTS "--appdir=~/Applications"

# Source functions for rv, a fast ruby version manager
if type -q rv
  rv shell init fish | source
  rv shell completions fish | source
end

# Source sensitive configuration
if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
