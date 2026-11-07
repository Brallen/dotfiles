{
  pkgs,
  lib,
  ...
}: let
  wine-staging = pkgs.unstable.wineWow64Packages.full.override {
    wineRelease = "staging";
    mingwSupport = true;
  };

  wine-staging-with-wine64 = pkgs.symlinkJoin {
    name = "wine-wow64-staging-with-wine64";
    paths = [wine-staging];
    postBuild = ''
      ln -sf $out/bin/wine $out/bin/wine64
    '';
  };

  # Resolves `wine` from PATH at launch, so no store path is recorded anywhere.
  battlenet = pkgs.writeShellScriptBin "battlenet" ''
    export WINEPREFIX="$HOME/.wine-battlenet"
    # Stop Wine from writing its own menu entries (they embed store paths).
    export WINEDLLOVERRIDES="winemenubuilder.exe=d"
    exec wine "$WINEPREFIX/drive_c/Program Files (x86)/Battle.net/Battle.net Launcher.exe" "$@"
  '';

  battlenetDesktop = pkgs.makeDesktopItem {
    name = "battlenet";
    desktopName = "Battle.net";
    exec = "battlenet";
    categories = ["Game"];
  };
in {
  environment.systemPackages = with pkgs; [
    instawow
    vlc
    wine-staging-with-wine64
    unstable.winetricks
    battlenet
    battlenetDesktop
  ];

  programs.firefox.enable = true;
}
