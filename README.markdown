# dotfiles

This is a basic framework for installing my dotfiles and keeping them up to date.

``` sh
$ make install # -- Install everything from scratch; link dotfiles
$ make update  # -- Update everything
$ make clean   # -- Uninstall and unlink everything
```

The framework:
 * Installs and configures [oh-my-zsh][oh-my-zsh] with a custom theme and plugin.
 * Installs [janus][janus] to manage Vim, while also installing several useful Vim plugins
 * Installs [rbenv][rbenv] and [ruby-build][ruby-build]
 * Installs various [homebrew][homebrew] packages
 * Keeps all of the above up-to-date
 * Links up all of the dotfiles and dotdirectories

## Antecedent
Most of this comes from [stephencelis/dotfiles][antecedent].

[antecedent]: https://github.com/stephencelis/dotfiles
[oh-my-zsh]: https://github.com/robbyrussell/oh-my-zsh
[janus]: https://github.com/carlhuda/janus
[rbenv]: https://github.com/sstephenson/rbenv
[ruby-build]: https://github.com/sstephenson/ruby-build
[homebrew]: https://github.com/mxcl/homebrew
