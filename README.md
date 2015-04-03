# dotfiles

This is a basic framework for installing my dotfiles and keeping them up to date.

Simply:

```sh
$ make
```

The framework:

* Provides configuration for [fish-shell][fish].
* Installs [homebrew][homebrew] and various formulae if on Mac OS X
* Installs [vim-plug][vim-plug] to manage Vim, while also installing several useful Vim plugins
* Keeps all of the above up-to-date (just re-run `make`)
* Symlinks all of the dotfiles and dotdirectories to `$HOME`

## Antecedent

Much of this comes from [stephencelis/dotfiles][antecedent].

[antecedent]: https://github.com/stephencelis/dotfiles
[fish]: https://github.com/fish-shell/fish-shell
[homebrew]: https://github.com/mxcl/homebrew
[vim-plug]: https://github.com/junegunn/vim-plug
