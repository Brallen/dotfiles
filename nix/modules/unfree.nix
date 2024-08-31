{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    discord
    steam
    lunar-client # Minecraft
    jdk # Java for Minecraft
    keymapp
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
