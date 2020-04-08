let
  nixpkgs-src = builtins.fetchTarball {
    # If you search for HPDF on Hydra (https://hydra.nixos.org/search?query=HPDF),
    # you can see that the last successful build was in 18.09: https://hydra.nixos.org/build/89581306
    # Since it is not possible to easily combine different Haskell packages
    # from different nixpkgs, we just fall back to 18.09 and get everything
    # from there.
    #
    # The following nixpkgs commit is from the build inputs of
    # https://hydra.nixos.org/build/89581306.
    #
    # 18.09 contains ghc-8.4.4 (I think?)
    #
    # If you really want to use HPDF and HTF with the latest compiler, you will
    # have to patch them.  See the Haskell stuff in nixpkgs for how to do this.
    # Grepping for "fetchPatch" should give you some good places to look.
    url = "https://github.com/NixOS/nixpkgs/archive/8c2447fdee1af9310367b1ad7b63aed6217d3445.tar.gz";
    sha256 = "sha256:1zp6gn7h8mvs8a8fl9bxwm5ah8c3vg7irfihfr3k104byhfq2xd6";
  };

  my-overlay = self: super: {
    my-haskell-packages = super.haskellPackages.override {
      overrides = hSelf: hSuper: with self.haskell.lib; {
        # !!! Because we moved to 18.09, bson is already working well, so we
        # !!! don't need to override it or anything.
        # bson = ...

        # !!! Because HPDF and HTF are already working in 18.09, we don't have
        # !!! to override them.
        # HPDF = ...
        # HTF = ...

        # HPDF =
        #   let
        #     # !!! It will never work getting some packages from a different
        #     # !!! Haskell Package set like this.  You need to make sure everything
        #     # !!! comes from the same package set.
        #     unbroken-old-HTF = self.haskell.lib.markUnbroken HTF-nixpkgs.haskellPackages.HTF;
        #     unbroken-HPDF = self.haskell.lib.markUnbroken self.haskellPackages.HPDF;
        #     unbroken-HPDF-with-old-HTF = self.haskell.lib.addBuildDepend unbroken-HPDF unbroken-old-HTF;
        #   in unbroken-HPDF-with-old-HTF;
      };
    };
  };

  nixpkgs = import nixpkgs-src {
    overlays = [ my-overlay ];
  };

  pkg = nixpkgs.my-haskell-packages.developPackage {
    root = ./.;
    # You need the name here to be the same as the package name.
    # Normally this gets figured out from the directory name, but
    # in this case, the directory name does not match the package
    # name, so we have to have this.
    name = "haskell-nix-minimal";
  };
in
pkg.overrideAttrs (attrs: {
        buildInputs = attrs.buildInputs ++ [ nixpkgs.haskellPackages.cabal-install ];
    })
