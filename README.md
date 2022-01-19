# dotfiles

My dotfiles. Note that this assumes macOS with [homebrew](https://brew.sh) already installed.

```console
git clone --bare git@github.com:hotgazpacho/dotfiles.git $HOME/.dotfiles
alias dotfiles='$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
launchctl load ~/Library/LaunchAgents/com.local.KeyRemapping.plist
```

## Key Mappings and Bindings

This setup does not require using the keyboard control panel to change the modifier keys. Instead, we'll use `hidutil` to change the mapping of `Caps Lock` to `F18`. We'll then use [Hammerspoon](https://hammerspoon.org) to interpret `F18` as `hyper` (`shift` + `ctrl` + `option` + `command`) when pressed with other keys, and `escape` when pressed and released alone. This is accomplished using [launchd](https://www.launchd.info). The keymapping is set in `Library/LaunchAgents/com.local.KeyRemapping.plist`, can be [generated](https://hidutil-generator.netlify.app), and should have been acitivated if you followed the steps above. One side effect here is that the light on the `Caps Lock` key of the Macbook Pro will remain lit.

Next, you'll need to install hammerspoon:

```console
brew cask install hammerspoon
```

## Terminal

```console
brew install direnv starship fnm fzf
brew cask install iterm2 font-firacode-nerd-font
```

## TODO
- [x] iterm2 
  - [x] config
- [ ] git
  - [ ] aliases
  - [ ] `git-fixup` *https://github.com/keis/git-fixup*
- [ ] vim
- [ ] vscode 
  - [ ] `~/Library/Application\ Support/Code/User/keybindings.json}`
  - [ ] `~/Library/Application\ Support/Code/User/settings.json}`
  - [ ] `~/Library/Application\ Support/Code/User/snippets}`
  - [ ] `~/.vscode/extensions`
