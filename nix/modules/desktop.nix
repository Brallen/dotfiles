{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome-browser-connector
    gnome.gnome-tweaks
    tailscale
  ];
}
