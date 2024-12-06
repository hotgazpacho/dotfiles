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
ZSH_CUSTOM=$HOME/.zsh-custom

# pyenv init
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE: yarn-autocompletions requires installation
# git clone https://github.com/g-plane/zsh-yarn-autocompletions && zsh-yarn-autocompletions && ./install.sh $ZSH_CUSTOM/plugins
plugins=(gh golang bazel pyenv 1password macos kubectl fzf-tab)

# Make Homebrew's completions available
# See https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if whence -p "brew" &> /dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# Use 22 (default 15) characters left truncated PWD
export ZSH_THEME_TERM_TAB_TITLE_IDLE="%22<..<%~%<<"

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

# Glamour style https://github.com/charmbracelet/glamour
export GLAMOUR_STYLE="$XDG_CONFIG_HOME/glamour/catppuccin-macchiato.json"

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
# brew install eza
if (( $+commands[eza] )); then
  # Automatically show icons. This is supposed to be the default 🤷
  export EZA_ICONS_AUTO=1
  # Usee eza rather than ls
  alias ls="eza"
  # list (almost) everything, directories first
  alias ll="eza -al --group-directories-first"
  # Display a tree of files 2 levels deep, with metadata
  alias lt="eza --long --tree --depth=2"
  # list only hidden files and directories
  alias lh="eza -dl .* --group-directories-first"
else
  echo "eza not found; brew install eza"
fi

export PATH=/usr/local/sbin:$PATH

# Adds ~/bin to the path if the directory exists
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# Adds ~/.local/bin to the path if the directory exits
if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# rtx, now mise-en-place
if which -p "mise" &> /dev/null; then
  eval "$($(brew --prefix)/bin/mise activate zsh)"
fi

# zsh-syntax-highlighting
test -e "~/.zsh/catppuccin_moacchiato-zsh-syntax-highlighting.zsh" && source ~/.zsh/catppuccin_moacchiato-zsh-syntax-highlighting.zsh
test -e "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf - command-line fuzzy finder
# https://github.com/junegunn/fzf
# brew install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-git adds fzf capabilities to git commands
# https://github.com/junegunn/fzf-git.sh
[ -f ~/fzf-git.sh ] && source ~/fzf-git.sh

# Use catpuccin macchiato color theme for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:#1e2030,bg:#24273a,spinner:#8bd5ca,hl:#8aadf4"\
" --color=fg:#5b6078,header:#8aadf4,info:#eed49f,pointer:#8bd5ca"\
" --color=marker:#8bd5ca,fg+:#f4dbd6,prompt:#eed49f,hl+:#8aadf4"

# CTRL + R: Commands that are too long are not fully visible on screen. 
# We can use --preview option to display the full command on the preview window. 
# Bind ? key for toggling the preview window.
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

# ALT + C: set "fd-find" as directory search engine instead of "find"
export FZF_ALT_C_COMMAND="fd --type directory"

# ALT + C: put the tree command output based on item selected
# Requires `eza`, `brew install eza`
export FZF_ALT_C_OPTS="--preview 'eza --color=always --icons=always --tree --level=3 {}'"

# CTRL + T: set "fd-find" as search engine instead of "find" and exclude .git, but include hidden files, for the results
export FZF_CTRL_T_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"

# CTRL + T: put the file content if item select is a file, or put tree command output if item selected is directory
export FZF_CTRL_T_OPTS="--preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers {}'"

# fzf-tab configuration
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# corrects your previous console command
# brew install thefuck
if type "thefuck" > /dev/null; then
  eval $(thefuck --alias);
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

# gpg
GPG_TTY=$(tty)
export GPG_TTY

# use gpg keys for ssh
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# gpgconf --launch gpg-agent

# use 1Password for ssh
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# kubectl
if [[ $(kubectl plugin list --name-only 2>&1)  =~ "tanium" ]]; then
  eval "$(kubectl tanium cache alias --skip-update --skip-cache)"
fi

# Sort the cspell.json file. Requires jq and sponge (from moreutils)
function sort_cspell() {
  jq -S '.words |= sort_by(.)' cspell.json | sponge cspell.json
}
