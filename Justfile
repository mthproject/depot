build-kernel PLATFORM:
    nix build .#{{ PLATFORM }}.config.mth.kernel.build --log-format internal-json -v |& nom --json
reconfigure-kernel PLATFORM:
    nix run .#{{ PLATFORM }}.config.mth.dev.kernel.reconfigureKernel -L
reconfigure-kernel-from-scratch PLATFORM:
    nix run .#{{ PLATFORM }}.config.mth.dev.kernel.reconfigureKernelFromScratch -L
build-initramfs PLATFORM:
    nix build .#{{ PLATFORM }}.config.mth.initramfs.final --log-format internal-json -v |& nom --json
build-mth-package PLATFORM PACKAGE:
    nix build .#{{ PLATFORM }}._module.args.pkgs.{{ PACKAGE }} --log-format internal-json -v |& nom --json
build-mth-package-host PACKAGE:
    nix build .#dev._module.args.pkgs.pkgsBuildBuild.mth.{{ PACKAGE }} --log-format internal-json -v |& nom --json