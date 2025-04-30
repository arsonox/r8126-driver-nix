# see https://nixos.wiki/wiki/Linux_kernel and specifically the
# "Out-of-tree kernel modules" section
{config, pkgs, lib, ... }:
let
  pkgs_r8126 = config.boot.kernelPackages.callPackage ../../pkgs/drivers/r8126.nix {
    inherit (pkgs) lib;
  };
in {
  boot.extraModulePackages = [ pkgs_r8126 ];
}