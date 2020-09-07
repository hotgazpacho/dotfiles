# dotfiles

My dotfiles

## Keyboard

This setup does not require using the keyboard control panel to change the modifier keys. Instead, we'll use `hidutil` to change the mapping of `Caps Lock` to `F18`. We'll then use [Hammerspoon](https://hammerspoon.org) to interpret `F18` as `hyper` (`shift` + `ctrl` + `option` + `command`) when pressed with other keys, and `escape` when pressed and released alone.

0. Install hammerspoon
```console
brew cask install hammerspoon
```
1. Configure `caps lock` to send `F18`, and use `launchd` to ensure this configuration is applied on reboot (h/t: https://hidutil-generator.netlify.app)
```console
bin/setupKeymap
```
