
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
install: homebrew symlinks vundle
else
install: symlinks vundle
endif


# Dotfiles

DOTFILES = \
	gemrc \
	gitconfig \
	githelpers \
	gitignore \
	irbrc \
	pryrc \
	powconfig \
	rspec \
	screenrc \
	tmux.conf \
	vimrc \
	bundle \
	config \
	local \
	tmux \
	vim
SYMLINKS = $(addprefix $(HOME)/., $(DOTFILES))
$(SYMLINKS):
	# Symlinking all dotfiles and dotdirectories
	@for dotfile in $(DOTFILES); \
	do \
		if test -d $$dotfile; \
		then \
			ln -Fhfsv $(PWD)/$$dotfile/ $(HOME)/.$$dotfile; \
		elif test -f $$dotfile; \
		then \
			ln -hfsv $(PWD)/$$dotfile $(HOME)/.$$dotfile; \
		fi; \
	done

symlinks: $(SYMLINKS)


# Homebrew

BREW = $(BIN)/brew
$(BREW):
	# Installing Homebrew
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

homebrew: $(BREW)


# Vundle

VUNDLE = $(HOME)/.vim/bundle/vundle
$(VUNDLE):
	# Installing Vundle
	mkdir -p $(HOME)/.vim/_temp
	vim +BundleInstall +BundleUpdate +BundleClean +qall

vundle: $(VUNDLE)


.PHONY: update
