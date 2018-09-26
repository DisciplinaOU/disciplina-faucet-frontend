{ lib, faucetUrl ? null, buildNpmPackage }:
buildNpmPackage {
  FAUCET_API_URL = faucetUrl;
  lockfile = ./package-lock.json;
  src = builtins.path {
    name = "serokell.io-website";
    path = ./.;
    filter = name: type: lib.cleanSourceFilter name type &&
      (name != "node_modules") && name != "dist";
  };

}
