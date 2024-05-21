{lib, ...}: {
  mth.target = {
    system = "x86_64-linux";
    extraConfig = {
      # gcc.arch = "skylake";
      # gcc.tune = "skylake";
    };
  };
  
  imports = [ ./kernel.nix ];
}
