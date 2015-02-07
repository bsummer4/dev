with (import <nixpkgs>{});

stdenv.mkDerivation {
  name = "bendev";
  builder = ./build.sh;
  src = ./.;
  inherit wget git tmux screen;
}
