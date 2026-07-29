# AGENTS.md

## Cursor Cloud specific instructions

This repository is a **personal dotfiles repo managed with [chezmoi](https://www.chezmoi.io/)**.
It is not an application: there is no build system, test suite, server, or database. The
repo root *is* the chezmoi source directory. Files use chezmoi source-state naming
conventions, e.g. `dot_gitconfig` -> `~/.gitconfig`, `private_fish/` -> `~/.config/fish/`
(mode `700`), `empty_settings.json` -> `settings.json`. `README.md` is ignored via
`.chezmoiignore`.

### Tooling
- `chezmoi` is the only tool required to work with this repo. The update script installs it
  to `~/.local/bin` (already on `PATH` for login and interactive shells).
- `fish` is the target shell for most of the config; the update script does not install it.
  Install it manually if you need to load/verify the config (`sudo apt-get install -y fish`).

### Working with the dotfiles (from the repo root, which is the source dir)
- Preview changes without touching real files:
  `chezmoi apply --force --source="$PWD" --destination="$HOME/chezmoi-demo-home"`
  (use a throwaway `--destination` to avoid clobbering the agent's own `~/.gitconfig`,
  `~/.config`, etc.).
- Show diff / status against a destination: `chezmoi diff` / `chezmoi status`
  (both accept `--source` and `--destination`).

### Non-obvious caveats
- Running `chezmoi diff` and then `chezmoi apply` against the same `--destination` in the
  same session can trigger an interactive TTY prompt ("has changed since chezmoi last
  wrote it"). In a non-interactive VM this fails with `could not open a new TTY`. Pass
  `--force` to `apply`, and/or reset chezmoi's persistent state with
  `rm -rf ~/.config/chezmoi` between runs.
- `dot_config/private_fish/conf.d/rustup.fish` unconditionally does
  `source "$HOME/.cargo/env.fish"`. If Rust/cargo is not installed in the target `HOME`,
  fish prints a non-fatal `No such file or directory` error on startup. This is expected
  (the owner's machine has cargo) and does not stop the config from loading.
- Most other integrations (`fzf`, `zoxide`, `mise`, `direnv`, `starship`) are guarded with
  `type -q`, so they no-op silently when the tool is absent.
- `conf.d/fisher.fish` bootstraps the Fisher plugin manager over the network on first
  interactive fish load (`curl` from GitHub); it is skipped once `fisher` exists.
