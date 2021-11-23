symlinks = \
	bundle \
	config \
	local \
	gemrc \
	gitconfig \
	gitignore \
	pryrc \
	tmux \
	tmux.conf \
	tool-versions \
	vimrc \

default: | update clean

install: | brew ln ruby vim_plug

update: | install
	brew upgrade
	gem update
	apm upgrade --no-confirm
	vim +PlugUpgrade +PlugInstall +PlugUpdate +qall

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

ruby_versions = $(HOME)/.asdf/installs/ruby
ruby = $(ruby_versions)/$(ruby_version)

bundler = $(ruby)/bin/bundle

ruby: | $(ruby) $(bundler)

$(ruby): | $(brew) $(HOME)/.ruby-version
	asdf plugin add ruby
	asdf install ruby $(ruby_version)

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
