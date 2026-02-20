{
  stdenv,
  lib,
}:
stdenv.mkDerivation {
  pname = "pyproject-nix";
  version = "0-unstable-2026-02-20";

  src = builtins.path {
    path = ../..;
    name = "pyproject-nix-source";
    filter = path: type:
      let
        rel = lib.removePrefix (toString ../..) path;
      in
      rel == "/default.nix"
      || lib.hasPrefix "/lib" rel
      || lib.hasPrefix "/build" rel;
  };

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    mkdir -p $out
    cp default.nix $out/
    cp -r lib $out/
    cp -r build $out/
  '';

  meta = {
    description = "Nix tooling for Python projects using pyproject.toml";
    homepage = "https://github.com/pyproject-nix/pyproject.nix";
    license = lib.licenses.mit;
  };
}
