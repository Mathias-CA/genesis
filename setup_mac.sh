#!/usr/bin/env bash

# Setup script for setting up a new macos machine

echo "Starting setup"

# install xcode CLI
xcode-select —-install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew…"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
  ruby
  iterm2
  zsh
  cocoapods
  fastlane
  swiftgen
  swiftlint
)

echo "Installing packages…"
brew install ${PACKAGES[@]}

# any additional steps

# om my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# link readline
brew link --force readline

echo "Cleaning up…"
brew cleanup

echo "Run"

pod install
fastlane match
fastlane app_icon

xed .
