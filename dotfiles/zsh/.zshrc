# Powerlevel10k instant prompt must stay near the top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh handles completion initialization.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git sudo history extract zsh-autosuggestions zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Keep PATH entries unique; mise manages language runtimes.
typeset -U path PATH
path+=("$HOME/.local/bin")
[[ -d "$HOME/go/bin" ]] && path+=("$HOME/go/bin")
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Personal shortcuts.
alias vim='nvim'
alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.config/nvim'
alias dotfiles='cd ~/github/home-lab/dotfiles'
alias cluster='cd ~/github/home-lab/cluster'
alias scripts='cd ~/github/home-lab/cluster/infra/scripts'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history 1 | sed -e "s/^[ ]*[0-9]\+[ ]*//;s/[;&|][ ]*alert$//")"'

# Keep an inherited working SSH agent; otherwise find a session agent.
if [[ ! -S "$SSH_AUTH_SOCK" && -n "$XDG_RUNTIME_DIR" ]]; then
  for agent_socket in "$XDG_RUNTIME_DIR"/{gcr/ssh,keyring/ssh,ssh-agent.socket}; do
    if [[ -S "$agent_socket" ]]; then
      export SSH_AUTH_SOCK="$agent_socket"
      break
    fi
  done
  unset agent_socket
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
