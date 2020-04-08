let
  nixpkgs-src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz";
    sha256 = "sha256:1jxsaynvj7cis3sdxbs596lxm9wyl0kf8a4519xfxzg8x45wc8cr";
  };

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
      };
    };
  };

  nixpkgs = import nixpkgs-src { overlays = [ my-overlay ]; };

  pkg = nixpkgs.my-haskell-packages.developPackage { root = ./.; };
in
pkg.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ nixpkgs.haskellPackages.cabal-install ];
    })
