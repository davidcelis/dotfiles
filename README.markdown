# dotfiles

This is a basic framework for installing my dotfiles and keeping them up to date.

Simply:

``` sh
$ make
```

The framework:
 * Provides configuration for [fish-shell][fish].
 * Installs and configures [oh-my-zsh][oh-my-zsh] with a custom theme and plugin for [zsh][zsh] users.
 * Installs [homebrew][homebrew]
 * Installs [janus][janus] to manage Vim, while also installing several useful Vim plugins
 * Keeps all of the above up-to-date
 * Links up all of the dotfiles and dotdirectories

## Antecedent
Most of this comes from [stephencelis/dotfiles][antecedent].

[antecedent]: https://github.com/stephencelis/dotfiles
[fish]: https://github.com/fish-shell/fish-shell
[homebrew]: https://github.com/mxcl/homebrew
[janus]: https://github.com/carlhuda/janus
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[zsh]: https://github.com/zsh-users/zsh
