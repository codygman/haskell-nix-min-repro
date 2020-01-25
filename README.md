# haskell-nix-minimal

1. Install stack-to-nix

```
nix build '(with import <nixpkgs> (import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/master.tar.gz)); haskell-nix.nix-tools)' --out-link nt && nix-env -i ./nt
```

2. From within this project directory, run `stack-to-nix` to generate `default.nix`, `haskell-nix-minimal.nix`, and `pkgs.nix`:
```
stack-to-nix --output . --stack-yaml stack.yaml
```

3. Build? (nope, currently an error on OSX catalina at least):
```
▶ nix build -f default.nix haskell-nix-minimal.components.exes.all       
error: attribute 'ghc881' missing, at /nix/store/90mhsigh01jwgbylrb80qv8y9ai07ryn-source/overlays/haskell.nix:116:36
(use '--show-trace' to show detailed location information)
```
