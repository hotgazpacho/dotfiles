if [[ $(/usr/bin/uname -m) == "arm64" ]]
then
  HOMEBREW_PREFIX="/opt/homebrew"
else 
  HOMEBREW_PREFIX="/usr/local"
fi
export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
if which -p "mise" &> /dev/null; then
  eval "$(mise activate zsh --shims)"
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

if [[ -f ~/.orbstack/shell/init.zsh ]]; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

if [[ -d $HOME/.dotnet ]]; then
  export DOTNET_ROOT="$HOME/.dotnet"
  export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"
fi
