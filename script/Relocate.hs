{-# LANGUAGE OverloadedStrings, LambdaCase, UnicodeSyntax, NoImplicitPrelude, RecordWildCards #-}

module Relocate where

import ScriptPrelude

import qualified Control.Foldl as F
import           Data.Maybe    (maybeToList)
import qualified Data.Text     as T

data Repo = Repo { ghService∷Text, ghUser∷Text, ghRepo∷Text }
  deriving (Show)

githubID ∷ Pattern Text
githubID = do r ← plus (noneOf ":/@ ")
              if ".git" `T.isSuffixOf` r
                then mzero
                else return r

serviceHostname ∷ Pattern Text
serviceHostname = plus (noneOf ":/@ ")

fetchURLPat ∷ Pattern Text
fetchURLPat = do { spaces1; "Fetch"; spaces1; "URL:"; spaces1 }

mb p = p <|> ""

githubSSHUrlParser ∷ Pattern Repo
githubSSHUrlParser = do
    fetchURLPat
    let (srv,gid) = (serviceHostname, githubID)
    let mAuth     = mb (githubID >> "@")
    (s,u,r) ← (do             mAuth; s←srv; ":"; u←gid; "/"; r←gid; mb ".git"; return(s,u,r))
          <|> (do "https://"; mAuth; s←srv; "/"; u←gid; "/"; r←gid; mb ".git"; return(s,u,r))
          <|> (do "ssh://" ;  mAuth; s←srv; "/"; u←gid; "/"; r←gid; mb ".git"; return(s,u,r))
    eof
    return (Repo s u r)

githubRepoUrlParser = githubSSHUrlParser

githubOrigin ∷ MonadIO io ⇒ FilePath → io (Maybe Repo)
githubOrigin fp = processMatches <| do
    traceM "████████████████████████████████████████████████████████████████████████████████"
    traceM ("PROCESSING: " <> pathStr fp)
    cd fp
    urlLine ← empty |> inshell "git remote show origin"
                    |> grep (prefix fetchURLPat)
    traceM ("++++" <> urlLine)
    (select ⋘ match githubRepoUrlParser) urlLine
  where
    processMatches ms = fold ms F.list >>= \case
        []        → do traceM ("Can't parse origin URL for: " <> pathStr fp)
                       return Nothing
        [x]       → do return (Just x)
        all@(x:_) → do traceM ("Ambiguous URL for: " <> pathStr fp)
                       traceM ("   Any of these matches would work: " <> show all)
                       return (Just x)

relocate ∷ FilePath → Shell ()
relocate repoPathArg = do
    dropbox  ← (</> "Dropbox") <$> home
    repoPath ← realpath repoPathArg
    Repo{..} ← select . maybeToList =<< githubOrigin repoPath
    let moveTo = dropbox </> strPath ghService </> strPath ghUser </> strPath ghRepo

    preExisting ← (||) <$> testfile moveTo <*> testdir moveTo

    if preExisting
        then do traceM (pathStr moveTo <> " already exists!")
        else do mktree (parent moveTo)
                traceM ("Moving " <> pathStr repoPath <> " to " <> pathStr moveTo)
                mv repoPath moveTo
