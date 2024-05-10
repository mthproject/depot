{
  rustToolchain,
  rustTools,
  system,
  callPackage,
  ...
}: let
  generated = rustTools.crate2nix.tools.${system}.generatedCargoNix {
    name = "hello";
    src = rustTools.fixSymlinks ./. {
      "hello-lib" = ../hello-lib;
    };
  };
in
  callPackage generated {
    # rustc = rustToolchain;
    # cargo = rustToolchain;
    # rust-toolchain = rustToolchain;
  }
