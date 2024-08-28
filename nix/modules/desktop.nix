{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    unstable.zed-editor
    unstable.tailscale
  ];
}
