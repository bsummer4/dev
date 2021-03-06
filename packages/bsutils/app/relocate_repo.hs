#!/usr/bin/env stack
-- stack --resolver lts-3.11 --install-ghc ghc --package turtle --package basic-prelude --package flow -- -iscript

{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude, RecordWildCards #-}

import ScriptPrelude

import Relocate (relocate)

import qualified Control.Foldl as F
import qualified Data.Text     as T

main = sh (arguments >>= select >>= strPath .> relocate)
