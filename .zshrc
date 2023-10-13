# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"

#POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_DISABLE_RPROMPT=true
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs node_version rbenv aws)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE: yarn-autocompletions requires installation
# git clone https://github.com/g-plane/zsh-yarn-autocompletions && zsh-yarn-autocompletions && ./install.sh $ZSH_CUSTOM/plugins
plugins=(git gh node golang bazel 1password httpie macos kubectl)

# Make Homebrew's completions available
# See https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if whence -p "brew" &> /dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# direnv hook
if whence -p "direnv" &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# WezTerm text decorations
if [[ -n $WEZTERM_PANE ]]; then
  export TERM=wezterm
fi

# XDG Base Directory specification https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Only set some of these, as it may have impact
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias npx="npx --no-install" # don't install node modules when running npx
alias yar="yarn"
alias dotfiles="$(which git) --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ldotfiles="$(which lazygit) --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ls="lsd"
alias ll="lsd --almost-all --long"
alias llm="lsd --timesort --long"
alias lS="lsd --oneline --classic"
alias lt="lsd --tree --depth=2"

export PATH=/usr/local/sbin:$PATH

# Adds ~/bin to the path if the directory exists
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# Adds ~/.local/bin to the path if the directory exits
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# asdf
if whence -p "asdf" &> /dev/null; then
  . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

test -e "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# go-jira
# test -e "jira" && eval "$(jira --completion-script-zsh)"

# fzf - command-line fuzzy finder
# https://github.com/junegunn/fzf
# brew install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-git adds fzf capabilities to git commands
# https://github.com/junegunn/fzf-git.sh
[ -f ~/fzf-git.sh ] && source ~/fzf-git.sh

# corrects your previous console command
# brew install thefuck
if type "thefuck" > /dev/null; then
  eval $(thefuck --alias);
fi

# pyenv
# assumes that pyenv has already been initialized in .zprofile
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"
if type "pyenv" > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# 1Password CLI autocomplete
if type "op" > /dev/null; then
  eval "$(op completion zsh)"; compdef _op op
fi

# 1Password shell plugins
test -e "${HOME}/.op/plugins.sh" && source "${HOME}/.op/plugins.sh"

# starship prompt instead of powerlevel9k
# brew install starship
if type "starship" > /dev/null; then
  eval "$(starship init zsh)";
fi

# zoxide is a smarter cd command
# brew install zoxide
if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)";
fi

# direnv support for asdf
ASDF_DIRENV_ZSHRC="${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
if [[ -f "$ASDF_DIRENV_ZSHRC" ]]; then
  source "$ASDF_DIRENV_ZSHRC"
fi

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# use gpg keys for ssh
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
