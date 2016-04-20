{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude #-}

module ScriptPrelude
    ( module Prelude
    , module BasicPrelude
    , module Turtle
    , module Flow
    , module FP
    , pathStr, strPath
    , traceM, traceShowM, trace, traceShowId, traceShow
    , traceInProc, traceInShell, traceShell, traceProc
    , (⋘), (⋙)
    )
  where



import BasicPrelude (intercalate, show)
import Prelude      hiding (FilePath, show, ($), (&))
import Turtle       hiding (FilePath, show, ($), (&))
import Flow

import           Control.Arrow
import           Control.Category          (Category)
import qualified Data.Text                 as T
import           Debug.Trace               hiding (trace, traceM)
import qualified Debug.Trace
import           Filesystem.Path           (FilePath)
import qualified Filesystem.Path           as FP
import qualified Filesystem.Path.CurrentOS as FP
import qualified System.Environment

infixr 1 ⋘
(⋘) :: Category cat => cat b c -> cat a b -> cat a c
(⋘) = (<<<)

infixr 1 ⋙
(⋙) :: Category cat => cat a b -> cat b c -> cat a c
(⋙) = (>>>)

traceM :: Monad m => Text -> m ()
traceM = Debug.Trace.traceM . T.unpack

trace :: Text -> a -> a
trace = Debug.Trace.trace . T.unpack

pathStr :: FilePath → Text
pathStr = FP.toText ⋙ (\case { Left t→t; Right t→t })

strPath :: Text → FilePath
strPath = FP.fromText

traceInProc cmd args input = do
    traceM (intercalate " " (show <$> cmd:args))
    inproc cmd args input

traceProc cmd args input = do
    traceM (intercalate " " (show <$> cmd:args))
    proc cmd args input

traceInShell cmd input = traceM cmd >> inshell cmd input

traceShell cmd input = traceM cmd >> shell cmd input
