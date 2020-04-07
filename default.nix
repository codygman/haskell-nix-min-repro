{ compilerVersion ? "ghc883" ,
  pkgs ?
  import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz")
    {}}:
let
  compiler = pkgs.haskell.packages."${compilerVersion}";
  pkg = compiler.developPackage
    { root = ./.;
      overrides = self: super: {
        bson = pkgs.haskell.lib.disableCabalFlag (
          pkgs.haskellPackages.callHackage "bson" "0.4.0.1" {}
        ) "_old-network";
        # first attempt, this obviously must be it... I'm getting it!
        network-bsd = pkgs.callHackage "network-bsd" "2.8.1.0" {};
      };
      source-overrides =
        {
          # second attempt, maybe this fixes it
          network-bsd = pkgs.callHackage "network-bsd" "2.8.1.0" {};
        };
    };
in pkg
