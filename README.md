# dotfiles

My dotfiles. Note that this assumes macOS with [homebrew](https://brew.sh)
already installed.

## Prerequisites

```console
brew install direnv\
 starship\
 fzf bat rg fd asdf delta\
 zsh-autosuggestions\
 git git-delta lazygit gh\
 gnupg pinentry-mac\
 marksman taplo luacheck markdownlint-cli tree-sitter\
 neovim
brew tap homebrew/cask-fonts
brew install font-fira-code
brew install --cask font-symbols-only-nerd-font
brew install --cask wezterm --no-quarantine
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/main/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add direnv
asdf plugin add ruby
asdf plugin add rust
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
~/bin/iterm2prefs
launchctl load ~/Library/LaunchAgents/com.local.KeyRemapping.plist
```

### `pyenv` for neovim

```console
brew install pyenv pyenv-virtualenv
pyenv install 3.8.13
pyenv virtualenv 3.8.13 neovim3
pyenv activate neovim3
pip install --upgrade pip
pip install neovim
pyenv deactivate
```

## Helix Editor

Helix has built-in support for LSP-compliant Language Servers. Install a few of
the most common ones:

```console
npm install --global typescript-language-server\
 vscode-langservers-extracted\
 dockerfile-language-server-nodejs\
 bash-language-server\
 cspell\
 eslint_d\
 @commitlint/cli\
 @commitlint/format\
 @commitlint/config-conventional\
 commitlint-format-json
brew install taplo marksman lua-language-server
go install golang.org/x/tools/gopls@latest
go install github.com/go=delve/delve/cmd/dlv@latest
asdf reshim golang
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

## Key Mappings and Bindings

This setup does not require using the keyboard control panel to change the
modifier keys. Instead, we'll use `hidutil` to change the mapping of `Caps Lock`
to `F18`. We'll then use [Hammerspoon](https://hammerspoon.org) to interpret
`F18` as `hyper` (`shift` + `ctrl` + `option` + `command`) when pressed with
other keys, and `escape` when pressed and released alone. This is accomplished
using [launchd](https://www.launchd.info).
The keymapping is set in `Library/LaunchAgents/com.local.KeyRemapping.plist`,
can be [generated](https://hidutil-generator.netlify.app), and should have been
acitivated if you followed the steps above. One side effect here is that the
light on the `Caps Lock` key of the Macbook Pro will remain lit.

Next, you'll need to install hammerspoon:

```console
brew cask install hammerspoon
```

## TODO

- [x] iterm2
  - [x] config
- [x] wezterm
- [ ] git
  - [ ] aliases
  - [ ] [`git-fixup`](https://github.com/keis/git-fixup)
- [x] neovim
