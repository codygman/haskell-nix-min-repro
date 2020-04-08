let
  nixpkgs-src = builtins.fetchTarball {
    # nixpkgs haskell-updates branch 2020-04-08
    url = "https://github.com/NixOS/nixpkgs/archive/8e87b4ad958e7ffc055af92ce91127e9e52b916a.tar.gz";
    sha256 = "sha256:1ysjx6n0g4hzpflqf16lyxjli5zfs7hqgjyvqlf2ld2cpwhik82q";
  };

  my-overlay = self: super: {
    my-haskell-packages = super.haskellPackages.override {
      overrides = hSelf: hSuper: with self.haskell.lib; {
        # my patched HPDF that doesn't require HTF
        # QUESTION: I see that I can use `super.fetchFromGitHub` or `self.fetchFromGitHub`. Does the difference matter in this context or others I should know about?
        HPDF = super.fetchFromGitHub {
          owner = "codygman";
          repo = "HPDF";
          rev = "a87f1f68ab8c6abc4de26d40a3c28b1b108effe3";
          sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
        };
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
