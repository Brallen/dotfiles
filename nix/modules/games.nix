{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    pkgs.lunar-client # Minecraft
    pkgs.jdk # Java needed for Minecraft
  ];
}
