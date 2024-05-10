{builderSystem}: thirdparty @ {nixpkgs, ...}: let
  lib = nixpkgs.lib;

  platforms =
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
in
  lib.mapAttrs (
    platformName: _:
      lib.evalModules {
        specialArgs = {
          inherit thirdparty builderSystem;
        };
        modules = [
          ../modules/nixpkgs.nix
          ../modules/kernel.nix
          ../modules/initramfs.nix
          ./${platformName}/default.nix
        ];
      }
  )
  platforms
