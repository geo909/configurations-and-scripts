# Symlink under home
#
# --- PATH & env for whole session ---
export QT_QPA_PLATFORMTHEME=qt5ct

# pyenv shims on PATH once per login (fast)
if command -v pyenv >/dev/null 2>&1; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  # No prompt hooks here; save for .zshrc
fi

# Google Cloud SDK PATH only (cheap)
[[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"

# Oh My Zsh paths
export ZSH="$HOME/git/zsh/ohmyzsh"
export ZSHUSERS="$HOME/git/zsh/zsh-users"

# Optional: move caches off slow $HOME/NFS
export ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$HOME/.cache/oh-my-zsh}"
mkdir -p "$ZSH_CACHE_DIR"

# If you keep zplug: init state only (no updates, no network)
export ZPLUG_HOME="$HOME/.zplug"
if [[ -d "$ZPLUG_HOME" ]]; then
  export ZPLUG_UPDATE=0
  export ZPLUG_LOG_LEVEL=error
  export ZPLUG_LOG_PATH=/dev/null
  export ZPLUG_LOADFILE=/dev/null
fi

# Secrets (safe at login)
[[ -f "$HOME/.secrets/dev_env" ]] && source "$HOME/.secrets/dev_env"
