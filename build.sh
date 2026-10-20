#!/bin/bash
# Builds the patched KWin package from this folder. Does not install it.
# BASH_ENV is removed so makepkg does not load the interactive zsh aliases
# (grep --color=always breaks its PGP signature check).
# makepkg is run through the interactive zsh alias (taskset + -j12).
set -euo pipefail

readonly BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BUILD_DIR"

env -u BASH_ENV zsh -ic 'unset BASH_ENV; makepkg --cleanbuild --clean --force'

readonly PACKAGE="$(ls -t "$BUILD_DIR"/kwin-*.pkg.tar.zst | head -n 1)"
echo
echo "Paquet prêt : $PACKAGE"
echo "Pour l'installer :"
echo "  SUDO_ASKPASS=/usr/bin/ksshaskpass yay -U --sudoflags='-A' $PACKAGE"
echo "Puis déconnexion / reconnexion."
