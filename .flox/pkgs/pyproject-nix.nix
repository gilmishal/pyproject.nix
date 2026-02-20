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
    mkdir -p $out/pyproject-nix
    cp default.nix $out/pyproject-nix/
    cp -r lib $out/pyproject-nix/
    cp -r build $out/pyproject-nix/
  '';

  meta = {
    description = "Nix tooling for Python projects using pyproject.toml";
    homepage = "https://github.com/pyproject-nix/pyproject.nix";
    license = lib.licenses.mit;
  };
}
