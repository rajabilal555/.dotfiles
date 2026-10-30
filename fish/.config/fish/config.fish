# CachyOS vendor config (skip on this Fedora box)
if test (hostname) != bilal-laptop
    and test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

zoxide init fish --cmd cd | source

fzf --fish | source

if status is-interactive
    set -gx ZELLIJ_CONFIG_DIR $HOME/.config/zellij

    if test "$TERM" = "foot"; and command -q zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end


    if test "$TERM" = "xterm-ghostty"; and command -q zellij
        eval (zellij setup --generate-auto-start fish | string collect)
    end

end

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME/bin
# pnpm end
