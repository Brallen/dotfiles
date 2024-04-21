{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    erlang
    unstable.gleam
    gcc
    nodejs
    rustup
    yarn
  ];
}
