{
  rustTools,
  callPackage,
  ...
}: let
  generated = rustTools.wrapRustCrate {
    name = "hello";
    src = rustTools.fixSymlinks ./. {
      "hello-lib" = ../hello-lib;
    };
  };
in
  callPackage generated {}