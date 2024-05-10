{
  rustToolchain,
  rustTools,
  system,
  callPackage,
  runCommand,
  ...
}: let
  patch = x: {};
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
    buildRustCrateForPkgs = pkgs:
      pkgs.buildRustCrate.override {
        defaultCrateOverrides =
          pkgs.defaultCrateOverrides
          // {
            # "hello-lib" = attrs: {
            #   src = ../pkgs/hello-lib;
            # };
          };
      };
  }
