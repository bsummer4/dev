#!/usr/bin/env bash

cd dotfiles

for x in *
do (cd ~; ln -f -s dev/dotfiles/$x .$x)
done

basics="vim wget"
general="discount jq silver-searcher w3m rlwrap"

# nix-env -iA $(for pkg in $basics $general; do echo nixpkgs.$pkg; done)
