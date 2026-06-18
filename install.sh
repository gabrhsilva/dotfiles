#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "🚀 Starting dotfiles bootstrap..."

# ----------------------------
# Oh My Zsh
# ----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# ----------------------------
# Zsh Plugins
# ----------------------------
echo "🔌 Installing Zsh plugins..."

# Autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Syntax highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ----------------------------
# Powerlevel10k theme
# ----------------------------
echo "🎨 Installing Powerlevel10k..."

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ----------------------------
# Apply dotfiles with stow
# ----------------------------
echo "🔗 Applying dotfiles with stow..."

cd "$DOTFILES"

stow zsh
stow kitty
stow p10k

echo "✅ Done! Restart your terminal."
