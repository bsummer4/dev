with (import <nixpkgs>{});

stdenv.mkDerivation {
  name = "bendev";
  builder = ./build.sh;
  src = ./.;
  buildInputs = [

    # Fundamentals
    wget git tmux screen discount w3m gnumake

    # Haskell Tools
    haskellPackages.stylishHaskell haskellPackages.ghcPlain

  ];
}
