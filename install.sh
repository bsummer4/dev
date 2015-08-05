#!/usr/bin/env bash

cd dotfiles

for x in *
do (cd ~; ln -f -s dev/dotfiles/$x .$x)
done

basics="curl gitAndTools.gitFull gnugrep gzip less mosh parted psmisc tmux vim wget"
general="discount gnumake gnupg gnused gnutar graphviz jq mercurial screen silver-searcher w3m rlwrap openvpn"

nix-env -iA $(for pkg in $basics $general heroku; do echo nixpkgs.$pkg; done)
