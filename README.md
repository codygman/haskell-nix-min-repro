# haskell-nix-minimal

Running nix build I get:

``` sh
$ nix build
builder for '/nix/store/fqjfckxgnd8fi4h8y44hys9klq7nipx7-haskell-nix-minimal-22.drv' failed with exit code 1; last 10 log lines:
    die', called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:1022:20 in Cabal-3.0.1.0:Distribution.Simple.Configure
    configureFinalizedPackage, called at libraries/Cabal/Cabal/Distribution/Simple/Configure.hs:475:12 in Cabal-3.0.1.0:Distribution.Simple.Configure
    configure, called at libraries/Cabal/Cabal/Distribution/Simple.hs:625:20 in Cabal-3.0.1.0:Distribution.Simple
    confHook, called at libraries/Cabal/Cabal/Distribution/Simple/UserHooks.hs:65:5 in Cabal-3.0.1.0:Distribution.Simple.UserHooks
    configureAction, called at libraries/Cabal/Cabal/Distribution/Simple.hs:180:19 in Cabal-3.0.1.0:Distribution.Simple
    defaultMainHelper, called at libraries/Cabal/Cabal/Distribution/Simple.hs:116:27 in Cabal-3.0.1.0:Distribution.Simple
    defaultMain, called at Setup.hs:2:8 in main:Main
  Setup: Encountered missing or private dependencies:
  HPDF -any, orville -any
error: build of '/nix/store/5kciwd9yy27q61708ych03bkr6fgw7k5-ghc-shell-for-haskell-nix-minimal-22-0.drv', '/nix/store/fqjfckxgnd8fi4h8y44hys9klq7nipx7-haskell-nix-minimal-22.drv' failed

```

I'm guessing it's something wrong with how I define overlays in default.nix:51.
