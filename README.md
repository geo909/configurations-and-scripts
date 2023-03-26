# Configurations

## Neovim

1. Symlink the `nvim` directory to `$HOME/.config/nvim`
2. Open nvim and run `:PlugInstall`

You may need to install `python3-pynvim` or a similarly-named package for the deoplete plugin to work.

## Vifm

Symlink the `vifm` directory to `$HOME/.config/vifm`

## i3

1. Symlink `i3` to `$HOME/i3`
2. Symlink `i3status` to `$HOME/i3status`

*Prerequisites:* Install `volume-icon-alsa`, `fbxkb` and any other thing that is being autostarted in the bottom of the config file.

## xorg.conf.d

Symlink the contents of `xorg.conf.d` under `/etx/X11/xorg.conf.d/`. You will have to use `sudo`.
This will give you things like system-wide Esc & Tab swap.

## ZSH

1. `git clone https://github.com/ohmyzsh/ohmyzsh.git ~/git/zsh/ohmyzsh`
2. `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/git/zsh/zsh-users/zsh-syntax-highlighting`
3. `git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/git/zsh/zsh-users/zsh-autosuggestions`
4. Install `jump` by `yay -S jump` or `snap install jump`
5. Run `~/git/zsh/ohmyzsh/tools/install.sh`
6. Symlink `.zshrc` and `.zsh_aliases` under $HOME

I may have missed something so there may be the need for a little experimentation with this one. Also, uncomment the lines for `pyenv` when the time comes. You may have to run `zsh` on the terminal for the configuration to take effect.

Also you need to install `lsb_core` (ubuntu) otherwise when sourcing `.zsh_aliases` there will be an annoying message "no lsb modules are available"

## profile

### .profile_george

Symlink this to ~/.profile_george and add the following to your original .profile: `source .profile_george`

### .windows

Symlink this to `$HOME/applications/configurations`. You need vpn for this to work.

## python

### pyenv

1. Install build dependencies:
   ```
   sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
   libbz2-dev libreadline-dev libsqlite3-dev curl \
   libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
   ```
2. `git clone https://github.com/pyenv/pyenv ~/git/python/pyenv`
3. Symlink `~/git/python/pyenv` to `~/.pyenv`
4. Add the following into `.profile`, if it is not there already.
   ```
   # Pyenv
   export PYENV_ROOT="$HOME/.pyenv"
   command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"
   ```

### pyenv-virtualenv

There is a guide [here](https://github.com/pyenv/pyenv-virtualenv). In short:

1. `git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv`
2. `echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc`
3. Add the following into your `.zshrc` if they are not there already:
   ```
   eval "$(pyenv virtualenv-init -)"
   export PS1='%F{magenta}[$(pyenv version-name)] '$PS1
   ```

# Scripts

## Bin

1. Symlink the `bin` directory to `$HOME/bin`
2. Add `$HOME/bin` to PATH e.g. by adding the following to `~/.profile`
   ```
   export PATH="$PATH:$HOME/bin"
   ```



