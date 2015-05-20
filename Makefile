homebrew_root = /usr/local
cellar = $(homebrew_root)/Cellar
taps = $(homebrew_root)/Library/Taps

symlinks = $(addprefix $(HOME)/.,\
             bundle \
             config \
             local \
             gemrc \
             gitconfig \
             gitignore \
             pryrc \
             ruby-version \
             tmux.conf \
             vimrc \
            )

formulas = $(addprefix $(cellar)/,\
             fish \
             git \
             docker \
             boot2docker \
             postgresql \
             redis \
             ruby-install \
             the_silver_searcher \
             wget \
            )

os = $(shell uname -s)

update: install
	vim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean +qall
ifeq ($(os),Darwin)
	brew update
	brew upgrade --all
	brew cleanup
endif

ifeq ($(os),Darwin)
install: brew ln
else
install: ln
endif

brew: $(formulas) $(macvim)

ln: $(symlinks)

# brew

homebrew = $(homebrew_root)/bin/brew
$(homebrew):
	@ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

$(formulas): $(homebrew)
	brew install $(notdir $@)
	@touch $@

macvim = $(cellar)/macvim
$(macvim): $(homebrew)
	brew install macvim \
		--override-system-vim \
		--with-lua \
	@touch $(macvim)

vim_plug = $(HOME)/.vim/autoload/plug.vim
vim_plug: | $(vim_plug)

$(vim_plug):
	curl -fLo $(vim_plug) --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p $(HOME)/.vim/_temp

homebrew_fry = $(taps)/igas/homebrew-fry
$(homebrew_fry):
	brew tap igas/fry
	@touch $(homebrew_fry)

$(cellar)/fry: $(homebrew_fry)

# ln

$(symlinks):
	@ln -Fsv $(PWD)/$(patsubst .%,%,$(notdir $@)) $@

# make

.PHONY: update
