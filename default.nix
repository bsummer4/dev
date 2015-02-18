with (import <nixpkgs>{});

stdenv.mkDerivation {
  name = "bendev";
  builder = ./build.sh;
  src = ./.;

  buildInputs = [

    # Fundamentals
    curl discount gitAndTools.gitFull gnugrep gnumake gnused gnutar gzip
    jq less util-linux-curses mercurial screen silver-searcher tmux vim
    w3m wget

    # Go Tools
    go

    # Haskell Tools
    haskellPackages.stylishHaskell haskellPackages.ghcPlain
    haskellPackages.hlint haskellPackages.hoogle

  ];
}
