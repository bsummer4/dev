with import <nixpkgs> {};
let haskellPackages = pkgs.haskellPackages.override {
      extension = self: super: {
        Foo = self.callPackage ./. {};
      };
    };
 in lib.overrideDerivation haskellPackages.Foo (attrs: {
      buildInputs = [ haskellPackages.cabalInstall ] ++ attrs.buildInputs;
    })
