{ lib, faucetUrl ? null, buildNpmPackage, fetchurl }:
buildNpmPackage {
  FAUCET_API_URL = faucetUrl;
  SASS_BINARY_PATH = fetchurl {
    url = https://github.com/sass/node-sass/releases/download/v4.9.3/linux-x64-64_binding.node;
    sha256 = "0i2968by6qir59s7fls5sps13b5cpy66mdr1sp9dgqiddjp20x0n";
  };
  lockfile = ./package-lock.json;
  src = builtins.path {
    name = "serokell.io-website";
    path = ./.;
    filter = name: type: lib.cleanSourceFilter name type &&
      (name != "node_modules") && name != "dist";
  };
}
