{lib, ...}: {
  mth.target = {
    system = "x86_64-linux";
    extraConfig = {
      # gcc.arch = "skylake";
      # gcc.tune = "skylake";
    };
  };
  
  imports = [ ./kernel.nix ];

  # mth.kernel.config = with lib.kernel; {
  #   EXPERT = yes;
  #   BLOCK = yes;
  #   NET_9P = no;

  #   # hardening
  #   CFI_CLANG = yes;
  #   #CONFIG_LTO_CLANG_THIN = yes;
  # };
}
