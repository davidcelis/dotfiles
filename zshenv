# Path

# Local
PATH="$HOME/.local/bin:$PATH"

# Homebrew
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$PATH:/usr/local/share/python"
PATH="$PATH:/usr/local/share/npm/bin"

export PATH

# MacVim

EDITOR=$(command -v {~,}/Applications/MacVim.app/Contents/MacOS/Vim | head -1)
EDITOR=${EDITOR:=vim}

export EDITOR
export VISUAL=$EDITOR
alias vim=$EDITOR

# JRuby 1.9 mode
export JRUBY_OPTS='--1.9 -Xcext.enabled=true'

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# Ruby

export PATH="$HOME/.rbenv/shims:$PATH"

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=100000000
export RUBY_HEAP_FREE_MIN=500000

setopt interactivecomments
