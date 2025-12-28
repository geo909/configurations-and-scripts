# ---------- Basic completion config ----------
# Let OMZ run compinit ONCE; just configure caching.
export ZSH_DISABLE_COMPFIX=true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"

# Theme & plugins
ZSH_THEME="juanghurtado"
plugins=(git vi-mode sudo)

# Only now: source OMZ (this will run compinit once)
source "$HOME/git/zsh/ohmyzsh/oh-my-zsh.sh"

# ---------- Aliases ----------
[[ -f "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# ---------- pyenv prompt (no subshell in PROMPT) ----------
if command -v pyenv >/dev/null 2>&1; then
  # Only virtualenv hooks; no prompt injection
  eval "$(pyenv virtualenv-init -)"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  _pyenv_prompt=''
  precmd() { _pyenv_prompt="$(pyenv version-name 2>/dev/null)"; }
  PROMPT='%F{magenta}[%{${_pyenv_prompt}%}] %f'$PROMPT
fi

# ---------- gcloud: lazy-load completion ----------
#_gcloud_lazy_source() {
#  local comp_inc="$HOME/google-cloud-sdk/completion.zsh.inc"
#  [[ -f $comp_inc ]] && source "$comp_inc"
#  unfunction _gcloud_lazy_source
#}
#gcloud() { _gcloud_lazy_source; command gcloud "$@"; }

# ---------- terraform: lazy bash completion ----------
_ensure_bashcompinit() { (( $+functions[bashcompinit] )) || { autoload -U +X bashcompinit && bashcompinit; } }
_terraform_lazy_comp() {
  _ensure_bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
  compdef _bash_complete terraform
}
compdef _terraform_lazy_comp terraform

# ---------- jump (no legacy compctl) ----------
__jump_chpwd() { jump chdir }
typeset -gaU chpwd_functions
chpwd_functions+=(__jump_chpwd)
j() { local dir; dir="$(jump cd "$@")"; [[ -d $dir ]] && cd "$dir"; }

# Directory change hook (keep, but no 'clear')
function chpwd() { emulate -L zsh; ls -lh }

# ---------- zsh-users plugins (load ONCE, after OMZ) ----------
# Choose one method; do not also load via zplug.
[[ -r "$ZSHUSERS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSHUSERS/zsh-autosuggestions/zsh-autosuggestions.zsh"
bindkey '^ ' autosuggest-accept
bindkey '^j' autosuggest-execute

[[ -r "$ZSHUSERS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSHUSERS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -f "$HOME/.secrets/dev_env" ]] && source "$HOME/.secrets/dev_env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
