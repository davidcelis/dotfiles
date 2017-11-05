symlinks = \
	atom \
	bundle \
	config \
	local \
	gemrc \
	gitconfig \
	gitignore \
	pryrc \
	ruby-version \
	tmux \
	tmux.conf \
	vimrc \

default: | update clean

install: | brew ln ruby vim_plug

update: | install
	brew update
	brew upgrade
	gem update
	apm upgrade --no-confirm
	vim +PlugUpgrade +PlugInstall +PlugUpdate +qall
	mas upgrade

clean: | install
	brew cleanup
	gem clean
	apm clean
	vim +PlugClean +qall

# brew

brew: | $(homebrew)

homebrew_root = /usr/local
homebrew = $(homebrew_root)/bin/brew
$(homebrew):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# ln

prefixed_symlinks = $(addprefix $(HOME)/.,$(symlinks))
ln: | $(prefixed_symlinks)

$(prefixed_symlinks):
	@ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

# ruby

ruby_version := $(shell cat $(PWD)/ruby-version)

ruby = $(HOME)/.rbenv/versions/$(ruby_version)

bundler = $(ruby)/bin/bundle
cocoapods = $(ruby)/bin/pod

ruby: | $(ruby) $(bundler)

$(ruby): | $(brew) $(HOME)/.ruby-version
	rbenv install $(ruby_version)
	rbenv global $(ruby_version)
	rbenv rehash

gem = $(ruby)/bin/gem

$(bundler): | $(ruby)
	$(gem) install bundler

# vim

vim_plug = $(HOME)/.vim/autoload/plug.vim
vim_plug: | $(vim_plug)

$(vim_plug):
	curl -fLo $(vim_plug) --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $(HOME)/.vim/tmp

# make

.PHONY: update
