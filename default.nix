{ compiler ? "ghc883" ,
  pkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz") {}}:
let
  pinnedHaskell = pkgs.haskell.packages.${compiler};
  haskell-nix-minimal = pinnedHaskell.developPackage
    { root = ./.;
      overrides = with pkgs.haskell.lib; self: super: {
        bson = dontCheck (addBuildDepend (markUnbroken super.bson) self.network-bsd);
        mongoDB = dontCheck (markUnbroken (self.callHackage "mongoDB" "2.7.0.0" {}));
      };
      source-overrides =
        {
          orville = pkgs.fetchFromGitHub {
            owner = "EdutainmentLive";
            repo = "orville";
            rev = "8a2432891e96a547777b67a67135e235a1dce80c";
            sha256 = "0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry";
          };
        };
      # This to run when I call nix-shell
      # My project only has a package.yaml and no cabal file
      # I need to use cabal v2-repl though so I need to generate it each
      # time I do:
      # nix-shell --pure --run "cabal v2-repl"
      # I think preConfigure hook is correct but this doesn't work
      modifier = drv:
        with pkgs.haskellPackages;
        pkgs.haskell.lib.overrideCabal drv (attrs: {
          buildTools = [ hlint cabal-install hpack ];
          # NOTE This doesn't work, I'd like it to generate the cabal file required by cabal-v2 repl
          # preConfigure = ''
          # ${pinnedHaskell.hpack}/bin/hpack
          # '';
        });
    };
in haskell-nix-minimal

  # NOTE: this example generates an hpack file on demand like I might need
  # https://github.com/luc-tielen/typesystem/blob/3b61395b40630c300ffd499efa71166f450579a5/default.nix#L27
  # snippets from above link:
  # hpack2cabal = name: src: pkgs.runCommand "hpack2cabal-${name}" {} ''
  #   ${hpack}/bin/hpack '${src}' - > "$out"
  # '';
  # source = nix-gitignore.gitignoreSource [] ./.;
  # processedSource = hpack2cabal "typesystem" source;
