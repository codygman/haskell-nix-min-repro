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
        bson = pkgs.haskellPackages.callHackage "bson" "0.4.0.1" {};
        mongoDB = pkgs.haskellPackages.callHackage "mongoDB" "2.7.0.0" {};
        HTF = pkgs.haskellPackages.callHackage "HTF" "0.14.0.3" {};
      };
      source-overrides =
        {
          orville = pkgs.fetchFromGitHub {
            owner = "EdutainmentLive";
            repo = "orville";
            rev = "8a2432891e96a547777b67a67135e235a1dce80c";
            sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
          };
          HPDF = pkgs.fetchFromGitHub {
            owner = "tfausak";
            repo = "HPDF";
            rev = "31e2b887cd32661b1ac936335635be5c00216bc8";
            sha256 = "11fkiqfn6j9qnn114x4pp8rp0frrg2n8dz7gkjr0zndky44mmg32";
          };
        };
    };
in pkg
