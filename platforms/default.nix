thirdparty @ {nixpkgs, ...}: let
  lib = nixpkgs.lib;

  platforms =
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.);
in
  lib.mapAttrs (
    platformName: _:
      lib.evalModules {
        specialArgs = {
          inherit thirdparty;
          builderSystem = "x86_64-linux";
        };
        modules = [
          ../modules/nixpkgs.nix
          ../modules/kernel.nix
          ../modules/initramfs.nix
          ../modules/unifiedimage.nix
          ./${platformName}/default.nix
        ];
      }
  )
  platforms
