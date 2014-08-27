
MAKEFLAGS += --check-symlink-times
BIN = /usr/local/bin
OS = $(shell uname -s)

update: install
	git pull --rebase || (git stash && git pull --rebase && git stash pop)
	git submodule update --init
	git submodule foreach git checkout master
	git submodule foreach git pull
	# Updating Vundle packages
	vim +BundleInstall +BundleUpdate +BundleClean +qall
ifeq ($(OS),Darwin)
	# Updating Homebrew, upgrading formulae, and cleaning up old versions
	brew update
	brew upgrade
	brew cleanup
endif


ifeq ($(OS),Darwin)
install: homebrew ruby symlinks vundle
else
install: ruby symlinks vundle
endif


# Ruby

RUBY = $(HOME)/.rubies/2.1.2/bin/ruby

$(RUBY):
	cd $(HOME)/Downloads
	git clone https://github.com/terlar/fry.git
	cd fry
	make install
	mkdir -p $(HOME)/.rubies
	ruby-install ruby 2.1.2 -i $(HOME)/.rubies/2.1.2

ruby: $(RUBY)

# Dotfiles

DOTFILES = \
	gemrc \
	gitconfig \
	githelpers \
	gitignore \
	irbrc \
	pryrc \
	powconfig \
	screenrc \
	tmux.conf \
	vimrc \
	bundle \
	config \
	local \
	tmux \
	vim
SYMLINKS = $(addprefix $(HOME)/., $(DOTFILES))
ifeq (($OS),Darwin)
FLAGS = hfsv
else
FLAGS = fsv
endif
$(SYMLINKS):
	# Symlinking all dotfiles and dotdirectories
	@for dotfile in $(DOTFILES); \
	do \
		if test -d $$dotfile; \
		then \
			ln -F$(FLAGS) $(PWD)/$$dotfile/ $(HOME)/.$$dotfile; \
		elif test -f $$dotfile; \
		then \
			ln -$(FLAGS) $(PWD)/$$dotfile $(HOME)/.$$dotfile; \
		fi; \
	done

symlinks: $(SYMLINKS)


# Homebrew

BREW = $(BIN)/brew
$(BREW):
	# Installing Homebrew
	ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
	# Installing formulae from the Brewfile
	brew bundle

homebrew: $(BREW)


# Vundle

VUNDLE = $(HOME)/.vim/bundle/vundle
$(VUNDLE):
	# Installing Vundle
	mkdir -p $(HOME)/.vim/_temp
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
	vim +BundleInstall +BundleUpdate +BundleClean +qall

vundle: $(VUNDLE)


.PHONY: update
