{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tailscale-systray
  ];

  # Enable Tailscale VPN
  services.tailscale = {
    enable = true;
    # Lets tailscale-systray manage the connection without sudo
    extraSetFlags = ["--operator=bart"];
  };
}
