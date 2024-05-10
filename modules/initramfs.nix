{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mth.initramfs;
in {
  options = with lib; {
    mth.initramfs = {
      final = mkOption {
        type = types.package;
      };
    };
  };

  config = {
    mth.initramfs.final = pkgs.makeInitrdNG {
      contents = [
        {
          object = pkgs.hello;
          symlink = "/hello";
        }
      ];
    };
  };
}
