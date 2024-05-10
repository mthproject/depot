{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    rust-overlay,
  }: let
    lib = nixpkgs.lib;
  in {
    platforms = import ./platforms inputs;

    devShells = {
      x86_64-linux = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [(import rust-overlay)];
        };
        rust = pkgs.rust-bin.nightly.latest.default.override {
          extensions = ["rust-src"];
          targets = ["x86_64-unknown-uefi"];
        };
      in {
        default = pkgs.mkShell {
          buildInputs = [
            rust
            pkgs.cargo-fuzz
            pkgs.afl
          ];
        };
      };
    };
  };
}
