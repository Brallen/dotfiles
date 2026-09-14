{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    instawow
    vlc
    (unstable.wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    })
    unstable.winetricks
  ];

  programs.firefox.enable = true;
}
