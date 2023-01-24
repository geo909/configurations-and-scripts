# Configurations

## Nvim

1. Symlink the `nvim` directory to `$HOME/.config/nvim`
2. Open nvim and run `:PlugInstall`

You may need to install `python3-pynvim` or a similarly-named package for the deoplete plugin to work.

## Vifm

Symlink the `vifm` directory to `$HOME/.config/vifm`

# Scripts

## Bin

1. Symlink the `bin` directory to `$HOME/bin`
2. Add `$HOME/bin` to PATH e.g. by adding the following to `~/.profile`
   ```
   export PATH="$PATH:$HOME/bin"
   ```

## i3

1. Symlink `i3` to `$HOME/i3`
2. Symlink `i3status` to `$HOME/i3status`

*Prerequisites:* 

Install `volume-icon-alsa`, `fbxkb` and any other thing that is being autostarted in the bottom of the config file.

## xorg.conf.d

Symlink the contents of `xorg.conf.d` under `/etx/X11/xorg.conf.d/`. You will have to use `sudo`.
This will give you things like system-wide Esc & Tab swap.


