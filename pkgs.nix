{
  extras = hackage:
    {
      packages = {
        "happstack-server" = (((hackage.happstack-server)."7.6.0").revisions).default;
        "HDBC" = (((hackage.HDBC)."2.4.0.3").revisions).default;
        "HDBC-postgresql" = (((hackage.HDBC-postgresql)."2.3.2.7").revisions).default;
        "hedis" = (((hackage.hedis)."0.12.9").revisions).default;
        "hslogger" = (((hackage.hslogger)."1.3.1.0").revisions).default;
        "HTTP" = (((hackage.HTTP)."4000.3.14").revisions).default;
        "mongoDB" = (((hackage.mongoDB)."2.6.0.0").revisions).default;
        "xml-lens" = (((hackage.xml-lens)."0.2").revisions).default;
        haskell-nix-minimal = ./haskell-nix-minimal.nix;
        json = ./json.nix;
        network-bsd = ./network-bsd.nix;
        HPDF = ./HPDF.nix;
        orville = ./orville.nix;
        };
      };
  resolver = "lts-15.3";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "mongoDB" = {
            flags = { "_old-network" = lib.mkOverride 900 false; };
            };
          "bson" = { flags = { "_old-network" = lib.mkOverride 900 false; }; };
          };
        })
    { packages = {}; }
    ];
  }