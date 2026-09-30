# My Linux Dotfiles

## Neovim Config

Some parts are shamelessly stolen from [mintelm/dotfiles](https://github.com/mintelm/dotfiles) :)

## Setup

```sh
./setup.sh      # symlink configs into place
./setup.sh -f   # overwrite existing files and create missing dirs
```

The zsh config is a trimmed-down version of Manjaro's and expects these packages:
`manjaro-zsh-config` (provides the p10k prompt configs), `zsh-theme-powerlevel10k`,
`zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`.
