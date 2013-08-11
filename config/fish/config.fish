# No greeting, please
set -e fish_greeting

# Path

# Local
set PATH $HOME/.local/bin $PATH

# Homebrew
set PATH /usr/local/bin /usr/local/sbin $PATH
set PATH $PATH /usr/local/share/python /usr/local/share/npm/bin

# MacVim
set -x EDITOR vim
set -x VISUAL $EDITOR
alias vim $EDITOR

# JRuby 1.9 mode
set -x JRUBY_OPTS "--1.9 -Xcext.enabled=true"

# Ruby
set PATH "$HOME/.rbenv/bin" "$HOME/.rbenv/shims" $PATH

set -x RUBY_HEAP_MIN_SLOTS 1000000
set -x RUBY_HEAP_SLOTS_INCREMENT 1000000
set -x RUBY_HEAP_SLOTS_GROWTH_FACTOR 1
set -x RUBY_GC_MALLOC_LIMIT 100000000
set -x RUBY_HEAP_FREE_MIN 500000

# Binstubs
set PATH "./bin" $PATH

# Set the Code directory
set -x CODE $HOME/Documents/Code

# Setup autocompletions
complete -c c -a (echo (ls -d $CODE/*/ | xargs -n1 basename))
complete -c pass -a (_pass)

# Aliases
alias ssh-add-all "ssh-add ~/.ssh/*id_rsa"
alias ag "ag --smart-case"
alias pianobar "pianokeys; and /usr/local/bin/pianobar"

. /usr/local/share/fry/fry.fish
