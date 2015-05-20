symlinks = \
		   bundle \
		   config \
		   local \
		   gemrc \
		   gitconfig \
		   gitignore \
		   pryrc \
		   ruby-version \
		   vimrc \

formulas = \
		   boot2docker \
		   docker \
		   fish \
		   fry \
		   git \
		   postgresql \
		   redis \
		   ruby-install \
		   the_silver_searcher \
		   trash \
		   tree \
		   wget \

os = $(shell uname -s)

update: | install
	brew update
	brew upgrade --all
	brew cleanup
	vim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean +qall

install: | brew vim_plug ln ruby

# brew

homebrew_root = /usr/local
cellar = $(homebrew_root)/Cellar
taps = $(homebrew_root)/Library/Taps
caskroom = /opt/homebrew-cask/Caskroom

ruby_version := $(shell cat $(PWD)/ruby-version)

anybar = $(caskroom)/anybar
macvim = $(cellar)/macvim

prefixed_formulas = $(addprefix $(cellar)/,$(notdir $(formulas)))
brew: | $(brew_cask) $(prefixed_formulas) $(anybar) $(macvim)

homebrew = $(homebrew_root)/bin/brew
$(homebrew):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew_cask = $(cellar)/brew-cask
$(brew_cask): | $(homebrew)
	brew install Caskroom/cask/brew-cask

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
		--override-system-vim \
		--with-lua \

homebrew_fry = $(taps)/igas/homebrew-fry
$(homebrew_fry):
	brew tap igas/fry

fry = $(cellar)/fry
$(fry): | $(homebrew_fry)

# ln

prefixed_symlinks = $(addprefix $(HOME)/.,$(symlinks))
ln: | $(prefixed_symlinks)

$(prefixed_symlinks):
	@ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

# ruby

ruby = $(HOME)/.rubies/ruby-$(ruby_version)
ruby: | $(ruby)

$(ruby): | $(fry) $(HOME)/.ruby-version $(cellar)/ruby-install
	ruby-install ruby $(ruby_version)
	fry config auto on

# vim

vim_plug = $(HOME)/.vim/autoload/plug.vim
vim_plug: | $(vim_plug)

$(vim_plug):
	curl -fLo $(vim_plug) --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $(HOME)/.vim/tmp

# make

.PHONY: update
