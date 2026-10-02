# My Linux Dotfiles

## Neovim Config

Some parts are shamelessly stolen from [mintelm/dotfiles](https://github.com/mintelm/dotfiles) :)

### Nixvim

`nixvim/` contains the same config as a [nixvim](https://github.com/nix-community/nixvim) flake,
used on the NixOS machines (`mkNixVim.<system> host.properties`). Try it with:

```sh
nix run ./nixvim
```

## Setup

```sh
./setup.sh      # headless (servers): zsh, nvim, tmux
./setup.sh -g   # full: additionally i3, i3status-rust, dunst and GUI extras
                # (xdg-open/okular aliases, tmux copy to X clipboard)
./setup.sh -f   # overwrite existing files (combine with -g)
```

The GUI extras live in `zsh/zsh_gui` and `tmux/config_gui`; the base configs source them only
if `setup.sh -g` linked them. Rerunning headless removes those links again.

The zsh config is a trimmed-down version of Manjaro's and uses these packages if installed
(on other distros it falls back to a plain prompt):
`manjaro-zsh-config` (provides the p10k prompt configs), `zsh-theme-powerlevel10k`,
`zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`.
