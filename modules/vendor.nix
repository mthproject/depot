{
  lib,
  ...
}: {
  options = with lib; {
    mth.platform = {
      name = mkOption {
        type = types.str;
      };
    };
  };
}