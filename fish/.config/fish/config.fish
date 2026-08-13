source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


zoxide init fish --cmd cd | source

fzf --fish | source

if status is-interactive
    # At this point, specify the Zellij config dir, so we can launch it manually if we want to
    export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij

    if [ "$TERM" = "foot" ]
      eval (zellij setup --generate-auto-start fish | string collect)
    end
end
