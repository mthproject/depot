build-kernel PLATFORM:
    nix build .#{{ PLATFORM }}.config.mth.kernel.packages.kernel --log-format internal-json -v |& nom --json
build-initramfs PLATFORM:
    nix build .#{{ PLATFORM }}.config.mth.initramfs.final --log-format internal-json -v |& nom --json
build-mth-package PLATFORM PACKAGE:
    nix build .#{{ PLATFORM }}._module.args.pkgs.{{ PACKAGE }} --log-format internal-json -v |& nom --json
build-mth-package-host PACKAGE:
    nix build .#dev._module.args.pkgs.pkgsBuildBuild.mth.{{ PACKAGE }} --log-format internal-json -v |& nom --json