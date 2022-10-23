#!/usr/bin/env sh

# Installs nvim plugins headlessly, expect errors and race conditions
# Credit from https://github.com/wbthomason/packer.nvim/issues/198#issuecomment-808927939

install_packer() {
  PACKER_DIRECTORY="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/pack/packer/start/packer.nvim"

  if ! [ -d "$PACKER_DIRECTORY" ]; then
    git clone "https://github.com/wbthomason/packer.nvim" "$PACKER_DIRECTORY"
  fi
}

# this is broken
bootstrap_plugins() {
  LOAD_PLUGIN_FAILS_SILENTLY=false nvim --headless -c \
    'autocmd User PackerComplete quitall' \
    -c 'PackerSync'
}

install_packer
# bootstrap_plugins
