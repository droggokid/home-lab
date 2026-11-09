# Dotfiles

Active packages on this Omarchy installation:

```sh
stow --dir="$HOME/github/home-lab/dotfiles" --target="$HOME" git ssh zsh nvim
stow --no-folding --dir="$HOME/github/home-lab/dotfiles" --target="$HOME" omarchy
```

Use `--simulate --verbose` first on a new machine. Move existing real config
files aside before stowing; avoid `--adopt`, which changes repository files.

The `omarchy` package contains current Hyprland, Foot, Omarchy shell/menu,
Solaar, btop, lazygit, tmux and Starship configuration. Generated theme state and
btop's current-theme link stay outside the repository. Keep `--no-folding`
when restowing so app configuration directories remain real directories.

## Logitech MX Master 3S

Install `solaar` and `stow` before restoring the `omarchy` package. It includes:

- `.config/solaar/config.yaml`: mouse preferences, including Mouse Gestures mode
  for the thumb button (control 195).
- `.config/solaar/rules.yaml`: gesture actions scoped to this mouse.
- `.config/autostart/solaar.desktop`: starts Solaar hidden at login.
- `.config/hypr/input.lua`: disables acceleration for the MX Master 3S.

| Thumb-button action | Desktop action |
| --- | --- |
| Click without moving | Open the Omarchy menu |
| Hold + move left | Previous global workspace |
| Hold + move right | Next global workspace |
| Hold + move up | Toggle fullscreen |
| Hold + move down | Toggle scratchpad |

Gestures run when the thumb button is released. The rules call Omarchy and
Hyprland directly; LogiOps and simulated keyboard input are not required.
After stowing, open Solaar once or run `solaar --window hide` to activate them
in the current session. On later logins it starts automatically.

The saved preferences and rule device ID (`BD214268`) belong to this specific
mouse. A replacement mouse needs its own Solaar device entry and matching rule
ID. Solaar updates `config.yaml` as settings and device metadata change, so
review that file's diff before committing. Restore this alongside the Lua-based
Omarchy configuration; the actions depend on its Hyprland API and menu command.

## Other packages

`hypr`, `kitty`, `.nvim-old`, and `gnome-backup` are legacy setups. Do not
stow `hypr` alongside `omarchy`. The Kubernetes config package is empty.

The Zsh package requires Oh My Zsh, Powerlevel10k, zsh-autosuggestions,
zsh-syntax-highlighting, mise and zoxide. The generated `.p10k.zsh` is included in `zsh/`. Stowing does not change the login shell.
The Git config requires git-delta.

SSH private keys are ignored by Git and need a separate backup. Use mode
0600 for private keys and 0700 for the SSH directory. Do not commit secrets.

Git credentials use `/usr/lib/git-core/git-credential-libsecret` and the desktop keyring.
Neovim imports the generated Omarchy theme through `lua/plugins/theme.lua`.
