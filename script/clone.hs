#!/usr/bin/env stack
-- stack --resolver lts-3.11 --install-ghc ghc --package turtle --package basic-prelude --package flow

{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

import ScriptPrelude
import Relocate (relocate)

main = sh <| do
    repoURL ← arguments >>= select
    tmproot ← (</> ".tmp/") <$> home
    mktree tmproot
    tmpdir ← using (mktempdir tmproot "clone-repo-script")
    rmdir tmpdir
    traceM "Time to clone!"
    liftIO <| sh <| do
        empty |> proc "git" ["clone", repoURL, pathStr tmpdir]
    traceM "Did!"
    relocate tmpdir
    traceM "Relocated!"
