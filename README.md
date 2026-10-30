# Dotfiles

Personal config managed with [GNU Stow](https://www.gnu.org/software/stow/).

Repo: https://github.com/rajabilal555/.dotfiles

## Active packages

| Package    | Target                    |
|------------|---------------------------|
| mango      | `~/.config/mango`         |
| foot       | `~/.config/foot`          |
| noctalia   | `~/.config/noctalia`      |
| alacritty  | `~/.config/alacritty`     |
| zellij     | `~/.config/zellij`        |
| fish       | `~/.config/fish`          |
| zsh        | `~/.zshrc`                |

Other packages in this repo (background, windows, etc.) can be stowed separately when needed.

## First-time setup

```bash
cd ~/Personal/.dotfiles   # or wherever you clone this repo
stow -t ~ mango foot noctalia alacritty zellij fish zsh
```

If configs already exist as real files (not symlinks), adopt them:

```bash
stow -t ~ --adopt mango foot noctalia alacritty zellij fish zsh
```

Make zsh your login shell (optional):

```bash
chsh -s "$(which zsh)"
```

## Daily workflow

Edit configs in `~/.config/...` as usual (they are symlinks into this repo).

```bash
cd ~/Personal/.dotfiles
git status
git diff
git add -A && git commit -m "update mango keybinds"
git push
```

## Restow after pulling on a new machine

```bash
cd ~/Personal/.dotfiles
git pull
stow -t ~ -R mango foot noctalia alacritty zellij fish zsh
```

`-R` restows (unstows then stows again), useful after adding/removing files in a package.

## Add a new package

```bash
mkdir -p myapp/.config/myapp
cp -a ~/.config/myapp/. myapp/.config/myapp/
stow -t ~ --adopt myapp
```

## Remove a package

```bash
stow -t ~ -D myapp
```

This removes symlinks only; files stay in the repo.

## Notes

- `fish_variables` is intentionally untracked (machine-local universal vars).
- **Noctalia v5** uses TOML only. Track hand-written `*.toml` in `~/.config/noctalia/`. GUI overrides live in `~/.local/state/noctalia/settings.toml` (do not stow). Plugins install via Settings → Plugins.
