{lib, ...}: {
  mth.target = {
    system = "x86_64-linux";
    extraConfig = {
      # gcc.arch = "skylake";
      # gcc.tune = "skylake";
    };
  };

  mth.kernel.config = with lib.kernel; {
    EXPERT = yes;
    BLOCK = yes;
    NET_9P = no;

    # hardening
    CFI_CLANG = yes;
    LTO_NONE = no;
    LTO_CLANG_THIN = yes;
  };
}
