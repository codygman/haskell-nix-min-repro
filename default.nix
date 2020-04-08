let
  nixpkgs-src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz";
    sha256 = "sha256:1jxsaynvj7cis3sdxbs596lxm9wyl0kf8a4519xfxzg8x45wc8cr";
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
