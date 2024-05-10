# This is meta-platform that used to get nixpkgs and probably other stuff in the future from the builder's perspective.
#
{builderSystem, ...}: {
  mth.target = {
    system = builderSystem;
  };
}
