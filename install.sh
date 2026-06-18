#!/bin/bash

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Starting dotfiles bootstrap..."
echo "📂 Dotfiles directory: $DOTFILES"

# ----------------------------
# Dependencies
# ----------------------------
for cmd in git stow curl zsh; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "❌ Missing dependency: $cmd"
    exit 1
  }
done

# ----------------------------
# Oh My Zsh
# ----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ----------------------------
# Zsh Plugins
# ----------------------------
echo "🔌 Installing Zsh plugins..."

[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# ----------------------------
# Powerlevel10k
# ----------------------------
echo "🎨 Installing Powerlevel10k..."

[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"

# ----------------------------
# Apply dotfiles with stow
# ----------------------------
echo "🔗 Applying dotfiles..."

cd "$DOTFILES"

stow -R zsh
stow -R p10k
stow -R .config

[ -d git ] && stow -R git

echo ""
echo "✅ Installation complete!"
echo "💡 Run: exec zsh"
