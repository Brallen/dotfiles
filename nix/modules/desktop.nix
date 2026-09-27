{
  pkgs,
  lib,
  ...
}: let
  wine-staging = unstable.wineWow64Packages.full.override {
    wineRelease = "staging";
    mingwSupport = true;
  };

  # winetricks' arch-detection still expects a separate `wine64` binary,
  # which the unified wow64 staging build no longer ships.
  # This symlinks it back in so winetricks (and anything else that greps
  # for `wine64`) keeps working.
  # NOTE: if Battle.net/WoW silently fails to launch after a wine update,
  # check `wine --version` for an architecture jump and consider recreating
  # $HOME/.wine-battlenet from scratch (wineboot + winetricks dxvk + reinstall).
  wine-staging-with-wine64 = pkgs.symlinkJoin {
    name = "wine-wow64-staging-with-wine64";
    paths = [wine-staging];
    postBuild = ''
      ln -sf $out/bin/wine $out/bin/wine64
    '';
  };
in {
  environment.systemPackages = with pkgs; [
    instawow
    vlc
    wine-staging-with-wine64
    unstable.winetricks
  ];

  programs.firefox.enable = true;
}
