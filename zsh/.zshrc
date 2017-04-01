# Source zim
if [[ -s ${ZDOTDIR:-${HOME}}/.zim/init.zsh ]]; then
  source ${ZDOTDIR:-${HOME}}/.zim/init.zsh
fi

# Source additional functions
for file in $ZDOTDIR/*; do
  source "$file"
done

# Set name for mpw
export MP_FULLNAME="Michele Pellegrini"

# Android development
export ANDROID_HOME=$HOME/Documents/android-sdk
export ANDROID_SWT=/usr/share/java
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools


# Use a default width of 80 for manpages for more convenient reading
export MANWIDTH=80
