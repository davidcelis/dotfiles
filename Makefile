symlinks = \
		   atom \
		   bundle \
		   config \
		   local \
		   gemrc \
		   gitconfig \
		   gitignore \
			 git_templates \
		   pryrc \
		   ruby-version \
		   vimrc \

formulas = \
		   cmake \
		   fish \
		   git \
		   ninja \
		   postgresql \
		   rbenv \
		   redis \
		   ruby-build \
		   the_silver_searcher \
		   trash \
		   tree \
		   wget \

os = $(shell uname -s)

default: | update clean

install: | brew ln ruby vim_plug

update: | install
	brew update
	brew upgrade --all
	gem update
	apm upgrade --no-confirm
	vim +PlugUpgrade +PlugInstall +PlugUpdate +qall

clean: | install
	brew cleanup
	gem clean
	apm clean
	vim +PlugClean +qall

# brew

homebrew_root = /usr/local
cellar = $(homebrew_root)/Cellar
taps = $(homebrew_root)/Library/Taps
caskroom = /opt/homebrew-cask/Caskroom

anybar = $(caskroom)/anybar
macvim = $(cellar)/macvim

prefixed_formulas = $(addprefix $(cellar)/,$(notdir $(formulas)))
brew: | $(brew_cask) $(prefixed_formulas) $(anybar) $(macvim)

homebrew = $(homebrew_root)/bin/brew
$(homebrew):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew_cask = $(taps)/caskroom/homebrew-cask/
$(brew_cask):
	brew tap caskroom/cask

$(prefixed_formulas): | $(homebrew)
	brew install $(notdir $@)

java = $(caskroom)/java
$(java): $(brew_cask)
	brew cask install java

$(cellar)/elasticsearch: | $(java)

$(anybar): | $(brew_cask)
	brew cask install anybar

$(macvim): | $(homebrew)
	brew install macvim \
		--with-override-system-vim \
		--with-lua \

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

ruby: | $(ruby) $(bundler) $(fit-commit)

$(ruby): | $(rbenv) $(HOME)/.ruby-version $(cellar)/ruby-install
	rbenv install $(ruby_version)
	rbenv global $(ruby_version)
	rbenv rehash

gem = $(ruby)/bin/gem

$(bundler): | $(ruby)
	$(gem) install bundler

$(fit-commit): | $(ruby)
	$(gem) install fit-commit

# vim

vim_plug = $(HOME)/.vim/autoload/plug.vim
vim_plug: | $(vim_plug)

$(vim_plug):
	curl -fLo $(vim_plug) --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $(HOME)/.vim/tmp

# make

.PHONY: update
