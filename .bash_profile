if [ -f ~/.orbstack/shell/init.bash ]; then
  source ~/.orbstack/shell/init.bash 2>/dev/null || :
fi
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
