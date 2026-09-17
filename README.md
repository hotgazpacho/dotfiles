# dotfiles

My dotfiles. Note that this assumes macOS with [homebrew](https://brew.sh)
already installed.

## Prerequisites

```console
brew bundle
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install

```console
git clone --bare git@github.com:hotgazpacho/dotfiles.git $HOME/.dotfiles
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
dotfiles submodule init
dotfiles submodule update
$(brew --prefix)/opt/fzf/install
```

### `pyenv` for neovim

```console
pyenv install 3.8.13
pyenv virtualenv 3.8.13 neovim3
pyenv activate neovim3
pip install --upgrade pip
pip install neovim
pyenv deactivate
```

## GitHub CLI extensions

- [gh-dash](https://github.com/dlvhdr/gh-dash)

  ```console
  GH_HOST="" gh extension install dlvhdr/gh-dash
  ```

- [gh-f](https://github.com/gennaro-tedesco/gh-f)

  ```console
  GH_HOST="" gh extension install gennaro-tedesco/gh-f
  ```
