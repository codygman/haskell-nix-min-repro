let
  nixpkgs-src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz";
    sha256 = "sha256:1jxsaynvj7cis3sdxbs596lxm9wyl0kf8a4519xfxzg8x45wc8cr";
  };
  HTF-nixpkgs = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/1caac6f2dc467dd67eff688f3a9befdad5d0f9d0.tar.gz")
    {};
  my-overlay = self: super: {
    my-haskell-packages = super.haskellPackages.override {
      overrides = hSelf: hSuper: {
        bson =
          let
            bson-with-disabled-flag =
              self.haskell.lib.disableCabalFlag hSuper.bson "_old-network";
            bson-unbroken = self.haskell.lib.markUnbroken bson-with-disabled-flag;
            bson-with-build-depend =
              self.haskell.lib.addBuildDepend bson-unbroken hSelf.network-bsd;
          in
          bson-with-build-depend;
        network-bsd = hSelf.callHackage "network-bsd" "2.8.1.0" {};
        HPDF =
          let
            unbroken-old-HTF = self.haskell.lib.markUnbroken HTF-nixpkgs.haskellPackages.HTF;
            unbroken-HPDF = self.haskell.lib.markUnbroken self.haskellPackages.HPDF;
            unbroken-HPDF-with-old-HTF = self.haskell.lib.addBuildDepend unbroken-HPDF unbroken-old-HTF;
          in unbroken-HPDF-with-old-HTF;
        # error:
# nix-build  #
# building '/nix/store/zlcp518lf55ahfasmr7nx59zgbxamrk1-cabal2nix-haskell-nix-minimal.drv'...
# installing
# error: Package ‘HTF-0.14.0.3’ in /nix/store/2h7bbn0kxlnkxnqhqg03jk0w0jpxkaz6-source/pkgs/development/haskell-modules/hackage-packages.nix:9299 is marked as broken, refusing to evaluate.
      };
    };
  };

  nixpkgs = import nixpkgs-src { overlays = [ my-overlay ]; };

  pkg = nixpkgs.my-haskell-packages.developPackage { root = ./.; };
in
pkg.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ nixpkgs.haskellPackages.cabal-install ];
    })
