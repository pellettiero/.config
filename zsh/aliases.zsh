alias sudo='sudo '

# Update pacman mirrors and update system
alias update-mirrors='echo "Syncing mirrors..." && \
  sudo /usr/bin/reflector --protocol http --latest 30 --number 20 --sort rate --save /etc/pacman.d/mirrorlist && \
  echo "Syncing complete."'
alias upgrade-all='echo "Syncing mirrors and upgrading system..." && \
  update-mirrors && \
  pacaur -Syu && \
  echo "Syncing and upgrade complete."'

# CUPS
alias start_cups='sudo systemctl start org.cups.cupsd.service'
alias stop_cups='sudo systemctl stop org.cups.cupsd.service'

# Alias "git push" to ask for SSH password before pushing
alias gp='eval $(keychain --dir "$XDG_CONFIG_HOME/keychain" --eval --agents ssh -Q --quiet id_ed25519) && git push'
# alias for .config
alias cfg='git -C "$XDG_CONFIG_HOME"'
# fast git status
alias s='git status'

alias ccat='pygmentize -O style=native -f console256 -g'
alias pacnew='sudo DIFFPROG="nvim -d" pacdiff'

## global aliases (for those who like them) ##

alias -g '...'='../..'
alias -g '....'='../../..'
alias -g BG='& exit'
alias -g C='|wc -l'
alias -g G='|grep'
alias -g H='|head'
alias -g Hl=' --help |& less -r'
alias -g K='|keep'
alias -g L='|less'
alias -g LL='|& less -r'
alias -g N='&>/dev/null'
alias -g R='| tr A-z N-za-m'
alias -g SL='| sort | less'
alias -g S='| sort'
alias -g T='|tail'
alias -g V='nvim'
