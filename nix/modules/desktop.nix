{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  programs.firefox.enable = true;
}
