#!/usr/bin/env stack
-- stack --resolver lts-3.11 --install-ghc runghc --package turtle --package basic-prelude


{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

import Prelude      hiding (FilePath,show)
import BasicPrelude (intercalate,show)
import Turtle

import qualified Data.Text                 as T
import qualified Debug.Trace
import qualified Filesystem.Path           as FP
import qualified Filesystem.Path.CurrentOS as FP


-- Things that should be in the prelude ----------------------------------------------------------------------

traceM = Debug.Trace.traceM . T.unpack

pathStr :: FilePath -> Text
pathStr fp = case FP.toText fp of Left t->t; Right t->t
-- pathStr = FP.toText & \case { Left t→t; Right t→t }

strPath :: Text -> FilePath
strPath = FP.fromText


-- Our script ------------------------------------------------------------------------------------------------

basics = [ "curl", "gitAndTools.gitFull", "gnugrep", "gzip", "less", "mosh"
         , "parted", "psmisc", "tmux", "vim", "wget" ]

general = [ "discount", "gnumake", "gnupg", "gnused", "gnutar", "graphviz", "jq"
          , "mercurial", "screen", "silver-searcher", "w3m", "rlwrap"
          , "openvpn" ]

pkgs = ("nixpkgs." <>) <$> (["heroku"] <> basics <> general)

traceInProc cmd args input = do
    traceM (intercalate " " (show <$> cmd:args))
    inproc cmd args input

installDotfiles = view $ do
    homedir ← home
    dotfile         ← realpath =<< ls "dotfiles"
    let dotfileName = pathStr $ FP.filename dotfile
    let installTo   = homedir </> strPath("." <> dotfileName)
    empty & traceInProc "ln" ["-f", "-s", pathStr dotfile, pathStr installTo]

installNixpkgs = view $ do
    empty & traceInProc "nix-env" ("-iA" : pkgs)

main = do
    installDotfiles
    installNixpkgs
