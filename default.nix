{ nixpkgs ? import ./nix/nixos-unstable-2020-03-28.nix }:
let
 orville =  pkgs.fetchFromGitHub {
   owner = "EdutainmentLive";
   repo = "orville";
   rev = "8a2432891e96a547777b67a67135e235a1dce80c";
   sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
 };
 convertible =  pkgs.fetchFromGitHub {
   owner = "tfausak";
   repo = "convertible";
   rev = "9e4849e143458aa3175e71bc2a8a29502272eb88";
   sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
 };
 HPDF =  pkgs.fetchFromGitHub {
   owner = "tfausak";
   repo = "HPDF";
   rev = "31e2b887cd32661b1ac936335635be5c00216bc8";
   sha256 = "11fkiqfn6j9qnn114x4pp8rp0frrg2n8dz7gkjr0zndky44mmg32";
 };
 network-bsd =  pkgs.fetchFromGitHub {
   owner = "haskell";
   repo = "network-bsd";
   rev = "2167eca412fa488f7b2622fcd61af1238153dae7";
   sha256 = "06c58dhw19wq2pr6h53qpii2nsghasnhq0c7s5yhcxsjid16aa0a";
 };
 happstack-server = pkgs.haskellPackages.callHackage "happstack-server" "7.6.0" {};
 json = pkgs.haskellPackages.callHackage "json" "0.10" {};
 overlay = self: super: {
    myHaskellPackages =
      super.haskell.packages.ghc883.override (old: {
        overrides = self.lib.composeExtensions (old.overrides or (_: _: {}))
          (hself: hsuper: {
            ghc = hsuper.ghc // { withPackages = hsuper.ghc.withHoogle; };
            ghcWithPackages = hself.ghc.withPackages;
            # TODO callHpack2nix helper shouldn't be necessar with newer callCabal2nix
            happstack-server = happstack-server;
            HDBC = pkgs.haskellPackages.callHackage "HDBC" "2.4.0.3" {};
            HDBC-postgresql = pkgs.haskellPackages.callHackage "HDBC-postgresql" "2.3.2.7" {};
            json = json;
            orville = orville;
            HPDF = HPDF;
            convertible = convertible;
            # TODO why is it necessary to define own bson.nix here? Why isn't disableCabalFlag sufficient?
            # bson = pkgs.haskell.lib.disableCabalFlag (pkgs.haskellPackages.callHackage "bson" "0.4.0.1" {}) "_old-network";
            bson = pkgs.haskellPackages.callPackage ./nix/bson.nix {};
          });
      });
  };
  pkgs = import nixpkgs {
    overlays = [overlay];
  };
  drv = pkgs.myHaskellPackages.callCabal2nix "haskell-nix-minimal" ./. {};
in
{
  haskell-nix-minimal = drv;
  haskell-nix-minimal-shell = pkgs.myHaskellPackages.shellFor {
    packages = p: [drv];
    buildInputs = with pkgs; [ cabal-install hlint ghcid];
  };
}
