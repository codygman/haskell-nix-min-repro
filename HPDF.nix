let
  buildDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (build dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  sysDepError = pkg:
    builtins.throw ''
      The Nixpkgs package set does not contain the package: ${pkg} (system dependency).
      
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      '';
  pkgConfDepError = pkg:
    builtins.throw ''
      The pkg-conf packages does not contain the package: ${pkg} (pkg-conf dependency).
      
      You may need to augment the pkg-conf package mapping in haskell.nix so that it can be found.
      '';
  exeDepError = pkg:
    builtins.throw ''
      The local executable components do not include the component: ${pkg} (executable dependency).
      '';
  legacyExeDepError = pkg:
    builtins.throw ''
      The Haskell package set does not contain the package: ${pkg} (executable dependency).
      
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
  buildToolDepError = pkg:
    builtins.throw ''
      Neither the Haskell package set or the Nixpkgs package set contain the package: ${pkg} (build tool dependency).
      
      If this is a system dependency:
      You may need to augment the system package mapping in haskell.nix so that it can be found.
      
      If this is a Haskell dependency:
      If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.
      '';
in { system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
  {
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "HPDF"; version = "1.5.0"; };
      license = "BSD-3-Clause";
      copyright = "Copyright (c) 2007-2016, alpheccar.org";
      maintainer = "misc@NOSPAMalpheccar.org";
      author = "";
      homepage = "http://www.alpheccar.org";
      url = "";
      synopsis = "Generation of PDF documents";
      description = "A PDF library with support for several pages, page transitions, outlines, annotations, compression, colors, shapes, patterns, jpegs, fonts, typesetting ... Have a look at the \"Graphics.PDF.Documentation\" module to see how to use it. Or, download the package and look at the test.hs file in the Test folder. That file is giving an example of each feature.";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."random" or (buildDepError "random"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."array" or (buildDepError "array"))
          (hsPkgs."zlib" or (buildDepError "zlib"))
          (hsPkgs."binary" or (buildDepError "binary"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."vector" or (buildDepError "vector"))
          (hsPkgs."errors" or (buildDepError "errors"))
          (hsPkgs."base64-bytestring" or (buildDepError "base64-bytestring"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."network-uri" or (buildDepError "network-uri"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          ];
        buildable = true;
        };
      exes = {
        "HPDF-Demo" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."HPDF" or (buildDepError "HPDF"))
            (hsPkgs."random" or (buildDepError "random"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."network-uri" or (buildDepError "network-uri"))
            (hsPkgs."vector" or (buildDepError "vector"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            ];
          buildable = true;
          };
        };
      tests = {
        "HPDF-Tests" = {
          depends = [
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."HTF" or (buildDepError "HTF"))
            (hsPkgs."HPDF" or (buildDepError "HPDF"))
            ];
          buildable = true;
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/tfausak/HPDF";
      rev = "31e2b887cd32661b1ac936335635be5c00216bc8";
      sha256 = "11fkiqfn6j9qnn114x4pp8rp0frrg2n8dz7gkjr0zndky44mmg32";
      });
    }