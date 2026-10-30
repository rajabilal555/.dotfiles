function upall --description 'Update RPMs, Flatpaks, and firmware'
    sudo dnf upgrade --refresh
    and flatpak update
    and fwupdmgr refresh --force
    and fwupdmgr update
end
