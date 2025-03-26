#!/bin/bash

# Install zsh
if [ "$(uname)" == "Darwin" ]; then
    # macOS
    brew install zsh
elif [ -f "/etc/debian_version" ]; then
    # Debian/Ubuntu
    sudo apt-get update
    sudo apt-get install -y zsh
elif [ -f "/etc/redhat-release" ]; then
    # CentOS/RHEL/Fedora
    sudo yum install -y zsh
fi

# Remove existing oh-my-zsh if it exists
if [ -d ~/.oh-my-zsh ]; then
    rm -rf ~/.oh-my-zsh
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Remove existing plugin if it exists
if [ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]; then
    rm -rf "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
fi

# Install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Copy zshrc with error checking
if [ -f "$HOME/dotfiles/.zshrc" ]; then
    cp "$HOME/dotfiles/.zshrc" ~/.zshrc
    echo "Successfully copied .zshrc file"
else
    echo "Error: .zshrc file not found in $HOME/dotfiles"
    exit 1
fi

# Switch to zsh
exec zsh
