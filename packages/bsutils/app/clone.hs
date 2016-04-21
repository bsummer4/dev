#!/usr/bin/env stack
-- stack --install-ghc build --resolver lts-3.11 --package turtle --package basic-prelude --package flow

{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

import ScriptPrelude
import Relocate (relocate)

main = sh <| do
    repoURL ← arguments >>= select
    tmproot ← (</> ".tmp/") <$> home
    mktree tmproot
    liftIO (print tmproot)
    tmpdir ← using (mktempdir tmproot "clone-repo-script")
    rmdir tmpdir
    traceM "Time to clone!"
    liftIO <| sh <| do
        empty |> proc "git" ["clone", repoURL, pathStr tmpdir]
    traceM "Did!"
    relocate tmpdir
    traceM "Relocated!"
