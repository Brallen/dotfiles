{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    tailscale-systray
  ];

  # Enable Tailscale VPN
  services.tailscale.enable = true;
}
