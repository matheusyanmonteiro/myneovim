# Architecture

VICARIOUS.NVIM is intentionally built from small, inspectable Lua modules. It
does not inherit configuration from a Neovim distribution.

## Startup sequence

```text
init.lua
  ├─ config.options        native editor behavior
  ├─ vicarious.setup       theme, dashboard, bars, Study Mode
  ├─ config.terminal       persistent native terminal
  ├─ config.keymaps        plugin-independent mappings
  └─ config.lazy           lazy.nvim bootstrap and plugin specs
```

`lua/plugins/*.lua` contains one feature area per file. lazy.nvim merges these
specifications and restores the revisions stored in `lazy-lock.json`.

## Directories

| Path | Responsibility |
| --- | --- |
| `colors/vicarious.lua` | colorscheme entry point and terminal palette |
| `lua/vicarious/theme/` | palette and highlight definitions |
| `lua/vicarious/ui/` | dashboard, statusline and winbar |
| `lua/vicarious/study.lua` | focus session state and timer |
| `lua/config/` | native options, mappings, LSP and terminal |
| `lua/plugins/` | plugin specifications grouped by feature |
| `after/ftplugin/cpp.lua` | C++-specific indentation and compiler command |
| `scripts/` | reproducible installation and health checks |
| `docs/` | usage, architecture and recovery documentation |

## Persistence boundaries

Only declarative configuration belongs in this repository. Runtime files are
recreated automatically and remain outside Git:

| Runtime data | Default location |
| --- | --- |
| Plugins and parsers | `~/.local/share/nvim/` |
| Mason tools | `~/.local/share/nvim/mason/` |
| Sessions and logs | `~/.local/state/nvim/` |
| Swap and undo data | paths selected by Neovim under XDG data/state |

This boundary is what makes the repository portable and safe to clone on a new
machine.

## Tool restoration

- lazy.nvim bootstraps itself from `lua/config/lazy.lua`.
- `lazy-lock.json` pins plugin commits.
- nvim-treesitter restores configured parsers during its build step.
- mason-lspconfig restores `clangd`.
- mason-tool-installer restores both `clangd` and `codelldb`.
- `scripts/bootstrap.sh` installs system prerequisites and invokes all of the
  above in headless mode.
