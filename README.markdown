# dotfiles

This is a basic framework for installing my dotfiles and keeping them up to date.

Simply:

``` sh
$ make
```

The framework:
 * Provides configuration for [fish-shell][fish].
 * Installs [homebrew][homebrew]
 * Installs [vundle][vundle] to manage Vim, while also installing several useful Vim plugins
 * Keeps all of the above up-to-date
 * Links up all of the dotfiles and dotdirectories

## Antecedent
Most of this comes from [stephencelis/dotfiles][antecedent].

[antecedent]: https://github.com/stephencelis/dotfiles
[fish]: https://github.com/fish-shell/fish-shell
[homebrew]: https://github.com/mxcl/homebrew
[vundle]: https://github.com/gmarik/vundle
[zsh]: https://github.com/zsh-users/zsh
