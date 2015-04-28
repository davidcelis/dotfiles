homebrew_root = /usr/local
cellar = $(homebrew_root)/Cellar
taps = $(homebrew_root)/Library/Taps

symlinks = $(addprefix $(HOME)/.,\
             bundle \
             config \
             local \
             vim \
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
ifeq ($(os),Darwin)
	vim +PlugUpgrade +PlugInstall +PlugUpdate +PlugClean +qall
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
