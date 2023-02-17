# The following lines were added by compinstall
zstyle :compinstall filename '/home/tzanakis/.zshrc'
autoload -Uz compinit
compinit

# Path to your oh-my-zsh installation.
# Requires cloning the repo
ZSH=~/git/zsh/ohmyzsh
ZSHUSERS=~/git/zsh/zsh-users

# ZSH_THEME="robbyrussell"
ZSH_THEME="juanghurtado"


# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"
# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode sudo) 

# You can customize where you put it but it's generally recommended that you put in $HOME/.zplug
if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi

# Initialize plugins
source ~/.zplug/init.zsh

# Load completion library for those sweet [tab] squares
#zplug "lib/completion", from:oh-my-zsh
#zplug "plugins/git", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions"

# Requires the installation of zsh-syntax-highlighting (exists in both ubuntu and arch)

## Old Manjaro setup
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Requrires to clone zsh-users/zsh-syntax-highlighting and zsh-users/zsh-autosuggestions
source $ZSHUSERS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSHUSERS/zsh-autosuggestions/zsh-autosuggestions.zsh


bindkey '^ ' autosuggest-accept
bindkey '^j' autosuggest-execute
# See https://github.com/zsh-users/zsh-autosuggestions

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

source ~/.zsh_aliases
#source ~/.profile

export PATH="$HOME/.screenlayout:$HOME/bin:$PATH"

export PIP_REQUIRE_VIRTUALENV=true


ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
source $ZSH/oh-my-zsh.sh

# Requires: sudo pacman -S zsh-syntax-highlighting
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Python pyenv and virtual env
## eval "$(pyenv init -)" # No: put in .profile instead
## eval "$(pyenv virtualenv-init -)"
export PS1='%F{magenta}[$(pyenv version-name)] '$PS1
## export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Jump
# Requiries yay -S jump or sudo snap install jump
## eval "$(jump shell zsh --bind=j)"

# The following lines are autogenerated:
__jump_chpwd() {
  jump chdir
}

jump_completion() {
  reply="'$(jump hint "$@")'"
}

j() {
  local dir="$(jump cd $@)"
  test -d "$dir" && cd "$dir"
}

typeset -gaU chpwd_functions
chpwd_functions+=__jump_chpwd

compctl -U -K jump_completion j

############ Ls after entering a directory
function chpwd() {
    emulate -L zsh
    clear; ls -lh
}

# eval "$(direnv hook zsh)"

