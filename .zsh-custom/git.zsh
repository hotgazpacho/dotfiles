# Shortcut functions for fzf-git

# Checkout the chosen ref (branch or tag)
gco() {
  _fzf_git_each_ref --no-multi | xargs git checkout
}

# Checkout the chose branch
gcb() {
  _fzf_git_branches --no-multi | xargs git checkout
}

# git stashes
gst() {
  _fzf_git_stashes --no-multi
}
