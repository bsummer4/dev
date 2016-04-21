#!/usr/bin/env stack
-- stack --resolver lts-3.11 --install-ghc ghc --package turtle --package basic-prelude --package flow

{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

import           ScriptPrelude

import qualified Data.Text     as T
import           Relocate      (relocate)


upload ∷ FilePath → Shell Text
upload fp = do
    uploader   ← (</> "Dropbox/github.com/andreafabrizi/Dropbox-Uploader/dropbox_uploader.sh") <$> home
    line       ← empty |> inproc "sha256sum" [pathStr fp]
    let hash   = strPath (T.take 64 line)
    let blobNm = extension fp |> \case Nothing → hash
                                       Just ext → hash <.> ext
    empty |> inproc (pathStr uploader) ["upload", pathStr fp, pathStr blobNm]

main = view <| do
    filenameArg ← arguments >>= select
    filename ← realpath (strPath filenameArg)
    upload filename
