{
  description = "nix-pi-3b machine configuration";
  inputs.nix-bitcoin.url = "github:chrisguida/nix-bitcoin/no-err-zero-feerate";
#  inputs.nix-bitcoin.url = "github:fort-nix/nix-bitcoin";
  inputs.nixpkgs.follows = "nix-bitcoin/nixpkgs";
  outputs = { self, nix-bitcoin, nixpkgs }: {
    nixosConfigurations = {
      nix-pi-3b = nix-bitcoin.inputs.nixpkgs.lib.nixosSystem {
        modules = [
          nix-bitcoin.nixosModules.default
          ./configuration.nix
        ];
      };
    };
    images = {
      pi = self.nixosConfigurations.pi.config.system.build.sdImage;
    };
  };
}

