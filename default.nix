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
        network-bsd = pkgs.callHackage "network-bsd" "2.8.1.0" {};
        bson = pkgs.haskell.lib.disableCabalFlag (
          pkgs.haskellPackages.callHackage "bson" "0.4.0.1" {}
        ) "_old-network";
      };
      source-overrides = {
        network-bsd = pkgs.callHackage "network-bsd" "2.8.1.0" {};
      };
    };
in pkg
