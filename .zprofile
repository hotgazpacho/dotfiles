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

# Docker-ish stuff. Look for orbstack first, then rncher desktop
if [[ -f ~/.orbstack/shell/init.zsh ]]; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
elif [[ -d $HOME/.rd/bin ]]; then
  export PATH="$PATH:$HOME/.rd/bin"
fi


# Add the dotnet root and tools to the path, if they exist.
if [[ -d $HOME/.dotnet ]]; then
  export DOTNET_ROOT="$HOME/.dotnet"
  export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
fi

# Allow OpenCode to use the websearch tool.
export OPENCODE_ENABLE_EXA=1
