{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    instawow
    tailscale
    vlc
    (unstable.wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    unstable.winetricks
  ];

  programs.firefox.enable = true;
}
