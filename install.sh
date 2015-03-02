#!/usr/bin/env bash

cd dotfiles

for x in *
do (cd ~; ln -s dev/dotfiles/$x .$x)
done
