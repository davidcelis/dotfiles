symlinks = \
	bundle \
	config \
	local \
	gemrc \
	gitconfig \
	gitignore \
	tool-versions \
	vimrc \

default: | update clean

install: | brew brew_bundle ln ruby vim_plug

update: | install
	brew upgrade
	gem update
	fisher update
	vim +PlugUpgrade +PlugInstall +PlugUpdate +qall

clean: | install
	brew cleanup
	gem clean
	vim +PlugClean +qall

# brew

brew: | $(homebrew) $(brew_bundle)

homebrew_root = /usr/local
homebrew = $(homebrew_root)/bin/brew
$(homebrew):
	@/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew_bundle = $(PWD)/Brewfile.lock.json
$(brew_bundle): | $(homebrew)
	brew bundle check --file=$(PWD)/Brewfile || brew bundle --file=$(PWD)/Brewfile

# ln

prefixed_symlinks = $(addprefix $(HOME)/.,$(symlinks))
ln: | $(prefixed_symlinks)

$(prefixed_symlinks):
	@ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

# ruby

ruby_version := $(shell cat $(PWD)/tool-versions | awk -v tool=ruby '$$1 == tool { print $$2 }')

ruby_versions = $(HOME)/.asdf/installs/ruby
ruby = $(ruby_versions)/$(ruby_version)

bundler = $(ruby)/bin/bundle

ruby: | $(ruby) $(bundler)

$(ruby): | $(brew) $(HOME)/.tool-versions
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

# fisher
fisher = $(HOME)/.config/fish/functions/fisher.fish
fisher: | $(fisher)

$(fisher):
	@/opt/homebrew/bin/fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# make

.PHONY: update
