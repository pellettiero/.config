
# List files in zsh with <TAB>
#
# Copyleft 2017 by Ignacio Nunez Hernanz <nacho _a_t_ ownyourbits _d_o_t_ com>
# GPL licensed (see end of file) * Use at your own risk!
#
# Usage:
#   In the middle of the command line:
#     (command being typed)<TAB>(resume typing)
#
#   At the beginning of the command line:
#     <SPACE><TAB>
#     <SPACE><SPACE><TAB>
#
# Notes:
#   This does not affect other completions
#   If you want 'cd ' or './' to be prepended, write in your .zshrc 'export TAB_LIST_FILES_PREFIX'
#   I recommend to complement this with push-line-or edit (bindkey '^q' push-line-or-edit)
function tab_list_files
{
  if [[ $#BUFFER == 0 ]]; then
    BUFFER="ls "
    CURSOR=3
    zle list-choices
    zle backward-kill-word
  elif [[ $BUFFER =~ ^[[:space:]][[:space:]].*$ ]]; then
    BUFFER="./"
    CURSOR=2
    zle list-choices
    [ -z ${TAB_LIST_FILES_PREFIX+x} ] && BUFFER="  " CURSOR=2
  elif [[ $BUFFER =~ ^[[:space:]]*$ ]]; then
    BUFFER="cd "
    CURSOR=3
    zle list-choices
    [ -z ${TAB_LIST_FILES_PREFIX+x} ] && BUFFER=" " CURSOR=1
  else
    BUFFER_=$BUFFER
    CURSOR_=$CURSOR
    zle expand-or-complete || zle expand-or-complete || {
      BUFFER="ls "
      CURSOR=3
      zle list-choices
      BUFFER=$BUFFER_
      CURSOR=$CURSOR_
    }
  fi
}
zle -N tab_list_files
bindkey '^I' tab_list_files

# uncomment the following line to prefix 'cd ' and './'
# when listing dirs and executables respectively
export TAB_LIST_FILES_PREFIX

# uncomment the following line to complement tab_list_files with ^q
bindkey '^q' push-line-or-edit

# License
#
# This script is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this script; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place, Suite 330,
# Boston, MA  02111-1307  USA

# man colors (disabled atm)
# man() {
#     env LESS_TERMCAP_mb=$'\E[01;31m' \
#     LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#     LESS_TERMCAP_me=$'\E[0m' \
#     LESS_TERMCAP_se=$'\E[0m' \
#     LESS_TERMCAP_so=$'\E[38;5;246m' \
#     LESS_TERMCAP_ue=$'\E[0m' \
#     LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#     man "$@"
# }

# Clone a github repo
# Works with Github URLs (http(s)), slash and space notation
clone() {
  local yes_cd=true
  while getopts "d:" OPTION
  do
    case $OPTION in
      d)
        local yes_cd=false
        shift
        ;;
    esac
  done
  if [[ -z $2 ]]; then
    local repo_name=$1
    local repo_user=$1
    while [ "${repo_name%%/*}" != "$repo_name" ]; do
       repo_name=${repo_name#*/}
    done
    repo_name=${repo_name%.*}
    if [[ $1 == *"http"* ]]
    then
	    git clone "$1"
    else
	    git clone https://github.com/"${repo_user%%/*}"/"$repo_name".git
    fi
    if $yes_cd; then cd "$repo_name" || return 1; fi
  else
    if [[ $# -eq 3 ]]; then
      git clone "https://github.com/$1/$2.git $3"
      if $yes_cd; then cd "$3" || return 1; fi
    else
      git clone "https://github.com/$1/$2.git"
      if $yes_cd; then cd "$2" || return 1; fi
    fi
  fi
}

# Fast mounting and unmounting with udevil
m() {
  if [[ $1 = win ]]; then
    echo "Mounting Windows partition..."
    udevil mount /dev/sda3
  else
    echo "Mounting /dev/"$1"..."
    udevil mount /dev/"$1"
  fi
  echo mounted media:
  mount | LANG=C grep --color=auto media
}

u() {
  if [[ $1 = sr0 ]]; then
    echo eject /dev/sr0
    eject /dev/sr0
  elif [[ $1 = win ]]; then
    echo "Umounting Windows partition..."
    udevil umount /dev/sda3
  else
    echo "Umounting /dev/"$1"..."
    udevil umount /dev/"$1"
  fi
  echo mounted media:
  mount | LANG=C grep --color=auto media
}

## Added by Master Password
# mpw() {
#     _copy() {
#         xclip -r -l 1 -selection clipboard
#         echo >&2 "Copied!"
#     }

#     # Empty the clipboard
#     :| _copy 2>/dev/null

#     # Ask for the user's name and password if not yet known.
#     MP_FULLNAME=${MP_FULLNAME:-$(ask 'Your Full Name:')}

#     # Start Master Password and copy the output.
#     printf %s "$(MP_FULLNAME=$MP_FULLNAME command mpw "$@")" | _copy
# }
