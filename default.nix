{ faucetUrl ? null }:
let
  pkgs = import ./nixpkgs.nix;

in pkgs.callPackage ./release.nix {
  inherit faucetUrl;
}
