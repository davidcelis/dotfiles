# No greeting, please
set -e fish_greeting

# Universal
set -x PATH $HOME/.local/bin $PATH
set -x EDITOR vim
set -x VISUAL $EDITOR

# Set the Code directory
set -x DEVELOPER $HOME/Developer

# Ruby
if test -d ~/.rbenv
  status --is-interactive; and . (rbenv init - | psub)
end

# Aliases
alias ag "ag --smart-case"
alias rm "trash"

if test -x (which exa)
  alias ls "exa"
end

# Source sensitive configuration
if test -f $HOME/.config/fish/local.fish
  source $HOME/.config/fish/local.fish
end
