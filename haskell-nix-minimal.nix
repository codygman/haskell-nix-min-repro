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
  ({
    flags = {};
    package = {
      specVersion = "0";
      identifier = { name = "haskell-nix-minimal"; version = "22"; };
      license = "BSD-3-Clause";
      copyright = "";
      maintainer = "";
      author = "";
      homepage = "";
      url = "";
      synopsis = "";
      description = "";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."HDBC" or (buildDepError "HDBC"))
          (hsPkgs."HDBC-postgresql" or (buildDepError "HDBC-postgresql"))
          (hsPkgs."HPDF" or (buildDepError "HPDF"))
          (hsPkgs."JuicyPixels" or (buildDepError "JuicyPixels"))
          (hsPkgs."JuicyPixels-extra" or (buildDepError "JuicyPixels-extra"))
          (hsPkgs."aeson" or (buildDepError "aeson"))
          (hsPkgs."aeson-qq" or (buildDepError "aeson-qq"))
          (hsPkgs."amazonka" or (buildDepError "amazonka"))
          (hsPkgs."amazonka-cloudwatch" or (buildDepError "amazonka-cloudwatch"))
          (hsPkgs."amazonka-cloudwatch-events" or (buildDepError "amazonka-cloudwatch-events"))
          (hsPkgs."amazonka-core" or (buildDepError "amazonka-core"))
          (hsPkgs."amazonka-s3" or (buildDepError "amazonka-s3"))
          (hsPkgs."amazonka-sns" or (buildDepError "amazonka-sns"))
          (hsPkgs."amazonka-sqs" or (buildDepError "amazonka-sqs"))
          (hsPkgs."amazonka-sts" or (buildDepError "amazonka-sts"))
          (hsPkgs."async" or (buildDepError "async"))
          (hsPkgs."base" or (buildDepError "base"))
          (hsPkgs."base64-bytestring" or (buildDepError "base64-bytestring"))
          (hsPkgs."bcrypt" or (buildDepError "bcrypt"))
          (hsPkgs."bson" or (buildDepError "bson"))
          (hsPkgs."bytestring" or (buildDepError "bytestring"))
          (hsPkgs."case-insensitive" or (buildDepError "case-insensitive"))
          (hsPkgs."cassava" or (buildDepError "cassava"))
          (hsPkgs."clock" or (buildDepError "clock"))
          (hsPkgs."conduit" or (buildDepError "conduit"))
          (hsPkgs."conduit-combinators" or (buildDepError "conduit-combinators"))
          (hsPkgs."containers" or (buildDepError "containers"))
          (hsPkgs."convertible" or (buildDepError "convertible"))
          (hsPkgs."cryptonite" or (buildDepError "cryptonite"))
          (hsPkgs."csv-conduit" or (buildDepError "csv-conduit"))
          (hsPkgs."deepseq" or (buildDepError "deepseq"))
          (hsPkgs."directory" or (buildDepError "directory"))
          (hsPkgs."dlist" or (buildDepError "dlist"))
          (hsPkgs."either" or (buildDepError "either"))
          (hsPkgs."email-validate" or (buildDepError "email-validate"))
          (hsPkgs."envy" or (buildDepError "envy"))
          (hsPkgs."exceptions" or (buildDepError "exceptions"))
          (hsPkgs."extra" or (buildDepError "extra"))
          (hsPkgs."filepath" or (buildDepError "filepath"))
          (hsPkgs."happstack-server" or (buildDepError "happstack-server"))
          (hsPkgs."hashable" or (buildDepError "hashable"))
          (hsPkgs."hedis" or (buildDepError "hedis"))
          (hsPkgs."hslogger" or (buildDepError "hslogger"))
          (hsPkgs."http-client" or (buildDepError "http-client"))
          (hsPkgs."http-client-tls" or (buildDepError "http-client-tls"))
          (hsPkgs."http-conduit" or (buildDepError "http-conduit"))
          (hsPkgs."http-types" or (buildDepError "http-types"))
          (hsPkgs."jwt" or (buildDepError "jwt"))
          (hsPkgs."lens" or (buildDepError "lens"))
          (hsPkgs."memory" or (buildDepError "memory"))
          (hsPkgs."monad-control" or (buildDepError "monad-control"))
          (hsPkgs."mongoDB" or (buildDepError "mongoDB"))
          (hsPkgs."mono-traversable" or (buildDepError "mono-traversable"))
          (hsPkgs."mtl" or (buildDepError "mtl"))
          (hsPkgs."network" or (buildDepError "network"))
          (hsPkgs."network-uri" or (buildDepError "network-uri"))
          (hsPkgs."orville" or (buildDepError "orville"))
          (hsPkgs."parsec" or (buildDepError "parsec"))
          (hsPkgs."random" or (buildDepError "random"))
          (hsPkgs."resource-pool" or (buildDepError "resource-pool"))
          (hsPkgs."resourcet" or (buildDepError "resourcet"))
          (hsPkgs."scientific" or (buildDepError "scientific"))
          (hsPkgs."split" or (buildDepError "split"))
          (hsPkgs."stm" or (buildDepError "stm"))
          (hsPkgs."template-haskell" or (buildDepError "template-haskell"))
          (hsPkgs."text" or (buildDepError "text"))
          (hsPkgs."time" or (buildDepError "time"))
          (hsPkgs."transformers" or (buildDepError "transformers"))
          (hsPkgs."transformers-base" or (buildDepError "transformers-base"))
          (hsPkgs."unliftio-core" or (buildDepError "unliftio-core"))
          (hsPkgs."unordered-containers" or (buildDepError "unordered-containers"))
          (hsPkgs."uuid" or (buildDepError "uuid"))
          (hsPkgs."vector" or (buildDepError "vector"))
          (hsPkgs."xml-conduit" or (buildDepError "xml-conduit"))
          (hsPkgs."xml-conduit-writer" or (buildDepError "xml-conduit-writer"))
          (hsPkgs."xml-lens" or (buildDepError "xml-lens"))
          (hsPkgs."xml-types" or (buildDepError "xml-types"))
          ];
        buildable = true;
        };
      exes = {
        "haskell-nix-minimal" = {
          depends = [
            (hsPkgs."HDBC" or (buildDepError "HDBC"))
            (hsPkgs."HDBC-postgresql" or (buildDepError "HDBC-postgresql"))
            (hsPkgs."HPDF" or (buildDepError "HPDF"))
            (hsPkgs."JuicyPixels" or (buildDepError "JuicyPixels"))
            (hsPkgs."JuicyPixels-extra" or (buildDepError "JuicyPixels-extra"))
            (hsPkgs."aeson" or (buildDepError "aeson"))
            (hsPkgs."aeson-qq" or (buildDepError "aeson-qq"))
            (hsPkgs."amazonka" or (buildDepError "amazonka"))
            (hsPkgs."amazonka-cloudwatch" or (buildDepError "amazonka-cloudwatch"))
            (hsPkgs."amazonka-cloudwatch-events" or (buildDepError "amazonka-cloudwatch-events"))
            (hsPkgs."amazonka-core" or (buildDepError "amazonka-core"))
            (hsPkgs."amazonka-s3" or (buildDepError "amazonka-s3"))
            (hsPkgs."amazonka-sns" or (buildDepError "amazonka-sns"))
            (hsPkgs."amazonka-sqs" or (buildDepError "amazonka-sqs"))
            (hsPkgs."amazonka-sts" or (buildDepError "amazonka-sts"))
            (hsPkgs."async" or (buildDepError "async"))
            (hsPkgs."base" or (buildDepError "base"))
            (hsPkgs."base64-bytestring" or (buildDepError "base64-bytestring"))
            (hsPkgs."bcrypt" or (buildDepError "bcrypt"))
            (hsPkgs."bson" or (buildDepError "bson"))
            (hsPkgs."bytestring" or (buildDepError "bytestring"))
            (hsPkgs."case-insensitive" or (buildDepError "case-insensitive"))
            (hsPkgs."cassava" or (buildDepError "cassava"))
            (hsPkgs."clock" or (buildDepError "clock"))
            (hsPkgs."conduit" or (buildDepError "conduit"))
            (hsPkgs."conduit-combinators" or (buildDepError "conduit-combinators"))
            (hsPkgs."containers" or (buildDepError "containers"))
            (hsPkgs."convertible" or (buildDepError "convertible"))
            (hsPkgs."cryptonite" or (buildDepError "cryptonite"))
            (hsPkgs."csv-conduit" or (buildDepError "csv-conduit"))
            (hsPkgs."deepseq" or (buildDepError "deepseq"))
            (hsPkgs."directory" or (buildDepError "directory"))
            (hsPkgs."dlist" or (buildDepError "dlist"))
            (hsPkgs."either" or (buildDepError "either"))
            (hsPkgs."email-validate" or (buildDepError "email-validate"))
            (hsPkgs."envy" or (buildDepError "envy"))
            (hsPkgs."exceptions" or (buildDepError "exceptions"))
            (hsPkgs."extra" or (buildDepError "extra"))
            (hsPkgs."filepath" or (buildDepError "filepath"))
            (hsPkgs."happstack-server" or (buildDepError "happstack-server"))
            (hsPkgs."hashable" or (buildDepError "hashable"))
            (hsPkgs."haskell-nix-minimal" or (buildDepError "haskell-nix-minimal"))
            (hsPkgs."hedis" or (buildDepError "hedis"))
            (hsPkgs."hslogger" or (buildDepError "hslogger"))
            (hsPkgs."http-client" or (buildDepError "http-client"))
            (hsPkgs."http-client-tls" or (buildDepError "http-client-tls"))
            (hsPkgs."http-conduit" or (buildDepError "http-conduit"))
            (hsPkgs."http-types" or (buildDepError "http-types"))
            (hsPkgs."jwt" or (buildDepError "jwt"))
            (hsPkgs."lens" or (buildDepError "lens"))
            (hsPkgs."memory" or (buildDepError "memory"))
            (hsPkgs."monad-control" or (buildDepError "monad-control"))
            (hsPkgs."mongoDB" or (buildDepError "mongoDB"))
            (hsPkgs."mono-traversable" or (buildDepError "mono-traversable"))
            (hsPkgs."mtl" or (buildDepError "mtl"))
            (hsPkgs."network" or (buildDepError "network"))
            (hsPkgs."network-uri" or (buildDepError "network-uri"))
            (hsPkgs."orville" or (buildDepError "orville"))
            (hsPkgs."parsec" or (buildDepError "parsec"))
            (hsPkgs."random" or (buildDepError "random"))
            (hsPkgs."resource-pool" or (buildDepError "resource-pool"))
            (hsPkgs."resourcet" or (buildDepError "resourcet"))
            (hsPkgs."scientific" or (buildDepError "scientific"))
            (hsPkgs."split" or (buildDepError "split"))
            (hsPkgs."stm" or (buildDepError "stm"))
            (hsPkgs."template-haskell" or (buildDepError "template-haskell"))
            (hsPkgs."text" or (buildDepError "text"))
            (hsPkgs."time" or (buildDepError "time"))
            (hsPkgs."transformers" or (buildDepError "transformers"))
            (hsPkgs."transformers-base" or (buildDepError "transformers-base"))
            (hsPkgs."unliftio-core" or (buildDepError "unliftio-core"))
            (hsPkgs."unordered-containers" or (buildDepError "unordered-containers"))
            (hsPkgs."uuid" or (buildDepError "uuid"))
            (hsPkgs."vector" or (buildDepError "vector"))
            (hsPkgs."xml-conduit" or (buildDepError "xml-conduit"))
            (hsPkgs."xml-conduit-writer" or (buildDepError "xml-conduit-writer"))
            (hsPkgs."xml-lens" or (buildDepError "xml-lens"))
            (hsPkgs."xml-types" or (buildDepError "xml-types"))
            ];
          buildable = true;
          };
        };
      };
    } // rec { src = (pkgs.lib).mkDefault ./.; }) // {
    cabal-generator = "hpack";
    }