{
  description = "Flake defining a NixOS module for the Realtek r8126 kernel driver";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosModules.r8126 = import ./modules/drivers/r8126.nix;
    nixosModules.default = self.nixosModules.r8126;
  };

}