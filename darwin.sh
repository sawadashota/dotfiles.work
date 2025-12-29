#!/usr/bin/env bash
#
set -e

echo "🔧 Setting up macOS preferences..."

# === Finder ===
echo "→ Configuring Finder..."
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder QuitMenuItem -bool true

# === Screenshot ===
echo "→ Configuring Screenshots..."
defaults write com.apple.screencapture location -string "${HOME}/Downloads"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture name -string "SS"
defaults write com.apple.screencapture disable-shadow -bool true

# === sudo timeout ===
echo "→ Configuring sudo timeout..."
if ! sudo grep -q "timestamp_timeout=15" /etc/sudoers.d/timeout 2>/dev/null; then
    echo "Defaults    timestamp_timeout=15" | sudo tee /etc/sudoers.d/timeout > /dev/null
    sudo chmod 440 /etc/sudoers.d/timeout
    echo "✓ sudo timeout set to 15 minutes"
else
    echo "✓ sudo timeout already configured"
fi

# === 設定を反映 ===
echo "→ Restarting affected applications..."
killall Finder
killall SystemUIServer

echo "✅ macOS setup complete!"
echo ""
echo "Changes applied:"
echo "  • Finder: Show all extensions and hidden files"
echo "  • Finder: Desktop icons disabled"
echo "  • Screenshots: Saved to ~/Downloads as SS-*.png"
echo "  • sudo: Password timeout extended to 15 minutes"
