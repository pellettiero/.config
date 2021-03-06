# Archlinux zsh aliases and functions
# Usage is also described at https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins

# Look for pacaur, and add useful functions and aliases to it too
if (( $+commands[pacaur] )); then
  alias paupg='pacaur -Syu'          # Synchronize with repositories before upgrading packages (AUR too) that are out of date on the local system.
  alias paupgd='pacaur -Syu --devel' # Synchronize with repositories before upgrading packages (AUR and devel too) that are out of date on the local system.
  alias paupga='pacaur -u'           # Upgrade all AUR packages
  alias paupgda='pacaur -u --devel'  # Upgrade all AUR and devel (-git, -svn, etc.) packages
  alias pain='pacaur -S'             # Install specific package(s) from the repositories or the AUR
  alias pains='pacaur -U'            # Install specific package not from the repositories but from a file
  alias pare='pacaur -R'             # Remove the specified package(s), retaining its configuration(s) and required dependencies
  alias parem='pacaur -Rns'          # Remove the specified package(s), its configuration(s) and unneeded dependencies
  alias parep='pacaur -Si'           # Display information about a given package in the repositories or the AUR
  alias pareps='pacaur -Ss'          # Search for package(s) in the repositories and the AUR
  alias parepsa='pacaur -s'          # Search for package(s) in the AUR
  alias paloc='pacaur -Qi'           # Display information about a given package in the local database
  alias palocs='pacaur -Qs'          # Search for package(s) in the local database
  alias palst='pacaur -Qe'           # List manually installed packages, even those installed from AUR
  # Additional pacaur alias examples
  if [[ -x `command -v abs` && -x `command -v aur` ]]; then
    alias paupd='pacaur -Sy && sudo abs && sudo aur'  # Update and refresh the local package, ABS and AUR databases against repositories
  elif [[ -x `command -v abs` ]]; then
    alias paupd='pacaur -Sy && sudo abs'              # Update and refresh the local package and ABS databases against repositories
  elif [[ -x `command -v aur` ]]; then
    alias paupd='pacaur -Sy && sudo aur'              # Update and refresh the local package and AUR databases against repositories
  else
    alias paupd='pacaur -Sy'                          # Update and refresh the local package database against repositories
  fi
  alias painsd='pacaur -S --asdeps'        # Install given package(s) as dependencies of another package
  alias pamir='pacaur -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist
fi

# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
# Additional pacman alias examples
if (( $+commands[abs] && $+commands[aur] )); then
  alias pacupd='sudo pacman -Sy && sudo abs && sudo aur'  # Update and refresh the local package, ABS and AUR databases against repositories
elif (( $+commands[abs] )); then
  alias pacupd='sudo pacman -Sy && sudo abs'              # Update and refresh the local package and ABS databases against repositories
elif (( $+commands[aur] )); then
  alias pacupd='sudo pacman -Sy && sudo aur'              # Update and refresh the local package and AUR databases against repositories
else
  alias pacupd='sudo pacman -Sy'     # Update and refresh the local package database against repositories
fi
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

# https://bbs.archlinux.org/viewtopic.php?id=93683
paclist() {
  LC_ALL=C pacman -Qei $(pacman -Qu|cut -d" " -f 1)|awk ' BEGIN {FS=":"}/^Name/{printf("\033[1;36m%s\033[1;37m", $2)}/^Description/{print $2}'
}

alias paclsorphans='sudo pacman -Qdt'
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'

pacdisowned() {
  tmp=${TMPDIR-/tmp}/pacman-disowned-$UID-$$
  db=$tmp/db
  fs=$tmp/fs

  mkdir "$tmp"
  trap  'rm -rf "$tmp"' EXIT

  pacman -Qlq | sort -u > "$db"

  find /bin /etc /lib /sbin /usr \
      ! -name lost+found \
        \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

  comm -23 "$fs" "$db"
}

pacmanallkeys() {
  # Get all keys for developers and trusted users
  curl https://www.archlinux.org/{developers,trustedusers}/ |
  awk -F\" '(/pgp.mit.edu/) {sub(/.*search=0x/,"");print $1}' |
  xargs sudo pacman-key --recv-keys
}

pacmansignkeys() {
  for key in $*; do
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    printf 'trust\n3\n' | sudo gpg --homedir /etc/pacman.d/gnupg \
      --no-permission-warning --command-fd 0 --edit-key $key
  done
}
