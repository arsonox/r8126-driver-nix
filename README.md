# Realtek r8126 driver (as NixOS Module)

This NixOS module provides support for the Realtek r8126 network driver. It allows you to easily add the driver to your NixOS configuration.

## Usage

To use this module, add the following to your NixOS configuration flake:
```nix
{
  inputs.r8126-driver = {
        url = "git+file:../path/to/this/repo";
        inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

Then add something like the following to your `nixosConfigurations` outputs:

```nix
{
  outputs = {self, nixpkgs, ...}@inputs: {
    nixosConfigurations = {
      your-hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # make onboard ethernet nic work!
          inputs.r8126-driver.nixosModules.r8126
          {
            boot.kernelModules = [ "r8126" ];
            # also (optionally) make this module available 
            # in early boot (useful for remote unlocking 
            # luks partitions)
            boot.initrd.availableKernelModules = [ "r8126" ];
          }
        ];
      };
    }
  };
}
```

## Driver Repository

The underlying driver code is maintained in this repository:
[https://github.com/awesometic/realtek-r8126-dkms](https://github.com/awesometic/realtek-r8126-dkms)
