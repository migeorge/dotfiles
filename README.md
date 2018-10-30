# dotfiles
Welcome to my dotfiles, here you will find my preferred configs for Mac / Linux based
systems. This repository is ever-changing and morphs along with my preferred toolset.

## Installing

Make sure you have the following installed:
* neovim
* tmux
* zsh

This script wil destroy and replace the following config files:
* `~/.config/nvim/init.vim`
* `~/.tmux.conf`
* `~/.zshrc`

Run the following to install:
```
$ ./install.sh
```

If you'd like to install all the `vscode-insiders` extensions from
`./vscode/extensions-list.txt` also run:
```
$ ./install-vscode-insiders-extensions.sh
```
