{ lib, stdenv }:

stdenv.mkDerivation {
  name = "wez-logging";

  src = ./.;

  dontBuild = true;

  installPhase = ''
    cp -r plugin $out;
  '';
}
