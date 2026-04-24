# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Formatting

Lua code is formatted with **StyLua**. Config is in `.stylua.toml`:
- 2-space indentation, 160 column width, single quotes preferred, no call parentheses

Check formatting: `stylua --check .`
Apply formatting: `stylua .`

## Architecture

This config is based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). The entry point is `init.lua`, which sources four modules in order:

1. `lua/options.lua` — vim options
2. `lua/keymaps.lua` — keymaps and autocommands
3. `lua/lazy-bootstrap.lua` — installs lazy.nvim if missing
4. `lua/lazy-plugins.lua` — loads all plugins via lazy.nvim

**Two plugin tiers:**
- `lua/kickstart/plugins/` — upstream kickstart plugins (gitsigns, telescope, lspconfig, conform, cmp, tokyonight, treesitter, mini, which-key, etc.). These track the kickstart.nvim upstream.
- `lua/custom/plugins/` — personal additions. Each file returns a plugin spec; all files in this directory are auto-imported via `{ import = 'custom.plugins' }` in `lazy-plugins.lua`. A local plugin at `~/Documents/FirstProject.../my-first-plugin.nvim` is also loaded.

**Active colorscheme:** catppuccin-frappe (`lua/custom/plugins/catppuccin.lua`). Other themes (black-metal, dracula, kanagawa, gruvbox, tokyonight) exist in `lua/custom/plugins/` or `lua/kickstart/plugins/` — most are commented out.

**LSP setup** (`lua/kickstart/plugins/lspconfig.lua`): Mason auto-installs servers defined in the `servers` table (clangd, gopls, pyright, jdtls, svelte, rust_analyzer, csharp_ls, omnisharp, lua_ls). Add new servers there.

**Formatting** (`lua/kickstart/plugins/conform.lua`): Format-on-save is enabled. Formatters: `stylua` (lua), `isort`+`black` (python), `prettierd`/`prettier` (js). C/C++ format-on-save is disabled.

## Key custom keymaps

| Key | Action |
|-----|--------|
| `<leader>S` | Save file |
| `<leader>f` | Format buffer (conform) |
| `<leader>gg` | Open LazyGit |
| `<leader>ct` | Telescope colorscheme picker |
| `<leader>d/dd/D` | Delete without yanking |
| `<leader>p/P` (visual) | Paste without yanking replaced text |
| `<C-j>/<C-k>` | Navigate quickfix list |
| `<leader>e` | Open diagnostic float |
| `J/K` (visual) | Move selection up/down |

## Adding plugins

Create a new file in `lua/custom/plugins/<name>.lua` returning a lazy.nvim plugin spec. It will be auto-loaded.

## Useful Neovim commands

- `:Lazy` — plugin manager UI
- `:Mason` — LSP/tool installer UI
- `:checkhealth` — diagnose issues
- `:ConformInfo` — formatter status
