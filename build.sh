source $stdenv/setup
cd $src
mkdir -p $out
tar c * | tar x -C $out
