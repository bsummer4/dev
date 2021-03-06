#!/usr/bin/env stack
-- stack --resolver lts-3.11 --install-ghc ghc --package turtle --package basic-prelude --package flow -- -iscript

{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

import ScriptPrelude

main = do
    installDotfiles
    installNixpkgs

installDotfiles = view <| do
    homedir         ← home
    dotfile         ← realpath =<< ls "dotfiles"
    let dotfileName = (pathStr ⋘ filename) dotfile
    let installTo   = homedir </> strPath("." <> dotfileName)
    empty |> traceInProc "ln" ["-f", "-s", pathStr dotfile, pathStr installTo]

installNixpkgs = view <| do
    empty |> traceInProc "nix-env" ("-iA" : pkgs)

basics = [ "curl", "gitAndTools.gitFull", "gnugrep", "gzip", "less", "mosh"
         , "parted", "psmisc", "tmux", "vim", "wget" ]

general = [ "discount", "gnumake", "gnupg", "gnused", "gnutar", "graphviz", "jq"
          , "mercurial", "screen", "silver-searcher", "w3m", "rlwrap"
          , "openvpn" ]

pkgs = ("nixpkgs." <>) <$> (["heroku"] <> basics <> general)
