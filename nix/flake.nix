{
  description = "Ramp Rat Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    # Re-import unstable with the stable tree's config so allowUnfree applies to both
    unstableOverlay = final: prev: {
      unstable = import unstable {
        system = prev.stdenv.hostPlatform.system;
        config = prev.config;
      };
    };
    unstableModule = {nixpkgs.overlays = [unstableOverlay];};
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;

    nixosConfigurations.ramp-rat = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        unstableModule
        ./configuration.nix
      ];
    };
  };
}
