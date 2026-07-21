#!/usr/bin/env bash

set -u

failures=0

check_command() {
  local command_name="$1"
  if command -v "$command_name" >/dev/null 2>&1; then
    printf '\033[32m[OK]\033[0m   %-12s %s\n' "$command_name" "$(command -v "$command_name")"
  else
    printf '\033[31m[MISS]\033[0m %-12s not found\n' "$command_name"
    failures=$((failures + 1))
  fi
}

for command_name in nvim git curl tar tree-sitter rg fd gcc g++ lsof ps codex claude; do
  check_command "$command_name"
done

if command -v nvim >/dev/null 2>&1; then
  if nvim --headless "+lua assert(vim.fn.has('nvim-0.12') == 1); assert(vim.g.colors_name == 'vicarious'); print('[OK]   VICARIOUS configuration loaded')" +qa 2>/dev/null; then
    :
  else
    printf '\033[31m[FAIL]\033[0m Neovim could not load the VICARIOUS configuration\n'
    failures=$((failures + 1))
  fi
fi

if command -v nvim >/dev/null 2>&1; then
  if nvim --headless "+lua require('lazy').load({ plugins = { 'sidekick.nvim' } }); assert(vim.fn.exists(':Sidekick') == 2); assert(vim.fn.executable('codex') == 1); assert(vim.fn.executable('claude') == 1); print('[OK]   Codex + Claude AI workbench loaded')" +qa 2>/dev/null; then
    printf '\033[32m[OK]\033[0m   %-12s %s\n' "AI" "Codex + Claude workbench loaded"
  else
    printf '\033[31m[FAIL]\033[0m AI workbench could not load Codex and Claude\n'
    failures=$((failures + 1))
  fi
fi

if [ "$failures" -eq 0 ]; then
  printf '\n\033[1;32mVICARIOUS system check passed.\033[0m\n'
  exit 0
fi

printf '\n\033[1;31mSystem check found %d missing or invalid component(s).\033[0m\n' "$failures"
exit 1
