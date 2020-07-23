let
  myProject = import ./default.nix;

  haskellNix = import (builtins.fetchTarball "https://github.com/input-output-hk/haskell.nix/archive/ba24c3d610f885f73843de5a2fb513e44ef2b2b1.tar.gz") {};

  nixpkgsSrc = haskellNix.sources.nixpkgs-2003;
  nixpkgsArgs = haskellNix.nixpkgsArgs;
  pkgsOne = import nixpkgsSrc nixpkgsArgs;
  pkgsMusl64 = pkgsOne.pkgsCross.musl64;
  musl64 = myProject { pkgs = pkgsOne.pkgsCross.musl64; };
  postgresqlNoSystemD = haskellNix.pkgs.postgresql.override({systemd=null;});
  haskell-nix-minimal-musl64-with-flags = musl64.haskell-nix-minimal.components.exes.haskell-nix-minimal
    { configureFlags = [
      "--disable-executable-dynamic"
      "--disable-shared"
      "--ghc-option=-optl=-pthread"
      "--ghc-option=-optl=-static"
      "--ghc-option=-optl=-L${haskellNix.pkgs.gmp6.override { withStatic = true; }}/lib"
      "--ghc-option=-optl=-L${haskellNix.pkgs.zlib.static}/lib"
      "--ghc-option=-optl=-L${postgresqlNoSystemD}/lib"
      ]; };
in {
  pkgsOne = pkgsOne;
  pkgsMusl64 = pkgsMusl64;
  haskellNix = haskellNix;
  haskell-nix-minimal-musl64 = musl64.haskell-nix-minimal.components.exes.haskell-nix-minimal;
}
