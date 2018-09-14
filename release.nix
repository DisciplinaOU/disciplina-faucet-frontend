{ stdenv, faucetUrl ? null, yarn, parallel, brotli }:
stdenv.mkDerivation rec {
  name = "disciplina-faucet-frontend";
  src = builtins.path { path = ./.; inherit name; filter = stdenv.lib.cleanSourceFilter; };
  FAUCET_API_URL = faucetUrl;
  HOME = ".";

  buildInputs = [ yarn parallel brotli ];
  buildPhase = ''
    yarn install
    yarn build
    find dist/ -type f \
      -not -name '*.jpg' \
      -not -name '*.png' \
      -not -name '*.webp' \
      -not -name '*.woff' \
      -not -name '*.woff2' | parallel brotli
  '';

  installPhase = ''
    mv dist $out
  '';
}
