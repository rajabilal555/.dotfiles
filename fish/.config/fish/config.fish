source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


zoxide init fish --cmd cd | source

fzf --fish | source


if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end
