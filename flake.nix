{
  inputs = {
    nixpkgs.url = "path:./nixpkgs";

    # Rust
    rust-overlay.url = "github:oxalica/rust-overlay";
    crate2nix.url = "github:nix-community/crate2nix";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    rust-overlay,
    ...
  }: let
    lib = nixpkgs.lib;

    systems = ["x86_64-linux" "aarch64-linux"];

    platformsBuiltBy = system: import ./platforms {builderSystem = system;} inputs;

    getDevPkgsFor = system: let
      platforms = platformsBuiltBy system;
      pkgs = platforms.dev._module.args.pkgs; # a bit hacky imo, but it removes duplication of nixpkgs initialization code.
    in
      pkgs;
  in {
    legacyPackages = lib.genAttrs systems (system: platformsBuiltBy system);

    devShells = lib.genAttrs systems (system: let
      pkgs = (getDevPkgsFor system).pkgsBuildBuild;
    in {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.mth.rustToolchain
          pkgs.just
          pkgs.nix-output-monitor
          pkgs.cargo-fuzz
          pkgs.aflplusplus
        ];
      };
    });
  };
}
