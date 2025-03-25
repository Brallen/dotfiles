{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    firefox
    gnome-browser-connector
    gnome.gnome-tweaks
    tailscale
  ];

  programs.firefox.enable = true;
}
