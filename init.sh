#!/bin/sh

function heading () {
  printf '\n\e[30;46;1m %s \e[m\n' "$1"
}

function confirm () {
  printf '\e[36;1m%s, and press Enter...\e[m' "$1"
  read
}

heading 'XCode'
xcode-select --install

heading 'Homebrew'
if [ ! -x "`which brew`" ]; then /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; fi
brew update
brew upgrade
brew -v

heading '1Password'
brew cask install 1password
open '/Applications/1Password*.app'
confirm 'Please login to 1Password'

heading 'Google Drive'
brew cask install google-backup-and-sync
open '/Applications/Backup and Sync.app'
confirm 'Login with Google Drive to Google Backup and Sync'

heading 'Mackup'
brew install mackup
# First restoring, restore only default applications (.mackup, .mackup.cfg)
echo '[storage]\nengine = google_drive' > ~/.mackup.cfg
mackup restore
# Second restoring, restore with .mackup & .mackup.cfg that is backed up
mackup restore --force

heading 'brew bundle'
open '/System/Applications/App Store.app'
confirm 'Login to App Store'
brew install mas
brew bundle --global install

heading 'node'
n stable
xargs npm install --global < npm-global.packages

heading 'System Prefernces'
bash .macos

heading 'Restart'
confirm 'Restart PC to take effect of init'
sudo shutdown -r now
