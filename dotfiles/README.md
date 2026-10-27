# Dotfiles

Active packages on this Omarchy installation:

```sh
stow --dir="$HOME/github/home-lab/dotfiles" --target="$HOME" git ssh zsh nvim
stow --no-folding --dir="$HOME/github/home-lab/dotfiles" --target="$HOME" omarchy
```

Use `--simulate --verbose` first on a new machine. Move existing real config
files aside before stowing; avoid `--adopt`, which changes repository files.

The `omarchy` package contains current Hyprland, Foot, Omarchy shell/menu,
btop, lazygit, tmux and Starship configuration. Generated theme state and
btop's current-theme link stay outside the repository. Keep `--no-folding`
when restowing so app configuration directories remain real directories.

`hypr`, `kitty`, `.nvim-old`, and `gnome-backup` are legacy setups. Do not
stow `hypr` alongside `omarchy`. The Kubernetes config package is empty.

The Zsh package requires Oh My Zsh, Powerlevel10k, zsh-autosuggestions,
zsh-syntax-highlighting, mise and zoxide. The generated `.p10k.zsh` is included in `zsh/`. Stowing does not change the login shell.
The Git config requires git-delta.

SSH private keys are ignored by Git and need a separate backup. Use mode
0600 for private keys and 0700 for the SSH directory. Do not commit secrets.

Git credentials use `/usr/lib/git-core/git-credential-libsecret` and the desktop keyring.
Neovim imports the generated Omarchy theme through `lua/plugins/theme.lua`.
