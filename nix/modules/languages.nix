{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    erlang
    gleam
    gcc
    nodejs
    rustup
    yarn
  ];
}
