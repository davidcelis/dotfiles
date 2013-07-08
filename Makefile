
MAKEFLAGS += --check-symlink-times
BIN = /usr/local/bin


update: install
	git pull --rebase || (git stash && git pull --rebase && git stash pop)
	git submodule update --init
	git submodule foreach git checkout master
	git submodule foreach git pull
	# Oh My Zsh
	cd $(OH_MY_ZSH) && git pull
	cd $(OH_MY_ZSH)/custom/plugins/zsh-history-substring-search && git pull
	cd $(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting && git pull
	# Vundle
	vim +BundleInstall! +qall
	# Homebrew
	brew update
	brew upgrade
	brew cleanup


install: homebrew oh-my-zsh symlinks vundle


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
	zshenv \
	zshrc \
	bundle \
	config \
	local \
	tmux \
	vim
SYMLINKS = $(addprefix $(HOME)/., $(DOTFILES))
$(SYMLINKS):
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
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

homebrew: $(BREW)


# Vundle

VUNDLE = $(HOME)/.vim/bundle/vundle
$(VUNDLE):
	mkdir -p $(HOME)/.vim/_temp
	vim +BundleInstall! +qall

vundle: $(VUNDLE)


# Oh My Zsh

OH_MY_ZSH = $(HOME)/.oh-my-zsh
OH_MY_ZSH_PLUGINS = \
	$(OH_MY_ZSH)/custom/plugins/zsh-history-substring-search \
	$(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting \
	$(OH_MY_ZSH)/custom/davidcelis.zsh-theme \
	$(OH_MY_ZSH)/custom/plugins/davidcelis
$(OH_MY_ZSH)/custom/plugins/zsh-history-substring-search: $(OH_MY_ZSH)
	git clone -- git://github.com/zsh-users/zsh-history-substring-search.git \
		$(OH_MY_ZSH)/custom/plugins/zsh-history-substring-search
$(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting: $(OH_MY_ZSH)
	git clone -- git://github.com/zsh-users/zsh-syntax-highlighting.git \
		$(OH_MY_ZSH)/custom/plugins/zsh-syntax-highlighting
$(OH_MY_ZSH)/custom/davidcelis.zsh-theme: $(OH_MY_ZSH)
	@ln -hfsv $(PWD)/oh-my-zsh/custom/davidcelis.zsh-theme \
		$(OH_MY_ZSH)/custom/davidcelis.zsh-theme
$(OH_MY_ZSH)/custom/plugins/davidcelis: $(OH_MY_ZSH)
	@ln -Fhfsv $(PWD)/oh-my-zsh/custom/plugins/davidcelis/ \
		$(OH_MY_ZSH)/custom/plugins/davidcelis
$(OH_MY_ZSH):
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

oh-my-zsh: $(OH_MY_ZSH_PLUGINS)


.PHONY: update
