if [[ $(/usr/bin/uname -m) == "arm64" ]]
then
  HOMEBREW_PREFIX="/opt/homebrew"
else 
  HOMEBREW_PREFIX="/usr/local"
fi
eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
