# using ripgrep combined with preview
# find-in-file
fif() {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
    --reverse \
    --border \
    --border-label '🕵🏻‍♂️ Search in Files' \
    --border-label-pos=2 \
    --header $'CTRL-O (open in nvim) / TAB (toggle selection) / ALT-A (select al) / ALT-D (deselect-all)\n\n' \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind "enter:become:$OPENER" \
    --bind "ctrl-o:execute:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:change-preview-window(down,50%,border-top|hidden|)' \
    --delimiter : \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(down)' \
    --query "$*"
}
