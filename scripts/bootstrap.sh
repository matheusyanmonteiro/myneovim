#!/usr/bin/env bash

set -Eeuo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_OPT="$HOME/.local/opt"
INSTALL_PACKAGES=true

for argument in "$@"; do
  case "$argument" in
    --no-packages) INSTALL_PACKAGES=false ;;
    -h|--help)
      echo "Usage: ./scripts/bootstrap.sh [--no-packages]"
      echo "  --no-packages  Skip the operating-system package manager step."
      exit 0
      ;;
    *)
      echo "Unknown argument: $argument" >&2
      exit 2
      ;;
  esac
done

info() {
  printf '\033[1;36m[VICARIOUS]\033[0m %s\n' "$*"
}

warn() {
  printf '\033[1;33m[VICARIOUS]\033[0m %s\n' "$*" >&2
}

version_at_least() {
  local current="$1"
  local required="$2"
  awk -v current="$current" -v required="$required" 'BEGIN {
    split(current, c, "."); split(required, r, ".")
    for (i = 1; i <= 3; i++) {
      if ((c[i] + 0) > (r[i] + 0)) exit 0
      if ((c[i] + 0) < (r[i] + 0)) exit 1
    }
    exit 0
  }'
}

install_system_packages() {
  if ! $INSTALL_PACKAGES; then
    info "Skipping system packages (--no-packages)."
    return
  fi

  if command -v apt-get >/dev/null 2>&1; then
    info "Installing base packages with apt. Sudo may request your password."
    sudo apt-get update
    sudo apt-get install -y git curl ca-certificates tar gzip unzip ripgrep fd-find build-essential
  elif command -v dnf >/dev/null 2>&1; then
    info "Installing base packages with dnf."
    sudo dnf install -y git curl ca-certificates tar gzip unzip ripgrep fd-find gcc gcc-c++ make
  elif command -v pacman >/dev/null 2>&1; then
    info "Installing base packages with pacman."
    sudo pacman -Sy --needed git curl ca-certificates tar gzip unzip ripgrep fd base-devel
  elif command -v zypper >/dev/null 2>&1; then
    info "Installing base packages with zypper."
    sudo zypper --non-interactive install git curl ca-certificates tar gzip unzip ripgrep fd gcc gcc-c++ make
  elif command -v brew >/dev/null 2>&1; then
    info "Installing base packages with Homebrew."
    brew install git curl ripgrep fd
  else
    warn "No supported package manager found. Install git, curl, tar, gzip, ripgrep, fd and a C/C++ compiler manually."
  fi
}

platform_asset() {
  local project="$1"
  local system architecture
  system="$(uname -s)"
  architecture="$(uname -m)"

  case "$architecture" in
    x86_64|amd64) architecture="x86_64" ;;
    aarch64|arm64) architecture="arm64" ;;
    *) return 1 ;;
  esac

  if [ "$project" = "neovim" ]; then
    case "$system" in
      Linux) printf 'nvim-linux-%s.tar.gz' "$architecture" ;;
      Darwin) printf 'nvim-macos-%s.tar.gz' "$architecture" ;;
      *) return 1 ;;
    esac
  else
    case "$system:$architecture" in
      Linux:x86_64) printf 'tree-sitter-linux-x64.gz' ;;
      Linux:arm64) printf 'tree-sitter-linux-arm64.gz' ;;
      Darwin:x86_64) printf 'tree-sitter-macos-x64.gz' ;;
      Darwin:arm64) printf 'tree-sitter-macos-arm64.gz' ;;
      *) return 1 ;;
    esac
  fi
}

install_neovim() {
  local current="0.0.0"
  if command -v nvim >/dev/null 2>&1; then
    current="$(nvim --version | head -n1 | sed -E 's/.*v([0-9]+\.[0-9]+\.[0-9]+).*/\1/')"
  fi

  if version_at_least "$current" "0.12.0"; then
    info "Neovim $current satisfies the 0.12.0 requirement."
    return
  fi

  local asset archive_name extracted_name destination temp_dir backup
  if ! asset="$(platform_asset neovim)"; then
    warn "Unsupported platform for automatic Neovim installation."
    warn "Install Neovim 0.12+ and run this script again with --no-packages."
    exit 1
  fi

  info "Installing the latest stable Neovim in $LOCAL_OPT/nvim."
  temp_dir="$(mktemp -d)"
  archive_name="$temp_dir/$asset"
  curl -fL "https://github.com/neovim/neovim/releases/latest/download/$asset" -o "$archive_name"
  tar -xzf "$archive_name" -C "$temp_dir"
  extracted_name="${asset%.tar.gz}"
  destination="$LOCAL_OPT/nvim"
  mkdir -p "$LOCAL_OPT" "$LOCAL_BIN"

  if [ -e "$destination" ]; then
    backup="$destination.backup.$(date +%Y%m%d%H%M%S)"
    mv "$destination" "$backup"
    info "Previous local Neovim moved to $backup"
  fi
  mv "$temp_dir/$extracted_name" "$destination"

  if [ -e "$LOCAL_BIN/nvim" ] || [ -L "$LOCAL_BIN/nvim" ]; then
    backup="$LOCAL_BIN/nvim.backup.$(date +%Y%m%d%H%M%S)"
    mv "$LOCAL_BIN/nvim" "$backup"
    info "Previous local nvim launcher moved to $backup"
  fi
  ln -s "$destination/bin/nvim" "$LOCAL_BIN/nvim"
  rm -rf "$temp_dir"
}

install_tree_sitter() {
  local current="0.0.0"
  if command -v tree-sitter >/dev/null 2>&1; then
    current="$(tree-sitter --version | sed -E 's/[^0-9]*([0-9]+\.[0-9]+\.[0-9]+).*/\1/' | head -n1)"
  fi

  if version_at_least "$current" "0.26.1"; then
    info "tree-sitter CLI $current satisfies the 0.26.1 requirement."
    return
  fi

  local asset temp_dir archive
  if ! asset="$(platform_asset tree-sitter)"; then
    warn "Unsupported platform for automatic tree-sitter CLI installation."
    warn "Install tree-sitter CLI 0.26.1+ with your package manager."
    exit 1
  fi

  info "Installing the latest tree-sitter CLI in $LOCAL_BIN."
  mkdir -p "$LOCAL_BIN"
  temp_dir="$(mktemp -d)"
  archive="$temp_dir/$asset"
  curl -fL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/$asset" -o "$archive"
  gzip -dc "$archive" > "$temp_dir/tree-sitter"
  install -m 0755 "$temp_dir/tree-sitter" "$LOCAL_BIN/tree-sitter"
  rm -rf "$temp_dir"
}

prepare_fd_alias() {
  if ! command -v fd >/dev/null 2>&1 && command -v fdfind >/dev/null 2>&1; then
    mkdir -p "$LOCAL_BIN"
    ln -s "$(command -v fdfind)" "$LOCAL_BIN/fd"
    info "Created fd alias for the Debian fdfind executable."
  fi
}

link_configuration() {
  local target_parent backup
  target_parent="$(dirname "$CONFIG_DIR")"
  mkdir -p "$target_parent"

  if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then
    if [ "$(cd "$CONFIG_DIR" 2>/dev/null && pwd -P || true)" = "$REPO_DIR" ]; then
      info "Configuration already points to this repository."
      return
    fi
    backup="$CONFIG_DIR.backup.$(date +%Y%m%d%H%M%S)"
    mv "$CONFIG_DIR" "$backup"
    info "Existing configuration moved to $backup"
  fi

  ln -s "$REPO_DIR" "$CONFIG_DIR"
  info "Linked $CONFIG_DIR -> $REPO_DIR"
}

bootstrap_neovim() {
  export PATH="$LOCAL_BIN:$PATH"
  unset NVIM_APPNAME || true
  info "Restoring plugins and pinned revisions."
  nvim --headless "+Lazy! sync" +qa
  info "Restoring clangd and codelldb through Mason."
  nvim --headless "+MasonToolsInstallSync" +qa
}

install_system_packages
install_neovim
install_tree_sitter
prepare_fd_alias
link_configuration
bootstrap_neovim

info "Installation complete."
info "Make sure $LOCAL_BIN is in PATH, then run: nvim"
info "Recommended terminal font: JetBrainsMono Nerd Font."
