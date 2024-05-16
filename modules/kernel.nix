{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mth.kernel;
in {
  options = with lib; {
    mth.dev.kernel = {
      kernelWithMenuConfig = mkOption {
        type = types.package;
      };
    };
    mth.kernel = {
      packages = mkOption {
        default = pkgs.linuxPackages_hardened;
        type = types.raw;
        apply = kernelPackages:
          kernelPackages.extend (self: super: {
            kernel =
              (super.kernel)
              .override (originalArgs: {
                kernelPatches = originalArgs.kernelPatches or [];
                structuredExtraConfig = cfg.config;
                enableCommonConfig = false;
              });
          });
        # We don't want to evaluate all of linuxPackages for the manual
        # - some of it might not even evaluate correctly.
        defaultText = literalExpression "pkgs.linuxPackages_hardened";
        description = lib.mdDoc ''
          This option allows you to override the Linux kernel used by
          methane.
        '';
      };
      config = mkOption {
        default = {};
        type = types.attrsOf (types.submodule {
          options = {
            tristate = mkOption {
              type = types.enum ["y" "n" "m"];
            };
            optional = mkOption {
              type = types.bool;
            };
          };
        });
      };
    };
  };

  config = {
    # nix develop .#x64-efi.config.mth.dev.kernel.kernelWithMenuConfig
    mth.dev.kernel.kernelWithMenuConfig = cfg.packages.kernel.overrideAttrs (old:
      with pkgs.pkgsBuildHost; {
        nativeBuildInputs = old.nativeBuildInputs ++ [pkg-config ncurses];
      });
  };
}
