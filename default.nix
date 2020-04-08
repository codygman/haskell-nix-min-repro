let
  nixpkgs-src = builtins.fetchTarball {
    # nixpkgs haskell-updates branch 2020-04-08
    url = "https://github.com/NixOS/nixpkgs/archive/8e87b4ad958e7ffc055af92ce91127e9e52b916a.tar.gz";
    sha256 = "sha256:1ysjx6n0g4hzpflqf16lyxjli5zfs7hqgjyvqlf2ld2cpwhik82q";
  };

  my-overlay = self: super: {
    my-haskell-packages = super.haskellPackages.override {
      overrides = hSelf: hSuper: with self.haskell.lib; {
        # this is my patched HPDF that doesn't require HTF (I did this instead of figuring out fetchPatch)
        # QUESTION: I see that I can use `super.fetchFromGitHub` or `self.fetchFromGitHub`. Does the difference matter in this context or others I should know about?
        # NOTE this doesn't provide HPDF for some reason???
        # error:
        # defaultMain, called at Setup.hs:2:8 in main:Main
        # Setup: Encountered missing or private dependencies:
        # HPDF -any
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

# full nix-build --show-trace output:
# -*- mode: compilation; default-directory: "~/haskell-nix-minimal/" -*-
# Compilation started at Wed Apr  8 09:44:14

# nix-build --show-trace
# these derivations will be built:
#   /nix/store/jjlw98fmf0fzrnphbbkkx4n8k5rdkyvk-haskell-nix-minimal-0.0.0.drv
# building '/nix/store/jjlw98fmf0fzrnphbbkkx4n8k5rdkyvk-haskell-nix-minimal-0.0.0.drv'...
# setupCompilerEnvironmentPhase
# Build with /nix/store/dhnspmn5hc312lm46a98w4n1bz27bp40-ghc-8.8.3.
# unpacking sources
# unpacking source archive /nix/store/57jbqnwddwcxigr1v1aa4lk8fc4z5dpa-haskell-nix-minimal
# source root is haskell-nix-minimal
# patching sources
# compileBuildDriverPhase
# setupCompileFlags: -package-db=/build/setup-package.conf.d -j4 -threaded
# [1 of 1] Compiling Main             ( Setup.hs, /build/Main.o )
# Linking Setup ...
# configuring
# configureFlags: --verbose --prefix=/nix/store/pfh6y8rylmzsalvnm01c9rqjqjzddspw-haskell-nix-minimal-0.0.0 --libdir=$prefix/lib/$compiler --libsubdir=$abi/$libname --docdir=/nix/store/q9nqm2yjfl7djfibz1icbqriq5lc2k40-haskell-nix-minimal-0.0.0-doc/share/doc/haskell-nix-minimal-0.0.0 --with-gcc=gcc --package-db=/build/package.conf.d --ghc-option=-j4 --disable-split-objs --enable-library-profiling --profiling-detail=exported-functions --disable-profiling --enable-shared --disable-coverage --enable-static --disable-executable-dynamic --enable-tests --disable-benchmarks --enable-library-vanilla --disable-library-for-ghci --ghc-option=-split-sections --extra-lib-dirs=/nix/store/49x12wk4l8c0lh97crvwhjbzfxrq1fa2-ncurses-6.2/lib --extra-lib-dirs=/nix/store/hfs34n1yww7ba1m8gbrwrwh6v1y269m6-libffi-3.3/lib --extra-lib-dirs=/nix/store/l9nfr0znv7qibrapym32qj7dxmynfh84-gmp-6.2.0/lib
# Using Parsec parser
# Configuring haskell-nix-minimal-0.0.0...
# CallStack (from HasCallStack):
#   die', called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:1022:20 in Cabal-3.0.1.0:Distribution.Simple.Configure
#   configureFinalizedPackage, called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:475:12 in Cabal-3.0.1.0:Distribution.Simple.Configure
#   configure, called at libraries/Cabal/Cabal/Distribution/Simple.hs:625:20 in Cabal-3.0.1.0:Distribution.Simple
#   confHook, called at libraries/Cabal/Cabal/Distribution/Simple/UserHooks.hs:65:5 in Cabal-3.0.1.0:Distribution.Simple.UserHooks
#   configureAction, called at libraries/Cabal/Cabal/Distribution/Simple.hs:180:19 in Cabal-3.0.1.0:Distribution.Simple
#   defaultMainHelper, called at libraries/Cabal/Cabal/Distribution/Simple.hs:116:27 in Cabal-3.0.1.0:Distribution.Simple
#   defaultMain, called at Setup.hs:2:8 in main:Main
# Setup: Encountered missing or private dependencies:
# HPDF -any

# builder for '/nix/store/jjlw98fmf0fzrnphbbkkx4n8k5rdkyvk-haskell-nix-minimal-0.0.0.drv' failed with exit code 1
# error: build of '/nix/store/jjlw98fmf0fzrnphbbkkx4n8k5rdkyvk-haskell-nix-minimal-0.0.0.drv' failed

# Compilation exited abnormally with code 100 at Wed Apr  8 09:44:18
