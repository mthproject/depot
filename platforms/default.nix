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
          ../modules/vendor.nix
          {
            mth.platform.name = platformName;
          }
          ./${platformName}/default.nix
        ];
      }
  )
  platforms
