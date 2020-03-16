# haskell-nix-minimal

Run the build.sh script and get  error:

```sh
error: The Haskell package set does not contain the package: stm (build dependency)
```
Log of running build.sh:

```sh
[cody@nixos:~/haskell-nix-min-repro]$ ./build.sh 
trace: [alex-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
trace: [happy-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
trace: [hscolour-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
replacing old 'nix-tools'
installing 'nix-tools'
removed 'nt'
removed '.stack-to-nix.cache'
removed 'default.nix'
removed 'haskell-nix-minimal.nix'
removed 'HPDF.nix'
removed 'json.nix'
removed 'network-bsd.nix'
removed 'orville.nix'
removed 'pkgs.nix'
Initialized empty Git repository in /tmp/git-checkout-tmp-gy2L0iGd/json-e867c44/.git/
remote: Enumerating objects: 62, done.        
remote: Counting objects: 100% (62/62), done.        
remote: Compressing objects: 100% (32/32), done.        
remote: Total 62 (delta 1), reused 48 (delta 0), pack-reused 0        
Unpacking objects: 100% (62/62), 26.85 KiB | 6.71 MiB/s, done.
From https://github.com/quasicomputational/json
 * branch            monadfail  -> FETCH_HEAD
 * [new branch]      monadfail  -> origin/monadfail
Switched to a new branch 'fetchgit'
removing `.git'...

git revision is e867c442687f267dc1cc41a3492405b1ec5ab9e6
path is /nix/store/zyzr8qih6pzlgb216b84v20cp60lvp32-json-e867c44
git human-readable version is -- none --
Commit date is 2019-04-29 12:36:32 +0100
hash is 0ljjly500xd0ycsf0l5vqcsqy5in3c0wk5q1k5alq7nyfgzggzgh
Initialized empty Git repository in /tmp/git-checkout-tmp-0Y6wQNx0/network-bsd-9f37248/.git/
remote: Enumerating objects: 11, done.        
remote: Counting objects: 100% (11/11), done.        
remote: Compressing objects: 100% (9/9), done.        
remote: Total 11 (delta 0), reused 7 (delta 0), pack-reused 0        
Unpacking objects: 100% (11/11), 9.68 KiB | 9.68 MiB/s, done.
From https://github.com/haskell-vanguard/network-bsd
 * branch            HEAD       -> FETCH_HEAD
Switched to a new branch 'fetchgit'
removing `.git'...

git revision is 9f372485748f8b29ce6e723eb838da6f55d4157f
path is /nix/store/r9w8a0g43aixsl8mz28dvabp78zs7k68-network-bsd-9f37248
git human-readable version is -- none --
Commit date is 2019-04-26 18:23:35 +0900
hash is 0r8pg5v8wk1jv1gps77zwq1y22d9n48adccch77x1vdnwwzk712q
Initialized empty Git repository in /tmp/git-checkout-tmp-CtMTkKai/HPDF-31e2b88/.git/
remote: Enumerating objects: 87, done.        
remote: Counting objects: 100% (87/87), done.        
remote: Compressing objects: 100% (80/80), done.        
remote: Total 87 (delta 5), reused 38 (delta 5), pack-reused 0        
Unpacking objects: 100% (87/87), 363.31 KiB | 2.31 MiB/s, done.
From https://github.com/tfausak/HPDF
 * branch            ghc-eight-eight -> FETCH_HEAD
 * [new branch]      ghc-eight-eight -> origin/ghc-eight-eight
Switched to a new branch 'fetchgit'
removing `.git'...

git revision is 31e2b887cd32661b1ac936335635be5c00216bc8
path is /nix/store/ilh79ng3lzrhpafa98m4477f13fy5nha-HPDF-31e2b88
git human-readable version is -- none --
Commit date is 2019-10-31 17:28:09 -0400
hash is 11fkiqfn6j9qnn114x4pp8rp0frrg2n8dz7gkjr0zndky44mmg32
Initialized empty Git repository in /tmp/git-checkout-tmp-BQpXkTJb/orville-8a24328/.git/
remote: Enumerating objects: 56, done.        
remote: Counting objects: 100% (56/56), done.        
remote: Compressing objects: 100% (53/53), done.        
remote: Total 56 (delta 3), reused 13 (delta 0), pack-reused 0        
Unpacking objects: 100% (56/56), 39.03 KiB | 1.56 MiB/s, done.
From https://github.com/EdutainmentLIVE/orville
 * branch            HEAD       -> FETCH_HEAD
Switched to a new branch 'fetchgit'
removing `.git'...

git revision is 8a2432891e96a547777b67a67135e235a1dce80c
path is /nix/store/imv6l3jbaqdfrsvvqb690vv6xja27qnr-orville-8a24328
git human-readable version is -- none --
Commit date is 2019-10-01 15:47:19 -0400
hash is 0i8z3zr4z55bzidlh3pz3r3h0hachk5ndfhznw3kqk4c5j6y27ry
-rw-r--r-- 1 cody users  13K Mar 16 16:02 haskell-nix-minimal.nix
-rw-r--r-- 1 cody users 4.3K Mar 16 16:02 json.nix
-rw-r--r-- 1 cody users 4.8K Mar 16 16:02 network-bsd.nix
-rw-r--r-- 1 cody users 4.8K Mar 16 16:02 HPDF.nix
-rw-r--r-- 1 cody users 3.8K Mar 16 16:02 orville.nix
-rw-r--r-- 1 cody users 1.2K Mar 16 16:02 pkgs.nix
-rw-r--r-- 1 cody users  360 Mar 16 16:02 default.nix
trace: [alex-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
trace: [happy-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
trace: [hscolour-plan-to-nix-pkgs] cabal new-configure --with-ghc=ghc --with-ghc-pkg=ghc-pkg
error: The Haskell package set does not contain the package: stm (build dependency).

If you are using Stackage, make sure that you are using a snapshot that contains the package. Otherwise you may need to update the Hackage snapshot you are using, usually by updating haskell.nix.

(use '--show-trace' to show detailed location information)
```

