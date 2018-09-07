{ faucetUrl ? null }:
let
  pkgs = import (fetchTarball "https://github.com/serokell/nixpkgs/archive/master.tar.gz") {
    config.allowUnfree = true;
    overlays = [ (import "${fetchGit "ssh://git@github.com:/serokell/serokell-overlay"}/pkgs") ];
  };

in pkgs.callPackage ./release.nix {
  inherit faucetUrl;
}
