#!/usr/bin/env bash

nix build '(with import <nixpkgs> (import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/master.tar.gz)); haskell-nix.nix-tools)' --out-link nt
nix-env -i ./nt
rm -v nt
stack-to-nix --output . --stack-yaml stack.yaml
ls -larth *.nix
nix build -f . haskell-nix-minimal.components.all
