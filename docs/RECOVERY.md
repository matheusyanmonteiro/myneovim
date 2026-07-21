# Fresh-system recovery

This procedure rebuilds VICARIOUS.NVIM after reinstalling the operating
system. Runtime caches and downloaded plugins are deliberately not backed up;
they are reconstructed from this repository.

## Linux or macOS

Install Git first if it is not present, then run:

```bash
git clone https://github.com/matheusyanmonteiro/myneovim.git ~/.config/nvim
cd ~/.config/nvim
./scripts/bootstrap.sh
```

The script:

1. Installs base packages using apt, dnf, pacman, zypper or Homebrew.
2. Installs Neovim 0.12+ in `~/.local/opt/nvim` when necessary.
3. Installs tree-sitter CLI 0.26.1+ in `~/.local/bin` when necessary.
4. Preserves an existing Neovim configuration with a timestamped backup.
5. Restores plugins and the exact revisions from `lazy-lock.json`.
6. Restores Treesitter parsers, clangd and codelldb.

If all system dependencies are already installed:

```bash
./scripts/bootstrap.sh --no-packages
```

Ensure the user-local binary directory is available in your shell:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Persist that line in `~/.bashrc`, `~/.zshrc` or the configuration file used by
your shell.

## Verify the recovery

```bash
./scripts/check.sh
nvim
```

Inside Neovim, useful diagnostics are:

```vim
:checkhealth
:Lazy
:Mason
:LspInfo
```

## Updating the backup

After changing the editor:

```bash
cd ~/.config/nvim
git status
git add .
git commit -m "chore: update Neovim configuration"
git push
```

Review `git diff` before every commit. Never add `~/.local/share/nvim` or
`~/.local/state/nvim`; those directories can contain large, machine-specific
runtime data.
