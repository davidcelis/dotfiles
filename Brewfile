#             __,
#          .-'_-'`
#        .' {`
#    .-'````'-.    .-'``'.
#  .'(0)       '._/ _.-.  `\
# }     '. ))    _<`    )`  |
#  `-.,\'.\_,.-\` \`---; .' /
#       )  )       '-.  '--:
#      ( ' (          ) '.  \
#       '.  )      .'(   /   )
#         )/      (   '.    /
#                  '._( ) .'
#                      ( (
#                       `-.
brew 'fish'

# Ruby
brew 'rbenv'
brew 'ruby-build'
brew 'ruby-install'

# Databases
brew 'postgresql', restart_service: :changed
brew 'redis', restart_service: :changed

# Utilities
brew 'cmake'
brew 'git'
brew 'macvim', args: ['with-lua', 'with-override-system-vim']
brew 'ninja'
brew 'openssl'
brew 'ripgrep'
brew 'tree'
brew 'wget'

# Homebrew Cask
cask_args appdir: "#{ENV['HOME']}/Applications"
tap 'caskroom/cask'
cask 'anybar'
cask 'java' unless system '/usr/libexec/java_home --failfast'

# Mac OS X
brew 'trash'

mas 'GarageBand',       id: 682658836
mas 'Keynote',          id: 409183694
mas 'Pages',            id: 409201541
mas 'Numbers',          id: 409203825
mas 'XCode',            id: 497799835

mas '1Password',        id: 443987910
mas 'Capo',             id: 696977615
mas 'ColorSnapper2',    id: 969418666
mas 'Day One',          id: 1055511498
mas 'GIPHY CAPTURE',    id: 668208984
mas 'Moom',             id: 419330170
mas 'Paw',              id: 584653203
mas 'Pixelmator',       id: 407963104
mas 'Reeder',           id: 880001334
mas 'Slack',            id: 803453959
mas 'The Unarchiver',   id: 425424353
