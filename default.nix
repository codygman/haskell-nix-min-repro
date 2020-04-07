let
  # This is the source of nixpkgs we will use.
  #
  # Generally you want a comment on the URL about where this nixpkgs came from.
  # Is it `master`?  Is it one of the release branches?  What is the
  # approximate date it came from?
  #
  # It is possible to figure out these things using `git`, but in general it is
  # nice if you leave a comment for the future reader.
  nixpkgs-src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/3567e1f6cc204f3b999431ce9e182a86e115976f.tar.gz";
    # When you use fetchTarball, if at all possible, you always want to specify
    # a sha256.  This makes sure the tarball will be stored in the /nix/store,
    # so you don't have to frequently re-download it.
    sha256 = "sha256:1jxsaynvj7cis3sdxbs596lxm9wyl0kf8a4519xfxzg8x45wc8cr";
  };

  # This is a full nixpkgs overlay.
  #
  # We only define one new package, the Haskell package set with our overridden
  # packages.
  my-overlay = self: super: {
    # This is a new Haskell package set.  It is built on the `haskellPackages`
    # package set from nixpkgs, but we overrode `bson` and `network-bsd`.
    #
    # The reason for creating a new package set instead of just re-using
    # `haskellPackages` is to make it simpler to get unmodified programs from
    # the normal `haskellPackages`. See
    # https://discourse.nixos.org/t/nix-haskell-development-2020/6170/2?u=cdepillabout
    # for more information.
    #
    # Note that you should make sure to use `haskellPackages.override` here
    # instead of `haskellPackages.extend`, although I don't really understand
    # why this is the case.  I only knew this because I normally see
    # `haskellPackages.override` instead of `haskellPackages.extend`.
    my-haskell-packages = super.haskellPackages.override {
      # These are the actual overrides for the Haskell package set.
      #
      # This is where we override `bson` and `network-bsd`.
      overrides = hSelf: hSuper: {
        bson =
          let
            # I'm not sure why this is needed, but I just followed your example
            # in the first post.  I just overrode hSuper.bson instead of
            # getting it from hackage with callHackage.
            bson-with-disabled-flag =
              self.haskell.lib.disableCabalFlag hSuper.bson "_old-network";

            # It looks like bson is marked broken, so we can unbreak it.
            #
            # I did this instead of getting it from Hackage with callHackage,
            # but it doesn't really matter here.
            bson-unbroken = self.haskell.lib.markUnbroken bson-with-disabled-flag;

            # Disabling the `_old-network` flag in bson appears to add
            # network-bsd as a dependency, so we have to go ahead and add that
            # here ourselves.
            bson-with-build-depend =
              self.haskell.lib.addBuildDepend bson-unbroken hSelf.network-bsd;
          in
          bson-with-build-depend;

        # bson apparently needs an old version of `network-bsd`.
        network-bsd = hSelf.callHackage "network-bsd" "2.8.1.0" {};
      };
    };
  };

  # Apply our overlays to nixpkgs.
  nixpkgs = import nixpkgs-src { overlays = [ my-overlay ]; };

  # This is our local package.
  #
  # I created a new Haskell package set, and set `bson` and `network-bsd`
  # overrides on it, instead of using the arguments to `developPackage`, but
  # you could probably do either.
  #
  # Personally I think it is easier doing it the way it is in this file, but
  # either are probably valid.
  #
  # In your original file, I'm not sure why you had to have both `overrides`
  # and `source-overrides`.
  pkg = nixpkgs.my-haskell-packages.developPackage { root = ./.; };
in
pkg
