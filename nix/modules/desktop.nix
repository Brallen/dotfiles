{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    tailscale
  ];
}
