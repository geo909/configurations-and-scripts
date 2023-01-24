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

*Prerequisites:* 

Install `volume-icon-alsa`, `fbxkb` and any other thing that is being autostarted in the bottom of the config file.

## xorg.conf.d

Symlink the contents of `xorg.conf.d` under `/etx/X11/xorg.conf.d/`. You will have to use `sudo`.
This will give you things like system-wide Esc & Tab swap.

## ZSH

1. `git clone https://github.com/ohmyzsh/ohmyzsh.git ~/git/zsh/ohmyzsh`
2. `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~git/zsh/zsh-users/zsh-syntax-highlighting`
3. `git clone https://github.com/zsh-users/zsh-autosuggestions.git ~git/zsh/zsh-users/zsh-autosuggestions`
4. Install `jump` by `yay -S jump` or `snap install jump`
5. Run `~/git/zsh/ohmyzsh/tools/install.sh`
6. Symlink `.zshrc` and `.zsh_aliases` under $HOME

I may have missed something so there may be the need for a little experimentation with this one. Also, uncomment the lines for `pyenv` when the time comes. You may have to run `zsh` on the terminal for the configuration to take effect.

# Scripts

## Bin

1. Symlink the `bin` directory to `$HOME/bin`
2. Add `$HOME/bin` to PATH e.g. by adding the following to `~/.profile`
   ```
   export PATH="$PATH:$HOME/bin"
   ```

