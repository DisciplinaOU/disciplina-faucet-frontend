{ lib, faucetUrl ? null, buildYarnPackage, parallel, brotli, fetchurl }:

buildYarnPackage {
  FAUCET_API_URL = faucetUrl;
  SASS_BINARY_PATH = fetchurl {
    url = https://github.com/sass/node-sass/releases/download/v4.9.3/linux-x64-64_binding.node;
    sha256 = "0i2968by6qir59s7fls5sps13b5cpy66mdr1sp9dgqiddjp20x0n";
  };

  buildInputs = [ parallel brotli ];

  postBuild = ''
    find dist/ -type f \
      -not -name '*.jpg' \
      -not -name '*.png' \
      -not -name '*.webp' \
      -not -name '*.woff' \
      -not -name '*.woff2' | parallel brotli
  '';

  preInstallPhases = [];

  installPhase = ''
    mv dist $out
  '';

  src = builtins.path {
    name = "disciplina-faucet-frontend";
    path = ./.;
    filter = name: type: lib.cleanSourceFilter name type &&
      (name != "node_modules") && name != "dist";
  };
}
