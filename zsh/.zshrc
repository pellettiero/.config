#
# User configuration sourced by interactive shells
#

# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

# Source additional functions
for file in $ZDOTDIR/*; do
  source "$file"
done

# Set name for mpw
export MPW_FULLNAME="Michele Pellegrini"

# Use a default width of 80 for manpages for more convenient reading
export MANWIDTH=80

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
