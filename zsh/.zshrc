# Paths
typeset -U path PATH
export PNPM_HOME="$HOME/.local/share/pnpm"
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$PNPM_HOME/bin"
  "$HOME/.local/share/lerd/bin"
  "$HOME/fvm/default/bin"
  "$HOME/fvm/bin"
  "$HOME/.pub-cache/bin"
  $path
)

# Android SDK (prefer Google tools over distro android-tools)
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
path=(
  "$ANDROID_HOME/cmdline-tools/latest/bin"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/emulator"
  $path
)

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME/.git ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# Fish-like plugins + fzf-tab (from zensh)
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Useful Oh My Zsh bits without full OMZ
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit
zinit cdreplay -q

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# Ctrl+Arrows / Ctrl+Backspace / Ctrl+Delete (Fish-like; not bound by default in zsh)
bindkey '^[[1;5C' forward-word          # Ctrl+Right
bindkey '^[[1;5D' backward-word         # Ctrl+Left
bindkey '^[[1;5A' beginning-of-line     # Ctrl+Up (common expectation)
bindkey '^[[1;5B' end-of-line           # Ctrl+Down
bindkey '^H' backward-kill-word         # Ctrl+Backspace (many terminals)
bindkey '^[[127;5u' backward-kill-word  # Ctrl+Backspace (Kitty/Ghostty keyboard protocol)
bindkey '^[[3;5~' kill-word             # Ctrl+Delete
bindkey '^[[3~' delete-char             # Delete

# History
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color=auto'
alias c='clear'

# Shell integrations
command -v fzf >/dev/null && source <(fzf --zsh)
command -v zoxide >/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v starship >/dev/null && eval "$(starship init zsh)"

# Zellij auto-start in foot / ghostty
if [[ -z $ZELLIJ && -o interactive ]] && command -v zellij >/dev/null; then
  export ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
  case $TERM in
    foot|xterm-ghostty)
      eval "$(zellij setup --generate-auto-start zsh)"
      ;;
  esac
fi

# Update RPMs, Flatpaks, and firmware
upall() {
  sudo dnf upgrade --refresh \
    && flatpak update \
    && fwupdmgr refresh --force \
    && fwupdmgr update
}
