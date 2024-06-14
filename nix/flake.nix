{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    unstable,
    ...
  } @ inputs: let
    unstableOverlay = final: prev: {unstable = unstable.legacyPackages.${prev.system};};
    # Overlays-module makes "pkgs.unstable" available in configuration.nix
    unstableModule = {
      config,
      pkgs,
      ...
    }: {nixpkgs.overlays = [unstableOverlay];};
  in {
    nixosConfigurations.ramp-rat = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        unstableModule
        ./configuration.nix
      ];
    };
  };
}
