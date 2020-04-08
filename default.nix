let
  nixpkgs-src = builtins.fetchTarball {
    # url = "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz";
    # sha256 = "sha256:1jxsaynvj7cis3sdxbs596lxm9wyl0kf8a4519xfxzg8x45wc8cr";
    # 2020-04-08
    # url = "https://github.com/NixOS/nixpkgs/archive/f3cf0f074a16b7a758e399e93f79e2037f329dc4.tar.gz";
    # sha256 = "sha256:0lcryrficd603fb67qns3sn650nvilv6saca0hxr4jh76np8pl2s";
    # working from https://github.com/EdutainmentLIVE/smurf/blob/a0a7b18b9e358e579537d425fabd3b370d829eb8/nix/nixpkgs-unstable-2020-03-28.json
    url = "https://github.com/NixOS/nixpkgs/archive/ae6bdcc53584aaf20211ce1814bea97ece08a248.tar.gz";
    sha256 = "sha256:0lcryrficd603fb67qns3sn650nvilv6saca0hxr4jh76np8pl2s";
  };
  # HTF-nixpkgs = import (builtins.fetchTarball
  #   "https://github.com/NixOS/nixpkgs/archive/1caac6f2dc467dd67eff688f3a9befdad5d0f9d0.tar.gz")
  #   {};
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

        # hpdf of current nixpkgs-src revision
        # NOTE: this kind of mixing might not be supported
        # HTF = self.haskell.lib.markUnbroken hSuper.HTF;
        # HPDF = self.haskell.lib.markUnbroken hSuper.HPDF;
        # HPDF trying to splice in last c compiler that worked with it
        # HPDF =
        #   let
        #     unbroken-old-HTF = self.haskell.lib.markUnbroken HTF-nixpkgs.haskellPackages.HTF;
        #     unbroken-HPDF = self.haskell.lib.markUnbroken self.haskellPackages.HPDF;
        #     unbroken-HPDF-with-old-HTF = self.haskell.lib.addBuildDepend unbroken-HPDF unbroken-old-HTF;
        #   in unbroken-HPDF-with-old-HTF;

        #   HPDF using my fork with no HTF dependency
        #   NOTE: get 'Setup: Encountered missing or private dependencies: HPDF -any' error
        HPDF = self.fetchFromGitHub {
          owner = "codygman";
          repo = "HPDF";
          rev = "a87f1f68ab8c6abc4de26d40a3c28b1b108effe3";
          sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
        };
      };
    };
  };

  nixpkgs = import nixpkgs-src { overlays = [ my-overlay ]; };

  pkg = nixpkgs.my-haskell-packages.developPackage {
    root = ./.;
    # apparently no effect?
    # source-overrides = {
    #     HTF = nixpkgs.haskell.lib.markUnbroken nixpkgs.haskellPackages.HTF;
    #     HPDF = nixpkgs.haskell.lib.markUnbroken nixpkgs.haskellPackages.HPDF;
    # };
  };
in
pkg.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ nixpkgs.haskellPackages.cabal-install ];
    })
